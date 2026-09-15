---
title: Headless Claude CLI Runbook (401s, launchd pipelines)
project: Knowledge_Base
type: runbook
updated: 2026-09-13
tags: [runbook, claude-cli, launchd, headless, automation]
---

# Headless `claude -p` Runbook

For any unattended pipeline that shells out to `claude -p` (dropship pipeline, future launchd/NAS agents).

## Fastest diagnostic: headless calls fail / pipeline log stops dead

Run this ONE check first — token expiry is the most likely cause and env-var theories waste time:

```bash
security find-generic-password -s "Claude Code-credentials" -w | jq '.claudeAiOauth.expiresAt'
# compare to: date +%s  (keychain value is in MILLIseconds — drop 3 digits)
```

- **Expired** → the CLI returns `401 Invalid authentication credentials` on every `-p` call and headless mode cannot re-auth itself. Fix: open Terminal → `claude` → `/login` → done. Interactive login refreshes the keychain; headless runs work again immediately (no reload of launchd needed if the job self-retries).
- Not expired → then check env contamination (running nested inside a Claude session) and the job's `PATH`.

Facts learned 2026-07-02 (dropship pipeline install):
- The 401 happens even with a fully scrubbed `env -i` — it is the **stored credential**, not session env vars, when the keychain token is expired.
- With `--output-format json`, the CLI **exits non-zero AND prints the error JSON** on API errors. Under `set -euo pipefail` + command substitution that kills the script with an EMPTY log. Wrap calls: capture output, `jq -r '.is_error'` / `.result`, and write the message into the run log before exiting.
- LaunchAgents run in the logged-in user session → keychain is unlocked → `claude` auth works from launchd once the token is valid.

## macOS launchd shell-pipeline gotchas (bit us on install)

- **`tac` does not exist on macOS** (GNU coreutils). Use `tail -r`. A `tac` inside `<(...)` process substitution fails SILENTLY — empty output, not a crash — so gates read empty history forever.
- Plist `EnvironmentVariables.PATH` must include the claude install dir (here `~/.npm-global/bin`); Homebrew on Apple Silicon is `/opt/homebrew/bin` and is NOT in default paths.
- Don't `grep` LLM free text loosely for control flow: `GO` is a substring of `NO-GO`; `-i "ADVANCE"` matches "no candidates advanced". Match structural tokens (`\bADVANCE\b` case-sensitive, `verdict[^a-zA-Z0-9]*GO\b`) and have the SCRIPT write deterministic markers (date headings) rather than trusting the model's formatting.
- Marker-file dedup (`.last-run` written only on success) + `RunAtLoad` is a sound self-retry pattern — but guard per-stage appends so a same-day retry doesn't duplicate earlier stages' output (fake-persistence corruption).

## New failure mode (2026-09-13): refresh token itself expires, not just the access token — 8 straight weekly failures, silent

The `~/Claude/Projects/side business/Rust & Rainbow/run_welra_assessment.sh` launchd job (fires every Sunday 9am, invokes `claude --print --dangerously-skip-permissions`) failed **8 of 9 consecutive Sundays** (2026-07-19 through 2026-09-06) with `Failed to authenticate: OAuth session expired and could not be refreshed` — a different, worse error than the plain 401 documented above. The keychain diagnostic in this runbook only checks `expiresAt` on the short-lived access token; it says nothing about whether the underlying **refresh token** is still valid. When the refresh token itself lapses, the access token can't self-renew, headless calls fail every time, and — because this job only logs to a local file (`welra_assessment.log`) that nothing else reads — **it produced zero visible signal for two months.** This is exactly why the automated Sunday review silently stopped running real checks after 2026-07-12.

**How it silently self-resolved:** by 2026-09-13 the CLI was authenticating again with no explicit `/login` logged anywhere. The most likely mechanism: any *interactive* `claude` session (Claude Code opened normally, not headless) re-establishes/refreshes the stored credential as a side effect of normal use. A refresh token appears to need periodic interactive use to stay alive — pure headless/cron usage alone does not keep it refreshed indefinitely.

**Fastest diagnostic (do this before assuming it's just a plain expired-access-token 401):**
```bash
tail -30 "/Users/ryannortham/Claude/Projects/side business/Rust & Rainbow/welra_assessment.log"
```
If you see `Failed to authenticate: OAuth session expired and could not be refreshed` (not a `401 Invalid authentication credentials`), this is the refresh-token variant — `/login` fixes it immediately, but so does just using Claude Code interactively for anything else.

**The real fix is detection, not the login step itself:** nothing was watching this log, so 8 failures cost 2 months of "clean" Sunday reviews that were actually never running. Until a proper alert exists, the cheapest mitigation is: **any time Ryan opens an interactive Claude Code session, that's enough to keep the refresh token alive for the following week's cron** — so an extended stretch (2+ weeks) without opening Claude Code interactively at all is the actual risk window for every headless launchd job on this Mac (Sunday assessment, dropship pipeline, amazon-review-agent), not just this one.

## Related
[[Projects/Dropship_Pipeline/State]] · [[Knowledge_Base/NAS_SSH_Runbook]]
