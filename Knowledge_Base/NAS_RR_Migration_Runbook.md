---
title: NAS Rust & Rainbow Migration Runbook
project: rust-and-rainbow
type: runbook
updated: 2026-06-23
tags: [nas, rust-and-rainbow, migration, mac-independence, synology, oauth]
---

# NAS Rust & Rainbow Migration Runbook (Phase 2)

> **STATUS 2026-06-23: Phase 2a EXECUTED via the user-space supervisor (not DSM).**
> `rr-supervisor.py` runs on the NAS (admin, nohup, flock, heartbeat) and fires
> market/monitor/report/suggest; the 4 Mac launchd jobs are unloaded + archived.
> Posting is Mac-independent now. The DSM Task Scheduler path below is the **durable
> upgrade** (survives reboots) — adopt it when convenient, OR add the single DSM
> Boot-up Triggered Task that relaunches `rr-supervisor-start.sh`. Check the supervisor:
> `ssh … 'tail /volume1/homes/admin/claude-agents/logs/rr-supervisor.log; ps -ef | grep [r]r-supervisor'`

Goal: make the R&R pipeline **not depend on the MacBook being open**. Stock is already
on the NAS (Phase 1). This is the careful Phase 2 cutover for R&R, which posts to live
Etsy/Instagram/TikTok/Pinterest and holds an OAuth refresh-token that MUST live in one place.

Platform: `~/Claude/agent-platform/` (manifest-driven, tar-over-SSH deploy). See
[[NAS_SSH_Runbook]] for SSH/sync troubleshooting and [[project_nas_agents]].

## The hard constraint: Python 3.8 vs background removal

The NAS is **Python 3.8.12** (Synology DS916+, EOL, can't easily upgrade). `rembg`
(background removal in `--mode generate`) needs **Python ≥3.10** → it will not install
on the NAS. Everything else (`requests`, `python-dotenv`, `anthropic`) is 3.8-safe.

**Therefore split the migration:**

| Mode | NAS-ready now? | Why |
|---|---|---|
| `market` (posting 3×/wk) | ✅ Yes | only needs requests/dotenv; this is the cadence that most needs Mac-independence |
| `monitor` (Sun) | ✅ Yes | Printify orders API only |
| `report` (Mon) | ✅ Yes | requests + anthropic (added to `requirements/rust-rainbow.txt`) |
| `suggest` | ✅ Yes | report-only; pytrends optional |
| `refresh_token` | ✅ Yes — **must move WITH market** | OAuth token single-home (see below) |
| `generate` (Sun 2am) | ❌ Blocked by rembg/Py3.8 | stays on Mac until the transparent-endpoint refactor lands |

## Phase 2a — move posting/monitoring to NAS (safe, high value)

This achieves the core "posting doesn't depend on the Mac" win. As of 2026-06-23 the
agent.py code is already **headless-safe** (the `--mode generate` EOFError crash + the
macOS-only `os.system("open")` were both fixed; market/monitor/report never prompted).

1. **Deploy current code to the NAS** (does NOT schedule anything yet):
   ```
   cd ~/Claude/agent-platform
   ./validate.sh
   ./setup.sh rust-rainbow      # builds py3.8 venv, seeds .env + designs_log.json (preserved on later deploys)
   ./healthcheck.sh rust-rainbow
   ```
2. **OAuth single-home (critical):** the META_ACCESS_TOKEN refresh must run in exactly ONE
   place. Pick the NAS. So when you enable `market` on the NAS you MUST also:
   - Enable `refresh_token` on the NAS (DSM task, every 45 days).
   - **Disable the Mac's** `com.rustandrainbow.refresh_token` AND `com.rustandrainbow.market`
     launchd jobs (move plists to `~/Library/LaunchAgents/.disabled-<date>/`), or both hosts
     will post (double-post) and two refreshers will fight over the token.
   - The NAS `.env` holds the token; refresh writes it there. The same token is ALSO pasted
     into Welra's Instagram card — when it refreshes, Welra still needs the manual update
     (see [[Projects/Rust_and_Rainbow/State]] META token note).
3. **Schedule on the NAS** (Synology has no crontab → DSM Task Scheduler GUI). Uncomment the
   relevant rows in `agent-platform/jobs.conf`, then run `./schedule.sh spec rust-rainbow`
   to print exactly what to type into DSM (Task name, User=admin, schedule, command). Enter
   market/monitor/report/suggest/refresh_token. **Leave `generate` commented.**
4. **Verify** after first NAS market run: check the NAS log (`logs/rust-rainbow.log`) for a
   real "posted" line, and confirm Instagram/TikTok/Pinterest actually received the post.
   Then disable the corresponding Mac launchd jobs.

**Timing caution:** META_ACCESS_TOKEN expires 2026-07-01 (refresh by 6/25). Do NOT do the
OAuth-host cutover in the same window as the manual token refresh — refresh first on the
current host, confirm posting works, then migrate.

## Phase 2a — EXACT cutover commands (status as of 2026-06-23)

**Already done by Claude:** code+`.env`+venv deployed to the NAS (`./setup.sh rust-rainbow`),
healthcheck green, `--mode suggest` and `--mode monitor` both ran on the NAS with exit 0,
`jobs.conf` Phase-2a rows enabled, `anthropic` added to requirements. Two headless `input()`
crashes (generate + monitor) found and fixed. **Only the two root/GUI steps below remain.**

**Step 1 — create the DSM tasks** (run `./schedule.sh spec rust-rainbow` for the live values):
DSM → Control Panel → Task Scheduler → Create → Scheduled Task → User-defined script.
User = `admin` for every task. Commands (NAS time = PDT):
- `agent-rust-rainbow-market`  — Mon/Wed/Fri 10:00 — `/volume1/homes/admin/claude-agents/run-agent.sh rust-rainbow agent.py --mode market --yes`
- `agent-rust-rainbow-monitor` — Sun 23:00 — `… run-agent.sh rust-rainbow agent.py --mode monitor`
- `agent-rust-rainbow-report`  — Mon 07:00 — `… run-agent.sh rust-rainbow agent.py --mode report --yes`
- `agent-rust-rainbow-suggest` — Mon 08:00 — `… run-agent.sh rust-rainbow agent.py --mode suggest`

**Step 2 — disable the 4 Mac launchd jobs that just moved** (do this in the SAME sitting as
Step 1 — if you schedule NAS without disabling Mac you double-post; if you disable Mac
without scheduling NAS nothing posts):
```bash
for j in market monitor report suggest; do
  launchctl unload ~/Library/LaunchAgents/com.rustandrainbow.$j.plist
done
mkdir -p ~/Library/LaunchAgents/.disabled-rr-nas-cutover
mv ~/Library/LaunchAgents/com.rustandrainbow.{market,monitor,report,suggest}.plist \
   ~/Library/LaunchAgents/.disabled-rr-nas-cutover/
# The Mac watchdog checks the Mac's market.log, which goes stale once market runs on the NAS:
crontab -l | grep -v 'watchdog.sh' | crontab -
```
**Keep on the Mac:** `com.rustandrainbow.generate` (rembg/Py3.8 → Phase 2b),
`com.rustandrainbow.refresh_token` (see caveat), `com.rustandrainbow.welra_assessment` (Welra, unrelated).

**Verify after cutover:** on the next Mon/Wed/Fri ~10:00 PDT, confirm Instagram/TikTok/Pinterest
got the post AND `ssh … 'tail logs/rust-rainbow.log'` shows the market run. Then you're Mac-independent for posting.

**refresh_token caveat (token single-home):** `refresh_token` still runs on the Mac, so it
refreshes the token in the *Mac* `.env` — the NAS `.env` won't auto-update. Mitigations:
(a) after the manual 6/25 META refresh, re-run `./setup.sh rust-rainbow` is NOT enough (it
preserves the NAS `.env`) — instead update the NAS `.env` directly, or (b) add a NAS refresh
job: `rust-rainbow | refresh | refresh_meta_token.py | 0 3 1 */1 *` in jobs.conf and disable the
Mac one. Until then, whenever you refresh the META token, also paste it into the NAS `.env`
(`ssh … 'nano /volume1/homes/admin/claude-agents/agents/rust-rainbow/.env'`) and Welra's card.

## Phase 2b — move `generate` to NAS (needs a code refactor first)

rembg can't run on Py3.8. The clean fix is to drop rembg entirely and use **Ideogram 3.0's
native transparent endpoint** (`POST /v1/ideogram-v3/generate-transparent`) — alpha channel
produced during generation, no post-processing, Python-version-agnostic.
Docs: https://developer.ideogram.ai/api-reference/api-reference/generate-transparent-v3

**Do NOT blanket-switch.** The current pipeline deliberately KEEPS backgrounds on
retro/vintage designs (e.g. "Retro Vizsla Poster", hungarian_chaos pillar) — `_has_white_background`
skips removal for intentional colored backgrounds. Forcing transparency everywhere regresses
those. The refactor must be **per-concept**:
- Add a `transparent: bool` field to each concept (the Claude idea generator can set it, or
  infer from the prompt — "transparent background / sticker / t-shirt ready" → true; "retro
  poster / vintage / textured background" → false).
- `transparent=true` → call the v3 transparent endpoint, no rembg.
- `transparent=false` → call the normal v3 endpoint, keep the background.
- Delete `_remove_background` / rembg once both paths are verified.
- **Requires visual QA** (can't be confirmed headlessly) — generate a sample of each path and
  eyeball the alpha before shipping to the live shop.

Once that lands: `rembg` is gone, generate is 3.8-safe, uncomment `generate` in jobs.conf,
add the DSM task, disable the Mac's `com.rustandrainbow.generate`.

## Fastest diagnostic if a NAS R&R run misbehaves
1. `ssh -i ~/.ssh/nas_key -o BatchMode=yes admin@192.168.1.2 'echo OK'` (key health — see [[NAS_SSH_Runbook]]).
2. `tail logs/rust-rainbow.log` on the NAS — the agent's own boot trace + per-mode output.
3. Double-post? Check that the Mac launchd job for that mode is actually disabled
   (`launchctl list | grep rustandrainbow`) — the #1 migration trap is leaving both hosts live.

## Related
- [[project_nas_agents]] · [[reference_nas_ssh_ops]] · [[NAS_SSH_Runbook]]
- [[Projects/Rust_and_Rainbow/State]] · [[Projects/Rust_and_Rainbow/Tasks]]
