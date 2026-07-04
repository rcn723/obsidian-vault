#!/bin/bash
# Daily driver for the AI dropship idea pipeline.
# Chains 4 Claude Code headless calls, appends to log files, prevents
# double-runs on the same day (needed because the launchd job also fires
# on login, not just on schedule).
#
# Modes:
#   (default)        Full pipeline with persistence gate and date dedup.
#   --mode generate  Skip agents 1+2, run plan builder directly against
#                    today's scan entry (manual override for the screener
#                    persistence gate).

set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DIR"

TODAY="$(date +%F)"
MARKER=".last-run"
GENERATE_MARKER=".last-generate"
MODE="default"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --mode)
      MODE="$2"
      shift 2
      ;;
    --force)
      rm -f "$GENERATE_MARKER"
      shift
      ;;
    *)
      echo "Unknown argument: $1" >&2
      exit 1
      ;;
  esac
done

# Per-agent model selection. Scanner and screener are high-volume,
# formulaic stages (search + report against fixed criteria) — Haiku handles
# them at a fraction of the token cost. Plan builder and validator do the
# open-ended reasoning where a stronger model changes the outcome.
MODEL_SCANNER="haiku"
MODEL_SCREENER="haiku"
MODEL_PLANNER="sonnet"
MODEL_VALIDATOR="sonnet"

# Wraps a headless claude call: on failure, writes the actual error into the
# run log instead of dying silently (a 401/expired-auth failure is otherwise
# invisible in an unattended run). Also logs per-call cost.
run_claude() {
  local raw status=0
  raw="$(claude -p "$@" --output-format json)" || status=$?
  # The CLI exits non-zero on API errors but still prints the error JSON,
  # so try to extract the real message either way.
  if [[ $status -ne 0 || "$(jq -r '.is_error // false' <<<"$raw" 2>/dev/null)" == "true" ]]; then
    local msg
    msg="$(jq -r '.result // empty' <<<"$raw" 2>/dev/null)"
    echo "claude call failed (exit $status): ${msg:-no error detail}" >>"$LOGFILE"
    return 1
  fi
  echo "cost: \$$(jq -r '.total_cost_usd' <<<"$raw")" >>"$LOGFILE"
  jq -r '.result' <<<"$raw"
}

mkdir -p logs
LOGFILE="logs/pipeline-run-$TODAY.log"

# --mode generate: skip the persistence gate and date dedup, run plan
# builder + validator directly against today's scan entry.
if [[ "$MODE" == "generate" ]]; then
  if [[ -f "$GENERATE_MARKER" && "$(cat "$GENERATE_MARKER")" == "$TODAY" ]]; then
    echo "Already ran --mode generate today ($TODAY). Use --force to override." | tee "$LOGFILE"
    exit 0
  fi

  echo "=== Dropship pipeline run: $TODAY (mode: generate) ===" | tee "$LOGFILE"

  TODAY_SCAN="$(awk "/^## $TODAY/{found=1} found{print}" scan-log.md)"
  if [[ -z "$TODAY_SCAN" ]]; then
    echo "No scan entry for $TODAY in scan-log.md. Run the pipeline normally first." | tee -a "$LOGFILE"
    exit 1
  fi

  echo "[3/4] Building plan(s) from today's scan (persistence gate bypassed)..." | tee -a "$LOGFILE"
  AGENT3_PROMPT="$(cat agents/03-plan-builder.md)

NOTE: These candidates were selected directly from today's trend scan
without passing through the multi-day persistence screener. Treat that
as a known caveat — flag any candidates that look like a one-day spike.

Candidates from today's scan:

$TODAY_SCAN"

  AGENT3_OUT="$(run_claude "$AGENT3_PROMPT" \
    --model "$MODEL_PLANNER" \
    --allowedTools "WebSearch,WebFetch" \
    --max-turns 20)"

  {
    echo ""
    echo "$AGENT3_OUT"
  } >> plans-log.md
  echo "Appended to plans-log.md" | tee -a "$LOGFILE"

  echo "[4/4] Running validator..." | tee -a "$LOGFILE"
  AGENT4_PROMPT="$(cat agents/04-validator.md)

Plan(s) to validate:

$AGENT3_OUT"

  AGENT4_OUT="$(run_claude "$AGENT4_PROMPT" \
    --model "$MODEL_VALIDATOR" \
    --allowedTools "" \
    --max-turns 15)"

  {
    echo ""
    echo "$AGENT4_OUT"
  } >> verdicts-log.md
  echo "Appended to verdicts-log.md" | tee -a "$LOGFILE"

  if echo "$AGENT4_OUT" | grep -qiE 'verdict[^a-zA-Z0-9]*GO\b'; then
    osascript -e 'display notification "A candidate hit GO in verdicts-log.md. Review before spending anything." with title "Dropship Pipeline"' || true
  fi

  echo "$TODAY" > "$GENERATE_MARKER"
  echo "=== Run complete ===" | tee -a "$LOGFILE"
  exit 0
fi

if [[ -f "$MARKER" && "$(cat "$MARKER")" == "$TODAY" ]]; then
  echo "Already ran today ($TODAY). Skipping."
  exit 0
fi

echo "=== Dropship pipeline run: $TODAY ===" | tee "$LOGFILE"

# --- Agent 1: Trend Scanner ---
# Skip if today's entry already exists: a failure in a later stage leaves no
# marker, and a same-day retry would otherwise append a duplicate scan entry,
# which the persistence gate would read as fake cross-day persistence.
if [[ -f scan-log.md ]] && grep -q "^## $TODAY" scan-log.md; then
  echo "[1/4] Scan entry for $TODAY already exists, skipping scanner." | tee -a "$LOGFILE"
else
  echo "[1/4] Running trend scanner..." | tee -a "$LOGFILE"
  AGENT1_PROMPT="$(cat agents/01-trend-scanner.md)

The '## <date>' heading is appended by the calling script — output only the
table and notes, no heading, no preamble."
  AGENT1_OUT="$(run_claude "$AGENT1_PROMPT" \
    --model "$MODEL_SCANNER" \
    --allowedTools "WebSearch,WebFetch" \
    --max-turns 15)"

  {
    echo ""
    echo "## $TODAY"
    echo ""
    echo "$AGENT1_OUT"
  } >> scan-log.md
  echo "Appended to scan-log.md" | tee -a "$LOGFILE"
fi

# --- Gate: persistence check (last 3 daily entries) ---
# tail -r, not tac: tac is GNU coreutils and doesn't exist on stock macOS
LAST3="$(awk '/^## /{c++} c<=3' <(tail -r scan-log.md) | tail -r)"
if [[ -z "$LAST3" ]]; then
  echo "Not enough history yet for feasibility screening. Exiting." | tee -a "$LOGFILE"
  echo "$TODAY" > "$MARKER"
  exit 0
fi

# --- Agent 2: Feasibility Screener ---
echo "[2/4] Running feasibility screener..." | tee -a "$LOGFILE"
AGENT2_PROMPT="$(cat agents/02-feasibility-screener.md)

Here are the last 3 daily scan entries:

$LAST3"

AGENT2_OUT="$(run_claude "$AGENT2_PROMPT" \
  --model "$MODEL_SCREENER" \
  --allowedTools "WebSearch" \
  --max-turns 15)"

{
  echo ""
  echo "$AGENT2_OUT"
} >> feasibility-log.md
echo "Appended to feasibility-log.md" | tee -a "$LOGFILE"

# Only continue if at least one candidate advanced. Case-sensitive whole-word
# match on the uppercase decision token — a case-insensitive substring match
# also hits prose like "no candidates advanced" and runs the plan builder on
# nothing.
if ! echo "$AGENT2_OUT" | grep -qE '\bADVANCE\b'; then
  echo "No candidates advanced today. Stopping here." | tee -a "$LOGFILE"
  echo "$TODAY" > "$MARKER"
  exit 0
fi

# --- Agent 3: Plan Builder ---
echo "[3/4] Building plan(s)..." | tee -a "$LOGFILE"
AGENT3_PROMPT="$(cat agents/03-plan-builder.md)

Candidates that advanced today:

$AGENT2_OUT"

AGENT3_OUT="$(run_claude "$AGENT3_PROMPT" \
  --model "$MODEL_PLANNER" \
  --allowedTools "WebSearch,WebFetch" \
  --max-turns 20)"

{
  echo ""
  echo "$AGENT3_OUT"
} >> plans-log.md
echo "Appended to plans-log.md" | tee -a "$LOGFILE"

# --- Agent 4: Validator / Devil's Advocate ---
echo "[4/4] Running validator..." | tee -a "$LOGFILE"
AGENT4_PROMPT="$(cat agents/04-validator.md)

Plan(s) to validate:

$AGENT3_OUT"

AGENT4_OUT="$(run_claude "$AGENT4_PROMPT" \
  --model "$MODEL_VALIDATOR" \
  --allowedTools "" \
  --max-turns 15)"

{
  echo ""
  echo "$AGENT4_OUT"
} >> verdicts-log.md
echo "Appended to verdicts-log.md" | tee -a "$LOGFILE"

# Notify if any plan's verdict line is GO. Match "verdict ... GO" specifically:
# plain grep "GO" also matches the GO inside "NO-GO", and suppressing on any
# NO-GO in the output would silence mixed days (one GO + one NO-GO).
if echo "$AGENT4_OUT" | grep -qiE 'verdict[^a-zA-Z0-9]*GO\b'; then
  osascript -e 'display notification "A candidate hit GO in verdicts-log.md. Review before spending anything." with title "Dropship Pipeline"' || true
fi

echo "$TODAY" > "$MARKER"
echo "=== Run complete ===" | tee -a "$LOGFILE"
