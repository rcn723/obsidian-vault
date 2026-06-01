---
title: Rust & Rainbow Tasks
project: rust-and-rainbow
type: tasks
updated: 2026-05-31
tags: [etsy, printify, social-media]
---

# Rust & Rainbow Tasks

See [[Projects/Rust_and_Rainbow/State]] for platform status, pillars, and cron details.

## High Priority

- [ ] Delete duplicate Gay Dog Dad Retro listing in Printify dashboard — May 11 product (ID: 6a025e0754291b828c064667) is the stale one; May 14 product (ID: 6a0654c3e556c763050faeed) is the keeper with stable S3 mockup. Deleting in Printify auto-unpublishes from Etsy. designs_log.json duplicate already removed 2026-05-28. [owner:: ryan] [priority:: high] [status:: open]
- [ ] Refresh META_ACCESS_TOKEN at developers.facebook.com — expires 2026-07-01, must refresh by June 25 or Instagram/Facebook posts fail silently [owner:: ryan] [priority:: high] [status:: open] [due:: 2026-06-25]
- [ ] Add ANTHROPIC_API_KEY to .env — required to run `--mode report` with AI narrative [owner:: ryan] [priority:: high] [status:: open]

## Medium Priority

- [ ] Activate Etsy API keys in .env after Etsy developer app approved — run etsy_auth.py, fills ETSY_ACCESS_TOKEN + ETSY_SHOP_ID automatically [owner:: ryan] [priority:: medium] [status:: open]

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
