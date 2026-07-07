---
title: Automation Architecture — every scheduled agent, where it runs, and how it fails
project: cross-project
type: reference
updated: 2026-07-06
tags: [automation, architecture, scheduled-tasks, launchd, nas]
---

# Automation Architecture

> One page of truth for everything that runs without Ryan asking. Companion: [[Knowledge_Base/Claude_Usage_SOP]]. Update this whenever an automation is added, moved, or rescheduled.

## Design principles (all automations)

1. **Stage-and-notify, never auto-deploy/auto-send.** Autonomous runs prepare; Ryan approves outward-facing actions.
2. **Quiet by default.** Notify only when something needs approval, a reply arrived, or something is broken. Exception: `monday-kickoff`, whose notification *is* the deliverable.
3. **Headless-safe.** No `input()`/TTY prompts; wrappers exit non-zero on failure and log real errors (empty log + 0 exit = masked crash — the R&R generate bug).
4. **Single-home tokens.** A credential is refreshed by exactly one machine's job (double-homing = double-post or fight over refresh).
5. **State lives in files, not sessions.** Every recurring run reads its state doc first, writes it last (`Growth_Pipeline.md`, markers, logs).
6. **Every automation has a watcher.** The `sunday-review` skill is the meta-monitor: it verifies each row below actually ran this week.

## Inventory

### Claude scheduled tasks (run inside the Claude app on the Mac; run on next launch if app was closed)
| Task | Schedule | What it does | State/output |
|---|---|---|---|
| `welra-growth-pipeline` | 8:00 + 20:00 daily (cron `0 8,20 * * *`) | Stage 0 execution-debt gate (≥5 stalled Ryan items → maintenance mode, no new ideas) → creative → validator → operator; stage-and-notify | [[Projects/Welra/Growth_Pipeline]], Tasks/State/Worklog |
| `monday-kickoff` | Mon 7:30am (cron `30 7 * * 1`) | Read-only brief: this week's 3 actions from `_RYAN_TODO.md`, stalled count, deadlines ≤14d, vault-staleness flag | Notification only |
| (one-time tasks) | as needed | Pattern: post-deploy delivery checks, deadline reminders (`etsy-api-resubmit-reminder`, `welra-cron-check`, `welra-rr-first-report-delivery-check` — all fired, disabled) | — |

### Mac launchd
| Job | Schedule | What it does | Notes |
|---|---|---|---|
| `com.rustandrainbow.welra_assessment` | Sun 9:00am | Headless `claude -p` weekly assessment via `run_welra_assessment.sh` | Should invoke the `sunday-review` skill (see Change Log below) |
| `com.rustandrainbow.generate` | Weekly | R&R design generation (Ideogram + rembg) | Mac-bound until Phase 2b ([[Knowledge_Base/NAS_RR_Migration_Runbook]]) |
| `com.rustandrainbow.refresh_token` | RunAtLoad + every 45 days (`StartInterval` 3888000) — NOT weekly | Legacy IG token refresh | ⚠️ Violates single-home principle #4: the NAS supervisor also refreshes this token weekly. Recommend disabling the Mac job (Ryan decision, tracked in _RYAN_TODO) |
| `com.ryan.dropship-pipeline` | Daily 7:00am | 4-agent headless-claude idea pipeline | Marker dedup; failure mode = keychain token expiry ([[Knowledge_Base/Headless_Claude_Runbook]]) |
| `com.ryannortham.amazon-review-agent` | Sun 9:00am | Amazon review agent | ❌ **BROKEN since ~2026-05-30**: every run exits 78 — macOS TCC blocks launchd's bash from `~/Desktop` ("Operation not permitted" in agent.log). Fix = relocate the agent out of `~/Desktop` (e.g. `~/Claude/`) + repoint the plist, or grant Full Disk Access. Ryan decision in _RYAN_TODO |

### Synology NAS (192.168.1.2, always-on) — `rr-supervisor.py` (user-space scheduler, nohup, flock, DSM boot task)
| Job | Schedule | What it does |
|---|---|---|
| R&R market | M/W/F 10:00 | Post design to IG/TikTok/Pinterest via Zernio |
| R&R report | Mon 7:00 | Weekly performance report |
| R&R suggest | Mon 8:00 | Suggestions run |
| R&R monitor | Sun 23:00 | Listing monitor (report-only when headless — never auto-delete) |
| IG token refresh | Weekly | Refreshes `META_ACCESS_TOKEN` (`META_FB_PAGE_TOKEN` does NOT auto-refresh — manual, tracked in TODO when near expiry) |
| Stock agent | Daily 14:00 PDT | Momentum-only paper trading (`paper_mode: true`; go-live gate = [[Projects/Stock_Agent/Go_Live_Plan]]) |

Deploy path to NAS: `agent-platform/deploy.sh <agent>`; no sftp — `ssh 'cat > dest' < src`. Platform repo: github.com/rcn723/R-R-private.

### Server-side crons (Railway, Welra API — not Claude automations but monitored by sunday-review)
Weekly report scheduler (Sun 23:00 UTC), hourly report catch-up, trial sweep (hourly), token health, retention (03:00 UTC).

## Failure modes → first diagnostic
- Claude scheduled task didn't run → was the Claude app open? It fires on next launch.
- Headless `claude -p` empty log / 401 → keychain token expiry FIRST: `security find-generic-password -s "Claude Code-credentials"` ([[Knowledge_Base/Headless_Claude_Runbook]]).
- NAS job missed → is `rr-supervisor` running (single instance, heartbeat in its log)? Then [[Knowledge_Base/NAS_SSH_Runbook]].
- R&R post "failed all platforms" → usually Zernio-side, not R&R code; check Zernio status before debugging.
- Welra report missing → Railway **Logs tab**; `email_sent_at` + send-log line, never `status='delivered'`.

## Change log
- **2026-07-06** — `welra-growth-pipeline`: added Stage 0 execution-debt gate (≥5 open Ryan-owned Welra items → maintenance mode); cadence 6h → 2×/day (8:00/20:00); content stage now hard-bans unverifiable first-person anecdotes; removed stale "no Etsy before 6/25" constraint (approved 7/02). Created `monday-kickoff`. `run_welra_assessment.sh` rewritten to a slim launcher that executes the `sunday-review` skill. Documented in this file + SOP.
- **2026-07-06 (PM, adversarial-validator pass)** — Gate counting rules made explicit in the pipeline prompt (unit = one top-level `###` Welra task with ≥1 unchecked box; excludes optional/GR3NB/WAITING/SYSTEM/Claude-executed; ambiguity counts; each run logs count+titles to Growth_Pipeline.md "Queue gate log"). Corrected `refresh_token` schedule (was mislisted "Weekly"). Discovered + recorded: `amazon-review-agent` dead since ~5/30 (TCC), Sunday assessment failed its last 2 runs (6/28 auth 401; 7/05 quoting bug in the OLD prompt — both pre-rewrite). `Project Workflow Guide.md` + `Claude Setup Reference.md` stamped SUPERSEDED (dead `~/Documents/MyVault` path, conflicting close-out procedure).
- **Standing rule:** the first run of any new/rewritten automation is UNPROVEN until it completes once — verify the first execution, don't assume (this doc previously listed a dead job as live).
- **2026-07-06 (evening)** — Amazon review agent relocated `~/Desktop/Claude/amazon-reviews` → `~/Claude/amazon-reviews` (TCC fix; launchd read access proven via one-shot test job; first real run Sun 7/12). Mac `com.rustandrainbow.refresh_token` unloaded + archived (NAS supervisor is now single-home for the IG token). New PreToolUse hook in `~/.claude/settings.json` injects a deploy-gate reminder on any `railway up`/`vercel deploy`/`deploy.sh` Bash command (fires proven live). Curated read-only permission allowlist added at `Desktop/Claude/.claude/settings.json` (24 rules) to cut prompt pauses in scheduled runs.
