---
title: Headless Claude CLI Runbook (401s, launchd pipelines)
project: Knowledge_Base
type: runbook
updated: 2026-07-02
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

## Related
[[Projects/Dropship_Pipeline/State]] · [[Knowledge_Base/NAS_SSH_Runbook]]
