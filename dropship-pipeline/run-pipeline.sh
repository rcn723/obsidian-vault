#!/bin/bash
# Daily driver for the AI dropship idea pipeline.
# Chains 4 Claude Code headless calls, appends to log files, prevents
# double-runs on the same day (needed because the launchd job also fires
# on login, not just on schedule).

set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DIR"

TODAY="$(date +%F)"
MARKER=".last-run"

if [[ -f "$MARKER" && "$(cat "$MARKER")" == "$TODAY" ]]; then
  echo "Already ran today ($TODAY). Skipping."
  exit 0
fi

mkdir -p logs
LOGFILE="logs/pipeline-run-$TODAY.log"

echo "=== Dropship pipeline run: $TODAY ===" | tee "$LOGFILE"

# --- Agent 1: Trend Scanner ---
echo "[1/4] Running trend scanner..." | tee -a "$LOGFILE"
AGENT1_PROMPT="$(cat agents/01-trend-scanner.md)"
AGENT1_OUT="$(claude -p "$AGENT1_PROMPT" \
  --allowedTools "WebSearch,WebFetch" \
  --max-turns 15 \
  --output-format json | jq -r '.result')"

{
  echo ""
  echo "$AGENT1_OUT"
} >> scan-log.md
echo "Appended to scan-log.md" | tee -a "$LOGFILE"

# --- Gate: persistence check (last 3 daily entries) ---
LAST3="$(awk '/^## /{c++} c<=3' <(tac scan-log.md) | tac)"
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

AGENT2_OUT="$(claude -p "$AGENT2_PROMPT" \
  --allowedTools "WebSearch" \
  --max-turns 15 \
  --output-format json | jq -r '.result')"

{
  echo ""
  echo "$AGENT2_OUT"
} >> feasibility-log.md
echo "Appended to feasibility-log.md" | tee -a "$LOGFILE"

# Only continue if at least one candidate advanced
if ! echo "$AGENT2_OUT" | grep -qi "ADVANCE"; then
  echo "No candidates advanced today. Stopping here." | tee -a "$LOGFILE"
  echo "$TODAY" > "$MARKER"
  exit 0
fi

# --- Agent 3: Plan Builder ---
echo "[3/4] Building plan(s)..." | tee -a "$LOGFILE"
AGENT3_PROMPT="$(cat agents/03-plan-builder.md)

Candidates that advanced today:

$AGENT2_OUT"

AGENT3_OUT="$(claude -p "$AGENT3_PROMPT" \
  --allowedTools "WebSearch,WebFetch" \
  --max-turns 20 \
  --output-format json | jq -r '.result')"

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

AGENT4_OUT="$(claude -p "$AGENT4_PROMPT" \
  --max-turns 15 \
  --output-format json | jq -r '.result')"

{
  echo ""
  echo "$AGENT4_OUT"
} >> verdicts-log.md
echo "Appended to verdicts-log.md" | tee -a "$LOGFILE"

# Notify if anything hit GO
if echo "$AGENT4_OUT" | grep -q "GO" && ! echo "$AGENT4_OUT" | grep -qi "NO-GO"; then
  osascript -e 'display notification "A candidate hit GO in verdicts-log.md. Review before spending anything." with title "Dropship Pipeline"' || true
fi

echo "$TODAY" > "$MARKER"
echo "=== Run complete ===" | tee -a "$LOGFILE"
