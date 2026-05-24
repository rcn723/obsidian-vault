---
title: Rust & Rainbow Tasks
project: rust-and-rainbow
type: tasks
updated: 2026-05-22
tags: [etsy, printify, social-media]
---

# Rust & Rainbow Tasks

See [[Projects/Rust_and_Rainbow/State]] for platform status, pillars, and cron details.

## High Priority

- [ ] Delete duplicate Gay Dog Dad Retro listing in Printify dashboard — published May 11 + May 14. Deleting in Printify auto-unpublishes from Etsy. [owner:: ryan] [priority:: high] [status:: open]
- [ ] Refresh META_ACCESS_TOKEN at developers.facebook.com — expires 2026-07-01, must refresh by June 25 or Instagram/Facebook posts fail silently [owner:: ryan] [priority:: high] [status:: open] [due:: 2026-06-25]

## Low Priority

- [x] Fix run_monitor() — `sales` hardcoded 0. Resolved via new `--mode report` (see below) [owner:: claude] [priority:: low] [status:: done]
- [ ] Add ANTHROPIC_API_KEY to .env — required to run `--mode report` [owner:: ryan] [priority:: high] [status:: open]
- [ ] Activate Etsy API keys in .env after Etsy developer app approved — run etsy_auth.py, fills ETSY_ACCESS_TOKEN + ETSY_SHOP_ID automatically [owner:: ryan] [priority:: medium] [status:: open]
- [x] Load report cron — `com.rustandrainbow.report` confirmed active in launchctl (exit 0) [owner:: ryan] [priority:: high] [status:: done]
- [x] Fix stale plists — generate/market/monitor plists point to ~/Documents/Claude/... but project is at ~/Claude/... Update all run_*.sh and plist paths [owner:: claude] [priority:: medium] [status:: done]

## Related
- [[Projects/Rust_and_Rainbow/State]]
