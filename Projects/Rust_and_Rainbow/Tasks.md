---
title: Rust & Rainbow Tasks
project: rust-and-rainbow
type: tasks
updated: 2026-06-23
tags: [etsy, printify, social-media, nas]
---

# Rust & Rainbow Tasks

See [[Projects/Rust_and_Rainbow/State]] for platform status, pillars, and cron details.

## High Priority

- [x] Update GitHub Pages privacy/terms URLs in platform registrations — Meta updated, TikTok updated, Etsy app banned (not needed — Printify handles publishing). GitHub Pages live at gr3nb.github.io/rustandrainbow/legal/ [owner:: ryan] [priority:: high] [status:: done]
- [ ] Monitor TikTok developer app review — 3rd submission 2026-06-06. App ID: 7638050043181959175. Check developers.tiktok.com weekly. If approved, evaluate switching from Zernio to direct TikTok Content Posting API. If rejected again, document reason and stay on Zernio permanently. [owner:: ryan] [priority:: high] [status:: in-progress]

- [ ] Delete duplicate Gay Dog Dad Retro listing in Printify dashboard — May 11 product (ID: 6a025e0754291b828c064667) is the stale one; May 14 product (ID: 6a0654c3e556c763050faeed) is the keeper with stable S3 mockup. Deleting in Printify auto-unpublishes from Etsy. designs_log.json duplicate already removed 2026-05-28. [owner:: ryan] [priority:: high] [status:: open]
- [ ] Refresh META_ACCESS_TOKEN at developers.facebook.com — expires 2026-07-01, must refresh by June 25 or Instagram/Facebook posts fail silently [owner:: ryan] [priority:: high] [status:: open] [due:: 2026-06-25]
- [ ] Add ANTHROPIC_API_KEY to .env (Mac AND NAS) — required for `--mode report` narrative AND the new trend-aware no-repeat idea generation in `--mode generate`. Without it, generate silently falls back to the static 31-prompt library (the exact repeat / no-new-trends problem). `anthropic` 0.109.1 already installed in `.venv-bgfix`. [owner:: ryan] [priority:: high] [status:: open]

### Generation v2 + Mac-independence (added 2026-06-23)

*Code shipped 2026-06-23 in agent.py: (1) unattended-generate EOFError crash FIXED — it was crashing every weekly launchd run at the interactive approval prompt, burning Ideogram credits then publishing/logging nothing; (2) Claude-driven trend-aware no-repeat idea generation (`generate_design_ideas`, `_gather_trend_brief`, `_design_corpus`); (3) dedup now normalized across ALL designs_log statuses + the static library (was published-only — that's why the log has dup titles); (4) all generated designs persisted to log so nothing is re-generated; (5) `review_designs` headless-safe (TTY/auto_confirm + macOS-only `open` guarded). Ryan chose AUTO-PUBLISH for unattended runs. arch-review: 0 code blockers — only blocker is the missing ANTHROPIC_API_KEY above.*

- [x] Phase 2a NAS cutover — DONE 2026-06-23. market/monitor/report/suggest now run on the always-on NAS via `rr-supervisor.py` (user-space scheduler, nohup, flock, heartbeat); the 4 Mac launchd jobs are unloaded + archived. Posting is Mac-independent. [owner:: claude] [priority:: high] [status:: done]
- [ ] Make the NAS supervisor reboot-durable — add ONE DSM Triggered Task: Control Panel → Task Scheduler → Create → Triggered Task → Event: Boot-up, User: admin, command `/volume1/homes/admin/claude-agents/rr-supervisor-start.sh`. Until then, after any NAS reboot run that same script (or `./schedule.sh` once you grant sudo). [owner:: ryan] [priority:: high] [status:: open]
- [ ] Repoint or remove the Mac `watchdog.sh` cron (Mon/Wed/Fri 10:10) — it checks the Mac's now-stale `market.log` and will false-alarm now that market runs on the NAS. Either point it at the NAS log or remove the crontab line (`crontab -e`). [owner:: ryan] [priority:: medium] [status:: open]
- [ ] Keep the NAS `.env` META token in sync — refresh_token still runs on the Mac (writes the Mac `.env`); after the 6/25 META refresh, also paste the new token into the NAS `.env` (`ssh … 'nano …/agents/rust-rainbow/.env'`) and Welra's card, or move refresh_token to the NAS supervisor (Supervisor + move token option). [owner:: ryan] [priority:: high] [status:: open] [due:: 2026-06-25]
- [ ] [DEFERRED from arch-review] Phase 2b — make `--mode generate` NAS-portable by replacing rembg (needs Py≥3.10; NAS is 3.8.12) with Ideogram 3.0's native transparent endpoint, PER-CONCEPT (keep backgrounds on retro/vintage designs — don't blanket-transparent). Requires visual QA, then move generate to NAS + disable Mac launchd. [owner:: claude] [priority:: high] [status:: open]
- [x] [DEFERRED from arch-review] Fix `run_generate.sh` exit code — DONE 2026-06-23: capture `rc=$?` and `exit $rc` so a crash is no longer masked as exit 0. (Same pattern remains in run_refresh.sh / run_welra_assessment.sh — lower priority; the NAS `run-agent.sh` already exits with the real code.) [owner:: claude] [priority:: high] [status:: done]
- [ ] [DEFERRED from arch-review] Guard fully-failed Printify upload — if `published_products` is empty, mark status `publish_failed` not `published`, so `run_market` doesn't post a design with no live listing. (Pre-existing, low.) [owner:: claude] [priority:: medium] [status:: open]
- [ ] [DEFERRED from arch-review] Optional: install `pytrends` so `_gather_trend_brief` feeds LIVE Google Trends into idea generation (currently degrades to seasonal calendar + best-sellers + Claude knowledge; never hard-fails without it). [owner:: ryan] [priority:: low] [status:: open]
- [ ] One-time cleanup: dedupe existing `designs_log.json` (Vizsla Puppy Sticker ×3, Hungarian Hunter ×3, Velcro Dog Line Art ×2, Velcro Dog Typography ×2). New dedup prevents NEW dups but doesn't retro-clean old ones. [owner:: claude] [priority:: low] [status:: open]

- [ ] Add retry mechanism for partial platform post failures — when Instagram fails but TikTok/Pinterest succeed, the design still gets last_posted stamped and Instagram is silently skipped. Consider: on IG failure, log the design ID to a retry file; add a --mode retry that re-attempts failed IG posts. [owner:: ryan] [priority:: medium] [status:: open]

## Medium Priority

- [x] Etsy developer app — banned 2026-06-06, do not recreate. Etsy's API terms restrict AI automation. Printify handles all publishing to Etsy natively. Weekly report loses views/favs analytics but shop is fully operational. [owner:: ryan] [priority:: medium] [status:: done]

## Done

- [x] Schedule weekly Welra assessment — `com.rustandrainbow.welra_assessment` launchd agent, every Sun 9am. Invokes Claude Code CLI to assess R&R vs Welra, implement fixes, update vault. [owner:: claude] [priority:: high] [status:: done]
- [x] Expand hashtag strategy — Instagram: 30–42 tags with broad reach layer (#dogsofinstagram etc.). TikTok: title is now pure hook; all tags moved to tiktokSettings.description (4000 chars). [owner:: claude] [priority:: medium] [status:: done]
- [x] Fix R&R weekly report for native Claude Code — removed "no API key" message, reformatted with WoW deltas and signed numbers, footer directs to Claude Code for narrative [owner:: claude] [priority:: medium] [status:: done]
- [x] Remove duplicate market cron line — was running alongside launchd, risked double-posting. Cron market line removed 2026-05-28. launchd is now sole scheduler. [owner:: claude] [priority:: high] [status:: done]
- [x] Update watchdog.sh — now checks local market.log (launchd log) instead of old cron main log [owner:: claude] [priority:: medium] [status:: done]
- [x] Enable TikTok trending music — added `autoAddMusic: true` + full tiktokSettings to Zernio post payload [owner:: claude] [priority:: medium] [status:: done]
- [x] Remove Gay Dog Dad Retro duplicate from designs_log.json — May 11 entry removed; May 14 entry is active [owner:: claude] [priority:: high] [status:: done]
- [x] Fix run_monitor() — `sales` hardcoded 0. Resolved via new `--mode report` (see below) [owner:: claude] [priority:: low] [status:: done]
- [x] Load report cron — `com.rustandrainbow.report` confirmed active in launchctl (exit 0) [owner:: ryan] [priority:: high] [status:: done]
- [x] Fix stale plists — generate/market/monitor plists point to ~/Documents/Claude/... but project is at ~/Claude/... Update all run_*.sh and plist paths [owner:: claude] [priority:: medium] [status:: done]

## Related
- [[Projects/Rust_and_Rainbow/State]]
- [x] 🔴 Etsy developer app "rust-and-rainbow" is BANNED — RESOLVED as permanent 2026-06-11: ban was over AI-generated content (t-shirt designs); the API denial appeal came back "we're not able to reconsider this decision." **The R&R Etsy API path (listing analytics, auto-optimize, etsy_auth.py) is permanently dead — remove from roadmap.** Weekly report keeps using Printify order data only. [owner:: ryan] [priority:: high] [status:: done]

- [ ] ⚠️ Verify the R&R Etsy SHOP (not just the API app) is still in good standing — the ban reason was AI-generated content on listings, which is a shop-policy issue, not an API issue. Check the shop dashboard + any emails from Etsy Trust & Safety; if the shop is flagged, listings/sales are at risk. [owner:: ryan] [priority:: high] [status:: open]
