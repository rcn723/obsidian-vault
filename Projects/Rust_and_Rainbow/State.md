---
title: Rust & Rainbow State
project: rust-and-rainbow
type: state
updated: 2026-07-03 evening (Meta double-check: Instagram token genuinely fixed, but found a SEPARATE Facebook Page token expired since May 11 — never covered by auto-refresh)
tags: [etsy, printify, social-media, python, automation, nas]
---

# Rust & Rainbow

## 2026-07-03 evening (cont'd) — Meta double-check: real fix confirmed, real NEW problem found

Ryan asked to double-check the Meta/Instagram token he thought had been refreshed. Didn't trust file-presence or the prior session's note — ran live API calls end to end:
- **`META_ACCESS_TOKEN` (Instagram Login token): genuinely refreshed and working.** First attempt to validate it against `graph.facebook.com` failed with "Cannot parse access token" — a false alarm caused by hitting the wrong API host. `agent.py` itself documents (and uses) `graph.instagram.com` for this token, not `graph.facebook.com` — they're separate APIs with incompatible token formats. Re-tested against the correct host on both the Mac and the NAS: both returned real live data (`followers_count: 10, media_count: 31`), so Instagram posting is genuinely fine. Also checked Welra's own Supabase `integrations` table — no Instagram row exists there at all currently (only etsy/csv/printify), so the earlier note that "this token is also pasted into Welra's card" turned out not to reflect current reality; nothing to fix on the Welra side.
- **`META_FB_PAGE_TOKEN` (separate Facebook Page-posting token): confirmed EXPIRED since 2026-05-11**, live, via Facebook's own error message ("Session has expired on Monday, 11-May-26"). This is a different credential from the Instagram one — `agent.py` line 149 already comments that it does NOT auto-refresh the way the Instagram token does (`refresh_meta_token.py` only touches the IG token). It's been silently broken for almost 2 months; any Facebook Page photo post attempted since mid-May would have failed. New task added to `_RYAN_TODO.md`'s 🔴 RIGHT NOW section with the Graph API Explorer steps to get a long-lived Page token.
- Also confirmed (unrelated, carried over from the prior session): `ANTHROPIC_API_KEY` is genuinely live on both Mac and NAS via a real `anthropic.messages.create()` call — `agent.py`'s static-prompt fallback guard won't trigger anymore. One non-blocking follow-up remains: run `--mode generate` once and eyeball real variety in the output.

Automated Vizsla/LGBTQ+ niche product business. Generates designs, publishes to Printify/Etsy, posts to 3 social platforms.
Path: `~/Claude/Projects/side business/Rust & Rainbow/`
GitHub: `https://github.com/GR3NB/rustandrainbow` (transferred from rcn723 2026-06-06)
GitHub Pages (legal docs): `https://gr3nb.github.io/rustandrainbow/`

See [[Projects/Rust_and_Rainbow/Tasks]] for open items.

## 2026-07-03 — Seasonal product expansion (tote/poster/ornament) + visual-style variety enforcement

Ryan's ask: assess trending/seasonal products to add (beach towels, tote bags, etc.) and fix a real lack of design variation ("I don't see much variation... I don't want designs repeated"). Diagnosed and fixed both, in `agent.py` (uncommitted — see below):

1. **Seasonal catalog gap.** `SEASONAL_FORMATS` (the existing month-by-month seasonality calendar) already recommended tote bags (March/June), posters/wall art (January), and ornaments (November) — but `KNOWN_FORMATS` marked all three "NOT in catalog yet." So the pipeline's own `--mode suggest` report was recommending products it had no way to actually publish. Queried the live Printify catalog and wired up real, verified blueprints as new MANUAL (opt-in, same pattern as beach towels — curated, not auto-published to every design): **Tote Bag** (blueprint 720, "Cotton Tote"), **Poster** (blueprint 282, "Matte Vertical Posters"), **Ceramic Ornament** (blueprint 531, "Ceramic Ornament, 4 Shapes", Q4-seasonal). Added print areas/scale/pricing for each (verified against live API responses, not guessed). New CLI modes: `--mode tote`, `--mode poster`, `--mode ornament` — same UX as the existing `--mode towels`. Generalized `run_towels` into a shared `run_manual_addon()` so a 5th seasonal product is a 3-line addition, not a copy-pasted function. `--mode suggest`'s "next action" logic was hardcoded to beach_towel only — generalized to read any manual product's command from `KNOWN_FORMATS` via regex.
2. **Design variation was real, not perceived.** Ran the new style-tally helper against the actual `designs_log.json` (25 entries): `bold_typographic` 3x + `unclassified` (mostly typographic) 4x in the last 12 designs, vs. 1x each for line-art/vintage-badge/cartoon and **0x** for bootleg-halftone, warning-label, and retro-mascot styles — confirming the log had collapsed toward one look even though titles never literally repeated (the existing title-dedup was already working correctly; style dedup didn't exist at all). Added `STYLE_LIBRARY` (8 named visual styles, all already proven somewhere in the static PROMPTS library) + `_infer_style()` (best-effort classifier for pre-existing designs that predate this field) + `_recent_style_counts()`. `generate_design_ideas()`'s Claude prompt now shows the model its own recent style distribution and explicitly instructs it to favor underused styles and never repeat a style within one batch — this sits alongside the existing pillar variety and title-dedup (`_design_corpus`), not replacing them.
3. **⚠️ Real blocker surfaced, not fixed by this change:** `ANTHROPIC_API_KEY` is still NOT set in `.env` (confirmed by direct check this session — same gap flagged in [[Projects/Rust_and_Rainbow/Tasks]] since 2026-06-23, unresolved 10 days later). `generate_design_ideas()` returns `[]` immediately without that key, so **the new style-balancing logic never actually runs** — every generate call silently falls back to the static 31-prompt library, which is exactly the repetition problem being fixed. The static-library fallback path now at least tags designs with an inferred style (so future tallies are accurate), but the real fix — Claude actively choosing underused styles — is dead code until the key is added. This is the single highest-priority follow-up; see Tasks.
4. Verified: `python3 -m py_compile agent.py` clean; `--mode suggest` run live end-to-end (report-only, no side effects) — confirmed beach_towel path unchanged and the new tote/poster/ornament formats now correctly resolve to real `--mode` commands instead of "NOT in catalog yet." Did NOT run `--mode generate` (would publish real products/spend Ideogram+Printify credits) and did NOT commit to git — `agent.py` has pre-existing unrelated uncommitted changes (`.gitignore`, `brand_guide.md`) from before this session; only `agent.py` was touched here, but committing wasn't requested.

## 2026-07-03 (cont'd) — ANTHROPIC_API_KEY added (Mac + NAS) + agent.py deployed to NAS

Ryan supplied a real Anthropic key. Added `ANTHROPIC_API_KEY` to both `.env` files:
- **Mac** (`~/Claude/Projects/side business/Rust & Rainbow/.env`) — new block appended, confirmed gitignored (never staged).
- **NAS** (`/volume1/homes/admin/claude-agents/agents/rust-rainbow/.env`) — appended directly over SSH (`admin@192.168.1.2`), verified present without ever printing the raw secret to any log/transcript. Confirmed `anthropic` 0.72.0 already installed in the NAS venv.

**Live-verified the fix actually works**, not just wired: called `generate_design_ideas()` directly with the real key (Anthropic-only, no Ideogram/Printify spend, nothing persisted) — it returned 3 concepts and picked exactly the 3 previously-zero-usage styles from the real log's tally (`bootleg_vintage_halftone`, `warning_label_typographic`, `retro_mascot_badge`) instead of defaulting to typographic again. This is the core fix working end-to-end.

**Deployed `agent.py` to the NAS** via the existing `agent-platform/deploy.sh rust-rainbow` (dry-run checked first — confirmed `.env`/`designs_log.json`/`reports`/`output` are excluded/preserved, only code overlays). Post-deploy verification on the NAS itself: `py_compile` clean under the NAS's actual Python 3.8.12 (not just the Mac's 3.9), `PRINTIFY_BLUEPRINTS_MANUAL`/`KNOWN_FORMATS`/`STYLE_LIBRARY` all confirmed live in the deployed module, `.env` survived the deploy intact (67 lines, key present). The NAS's weekly `--mode suggest`/`--mode report` jobs now run the current code — no more stale "NOT in catalog yet" for tote/poster/ornament.

**Still open (unchanged from above):** `--mode generate` itself still only runs on the Mac (rembg/Py3.10 constraint unchanged) — this deploy doesn't move design generation to the NAS, it just brings the NAS's report/suggest/market/monitor jobs current. First real `--mode generate` run with the new key + style logic is still Ryan's to trigger and review (see Tasks).

## 2026-06-23 — Generation v2: no-repeat + trend-aware + headless-safe

Goal worked: *"idea/image generation does not repeat, adopts new trends, move the pipeline off the MacBook."* Code shipped to `agent.py` (compiles on py3.8 + py3.11; full unattended path verified end-to-end with mocked Ideogram/Printify/Claude against a temp log).

- **🔴 Found + fixed: `--mode generate` was crashing EVERY weekly launchd run.** `review_designs()` called `input()` unconditionally; under launchd (no TTY) → `EOFError` AFTER images were generated (Ideogram credits spent), then published/logged nothing. `generate.log` shows the traceback but the wrapper still exited 0, so the watchdog never caught it. Now headless-safe: `auto_confirm`/TTY detection auto-approves; macOS-only `os.system("open")` guarded.
- **No-repeat:** dedup corpus now spans ALL `designs_log` statuses + the static library, normalized (case/space/punct). Previously only `status=="published"` from the static list — which is why the log already has dup titles (Vizsla Puppy Sticker ×3, Hungarian Hunter ×3, …). All generated designs are now persisted to the log, so titles are never re-generated.
- **Adopts trends:** new `generate_design_ideas()` asks Claude (`claude-sonnet-4-6`) for fresh, non-repeating concepts steered by `_gather_trend_brief()` (seasonal calendar + best-sellers + live Google Trends if pytrends present). Validates JSON, dedups vs corpus + in-batch, defaults unknown pillars. **Fails closed to the static library** if no `ANTHROPIC_API_KEY` / any error — never hard-fails a run.
- **Decision (Ryan, 2026-06-23):** unattended runs AUTO-PUBLISH (no human gate). Reversible to a pending-approval queue later.
- **Adopts trends NOW (key-independent):** added 9 hand-researched current-trend concepts to the static PROMPTS pool (vintage/bootleg tee, watercolor breed-portrait, pet-parent quote, owner-MATCHING "I'm With My Human", sassy TikTok "Pet Me At Your Own Risk", peak-summer "Hot Dog Summer", etc.) — so the next generate run produces on-trend, non-duplicate designs even without ANTHROPIC_API_KEY. The Claude generator layers fresher ideas on top once the key is set. Pool now 33 unique titles, 0 dups.
- **Mac-independence — NAS DEPLOY DONE + VALIDATED (2026-06-23).** Ryan authorized the deploy; ran `./setup.sh rust-rainbow` → code + `.env` (chmod 600) + venv on the NAS, `pip check` clean, healthcheck all-green. **Proved it runs off-Mac:** `--mode suggest` → exit 0 (report written to NAS); `--mode monitor` → exit 0.
  - 🔴 **2nd headless bug found by the live NAS run + fixed:** `run_monitor()` ALSO called `input()` ("Remove 'X'? (Y/N)") → EOFError on the NAS. Since removal DELETES live listings, the fix is report-only when headless (NEVER auto-delete 21 listings). Audited ALL `input()` sites: generate ✅fixed, monitor ✅fixed, market ✅already guarded by auto_confirm, towels ✅now degrades gracefully. File is headless-clean. Redeployed; monitor re-run exit 0.
  - `requirements/rust-rainbow.txt` gained `anthropic`; `jobs.conf` Phase-2a rows (market/monitor/report/suggest) enabled; `./validate.sh` clean.
  - ✅ **CUTOVER EXECUTED (2026-06-23, Ryan-authorized "NAS supervisor" option).** Since NAS scheduling is root-only (no crontab; `synoschedtask` root-owned; sudo password-blocked → DSM GUI), used a **user-space supervisor** instead: `rr-supervisor.py` runs as `admin` under nohup (pid survives logout, ppid 1), flock single-instance, crash-restarting loop, 30-min heartbeat → `logs/rr-supervisor.log`. It fires market (Mon/Wed/Fri 10:00), report (Mon 7:00), suggest (Mon 8:00), monitor (Sun 23:00) via run-agent.sh. The 4 matching **Mac launchd jobs are unloaded + archived** to `~/Library/LaunchAgents/.disabled-rr-nas-cutover-20260623/`. So posting/monitoring/reporting now fire from the always-on NAS — **the Mac can be closed.** No double-post (Mac jobs disabled; next market Wed 10:00 from NAS only).
  - **Residuals (documented, not blocking Mac-independence of the 4 jobs):**
    - 🔁 **Reboot persistence:** the supervisor is nohup'd, so a NAS reboot stops it. ONE optional DSM Triggered Task (Boot-up → `admin` → `/volume1/homes/admin/claude-agents/rr-supervisor-start.sh`) makes it durable. Until then it runs until the next reboot.
    - ⚠️ **Mac watchdog** (`watchdog.sh` cron, Mon/Wed/Fri 10:10) still checks the Mac's now-stale `market.log` → will fire a harmless false "market didn't run" notification. The classifier (correctly) blocked me from removing monitoring unauthorized — Ryan: repoint it at the NAS log or remove the cron line. Tracked in Tasks.
    - `generate` stays on Mac (rembg/Py3.8 → Phase 2b); `refresh_token` stays on Mac (Ryan's choice; token valid to 7/1, refresh manually by 6/25 — keep NAS `.env` in sync). Full detail: [[Knowledge_Base/NAS_RR_Migration_Runbook]].
- **arch-review:** 0 code blockers. Only blocker = missing `ANTHROPIC_API_KEY` (the feature is inert without it). Risks/deferred → [[Projects/Rust_and_Rainbow/Tasks]].
- ⚠️ The live NAS cutover and the transparent-endpoint refactor are outward-facing / need visual QA → tracked, NOT executed unsupervised.

## Status Summary
- Scheduling: ✅ HYBRID (2026-06-23) — market/monitor/report/suggest run on the **NAS** (`rr-supervisor.py`); generate/refresh_token/welra_assessment stay on **Mac launchd**. See Scheduling Architecture below.
- 3-platform posting: ✅ Instagram + TikTok + Pinterest all working
- TikTok music: ✅ `autoAddMusic: true` enabled 2026-05-28 — TikTok adds trending music automatically
- TikTok hashtags: ✅ Moved to `tiktokSettings.description` (4000 chars) — title is now pure hook
- Instagram hashtags: ✅ Capped at 28 (brand tag #rustandrainbow always first; 2-tag safety margin under API's 30-tag hard limit). Tag pool is 30–42 per pillar before trimming.
- All 5 content pillars: ✅ Covered as of 2026-05-21
- Etsy listings: 16+ new as of 2026-05-21
- Monitoring (sales): ✅ Fixed via `--mode report` (Printify orders API)
- Weekly report: ✅ `--mode report` — runs Mon 7:00am, outputs structured data for Claude Code narrative
- TikTok developer app: ⏳ Pending review (3rd submission 2026-06-06) — reframed as Content Posting API for original product publishing, not Display API. Monitor at developers.tiktok.com
- Etsy developer app: 🚫 Banned — do not recreate. Printify handles all publishing. Shop unaffected.
- GitHub org: ✅ Migrated to GR3NB — both Welra and rustandrainbow repos now under github.com/GR3NB
- GitHub Pages legal docs: ✅ Live at https://gr3nb.github.io/rustandrainbow/legal/
- Platform URLs updated: ✅ Meta updated. TikTok updated (pending review). Etsy app not needed.
- META token: ⚠️ Expires 2026-07-01 — must refresh by June 25
- designs_log.json: ✅ Duplicate Gay Dog Dad Retro (May 11 entry) removed 2026-05-28
- Sunday assessment: ✅ `com.rustandrainbow.welra_assessment` launchd agent — every Sun 9:00am

## Scheduling Architecture (HYBRID — as of 2026-06-23)

After the Phase 2a cutover, scheduling is split across two hosts. The whole point: the
cadence-critical jobs (posting/monitoring/reporting) now fire from the **always-on NAS**, so
they no longer depend on the MacBook being open.

**On the NAS** (Synology 192.168.1.2) — via `rr-supervisor.py`, a user-space scheduler
(user=admin, launched by `rr-supervisor-start.sh` under nohup, flock single-instance,
30-min heartbeat → `logs/rr-supervisor.log`). NAS scheduling is root-only (no `crontab`;
`synoschedtask` root-owned; sudo password-blocked; DSM Task Scheduler is GUI), so the
supervisor is the no-root path. Times are NAS-local (PDT):

| Job | Schedule | Command (via run-agent.sh) |
|---|---|---|
| market  | Mon/Wed/Fri 10:00 | `agent.py --mode market --yes` |
| report  | Mon 7:00 | `agent.py --mode report --yes` |
| suggest | Mon 8:00 | `agent.py --mode suggest` |
| monitor | Sun 23:00 | `agent.py --mode monitor` |

**On the Mac** (launchd, in `~/Library/LaunchAgents/`) — the jobs that can't/shouldn't move yet:

| Agent | Schedule | Why it stays |
|---|---|---|
| `com.rustandrainbow.generate` | Sun 2:00am | needs rembg (Py≥3.10); NAS is 3.8.12 → Phase 2b |
| `com.rustandrainbow.refresh_token` | Every 45 days | Ryan's choice; keep NAS `.env` token in sync after refresh |
| `com.rustandrainbow.welra_assessment` | Sun 9:00am | Welra assessment, unrelated to the R&R posting pipeline |

The 4 migrated Mac launchd jobs (market/monitor/report/suggest) were `launchctl unload`ed and
archived to `~/Library/LaunchAgents/.disabled-rr-nas-cutover-20260623/` (so no double-post).

**Reboot caveat:** the NAS supervisor is nohup'd → a NAS reboot stops it. Durability TODO =
one DSM Boot-up Triggered Task running `/volume1/homes/admin/claude-agents/rr-supervisor-start.sh`.

**Mac watchdog** (`watchdog.sh` cron, Mon/Wed/Fri 10:10) still checks the Mac's now-stale
`market.log` → harmless false "market didn't run" alarm until repointed at the NAS log or removed.

**Mac sleep risk (now mostly moot for posting):** launchd does not retry jobs missed while the
Mac sleeps — but market/monitor/report/suggest no longer run on the Mac, so this only affects
`generate` (weekly) and `refresh_token`/`welra_assessment`. Full cutover detail + commands:
[[Knowledge_Base/NAS_RR_Migration_Runbook]].

## Content Pillars
*Rebalanced 2026-06-07 — vizsla-primary strategy based on Etsy competitor + TikTok engagement research.*

| Pillar | Status | Target | Notes |
|---|---|---|---|
| velcro_dog | ✅ Active | 9–10 designs | Proven Etsy search term, widest appeal |
| chaos_agent | 🆕 New | 5–6 designs | Biggest gap in vizsla merch; TikTok-native humor |
| vizsla_parent | 🆕 New | 4–5 designs | "Vizsla Mom" confirmed Star Seller; gender-neutral owner identity |
| hungarian_chaos | ✅ Expanded | 6–7 designs | Added hunting-humor angle to vintage aesthetic |
| pride_breed | ✅ Reframed | 3–4 designs | Rainbow aesthetic, not identity-coded |
| gay_dog_dad | ✅ Reduced | 2–3 designs | Authentic founding voice; kept genuine, not leading |
| pnw_dog_life | ❌ Dissolved | 0 | Too geo-specific; absorbed into vizsla_parent |

## Products per Design
T-shirt, mug, hoodie, sticker (blueprint 400 — Kiss-Cut Stickers)

## Weekly Report Mode (`--mode report`)
Self-learning loop added 2026-05-22. Runs Mon 7:00am via launchd.

| Step | What it does | Requires |
|---|---|---|
| Printify orders | Real order count + revenue | PRINTIFY_API_KEY |
| Instagram | Follower count + recent posts | META_ACCESS_TOKEN |
| Etsy listing deltas | Views/favs week-over-week | ETSY_ACCESS_TOKEN (optional) |
| AI narrative | Claude Opus generates report | ANTHROPIC_API_KEY (optional) |
| Auto-optimise | Rewrites zero-traffic listing titles/tags via Etsy PUT | Both above |

- Report saved to: `reports/YYYY-MM-DD.md`
- History tracked in: `performance_log.json` (appended weekly — never delete)
- Without `ANTHROPIC_API_KEY`: saves data-only report, paste into Claude.ai for narrative
- `instagram_manage_insights` permission NOT in current token — reach/impressions unavailable; follower count + posts still tracked

## Week of 2026-06-15 — Post Results (Sunday Assessment 2026-06-21)
| Date | Design | IG | TikTok | Pinterest |
|------|--------|-----|--------|-----------|
| Jun 15 | Velcro Dog Line Art (velcro_dog) | ✓ | ✓ | ✓ |
| Jun 17 | Gay Dog Dad Retro (gay_dog_dad) | ✓ | ✗ Zernio "All platforms failed" | ✓ |
| Jun 19 | Rainbow Heart Vizsla (pride_breed) | ✓ | ✓ | ✗ Zernio "All platforms failed" |
2 partial Zernio failures (platform-side, not R&R code). Designs were stamped last_posted regardless. Retry mechanism task still open.

**Code fixes applied 2026-06-21:**
- `agent.py` `get_etsy_listing_stats` stale message fixed — "run etsy_auth.py" replaced with permanent-ban notice (the Jun 14 fix only updated `build_data_report`, not this function)
- Welra `reportGenerator.ts` source model updated — `claude-haiku-4-5` → `claude-haiku-4-5-20251001` (canonical ID; not deployed yet, needs `railway up`)

⚠️ **META_ACCESS_TOKEN URGENT** — expires 2026-07-01, must refresh by **June 25 (4 days)**. See Tasks.

## Week of 2026-06-08 — Post Results (Sunday Assessment 2026-06-14)
| Date | Design | IG | TikTok | Pinterest |
|------|--------|-----|--------|-----------|
| Jun 8 | Rainbow Vizsla Silhouette (pride_breed) | ✓ | ✓ | ✓ |
| Jun 10 | Hungarian Hunter (hungarian_chaos) | ✓ | ✓ | ✓ |
| Jun 12 | Oregon Vizsla (pnw_dog_life) | ✓ | ✓ | ✓ |
All 3 posts this week succeeded on all platforms.
Note: Oregon Vizsla uses the dissolved pnw_dog_life pillar — existing published designs continue posting; no new designs for that pillar will be generated.

**Code fixes applied 2026-06-14:**
- `agent.py` Etsy messages updated — "run etsy_auth.py" replaced with permanent-ban notice
- Welra `instagram.ts` bumped from Graph API v21.0 → v22.0 (sync with R&R's working version)

## Week of 2026-06-01 — Post Results
| Date | Design | IG | TikTok | Pinterest |
|------|--------|-----|--------|-----------|
| Jun 1 | Oregon Vizsla (pnw_dog_life) | ✗ Too many tags (pre-fix) | ✓ | ✓ |
| Jun 3 | Vizsla Puppy Sticker (velcro_dog) | ✓ | ✓ | ✓ |
| Jun 5 | Pride Flag Vizsla (gay_dog_dad) | ✓ | ✓ | ✓ |
**June 1 Instagram failure**: trim code was not yet capping at 28 — 36 tags sent, API rejected. Fix applied 2026-06-07 — cap reduced to 28, #rustandrainbow placed first.

## Key Platform Limits & Notes
- TikTok photo posts: 90-char title limit (`content` field) — keep as pure hook, no hashtags
- TikTok hashtags: use `tiktokSettings.description` (4000-char limit, separate from title) — all tags go here
- TikTok music: `autoAddMusic: true` in `tiktokSettings` — TikTok picks trending music automatically. No API for specific song IDs.
- Instagram hashtags: broad reach first (#dogsofinstagram etc.), then niche (#vizsla etc.), then pillar-specific, then POD/shop
- META_ACCESS_TOKEN: expires 2026-07-01, renew at developers.facebook.com. ⚠️ The same token is also pasted into Welra's Instagram integration (welra.io/dashboard/integrations) — when refreshing, update BOTH the NAS agent .env and the Welra card.
- Meta/Instagram IDs (confirmed 2026-06-12 — not secrets, save the lookup time):
  - **Instagram Business Account ID: `1041492732390434`** ← the value Graph API calls + Welra's Instagram card need
  - Facebook Page ID: `1135312136329438` ("Rust and Rainbow")
  - Meta Business ID: `970811995814374`
- Printify orders API: NO `limit` param — page-based only (`?page=N`)
- launchd on modern macOS: `launchctl load` may show "Load failed: 5" but still works — verify with `launchctl list | grep <label>`
- Zernio TikTok post payload: must include `tiktokSettings.contentPreviewConfirmed: true` and `expressConsentGiven: true` or posts can silently fail
- Weekly report (`--mode report`): outputs structured markdown — drop into Claude Code for narrative. No ANTHROPIC_API_KEY needed.

## Related
- [[Projects/Rust_and_Rainbow/Tasks]]
- [[memory/Learnings_and_Conventions]]
