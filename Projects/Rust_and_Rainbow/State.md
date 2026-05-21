---
title: Rust & Rainbow State
project: rust-and-rainbow
type: state
updated: 2026-05-21
tags: [etsy, printify, social-media, python, automation]
---

# Rust & Rainbow

Automated Vizsla/LGBTQ+ niche product business. Generates designs, publishes to Printify/Etsy, posts to 3 social platforms.
Path: `~/Claude/Projects/side business/Rust & Rainbow/`

See [[Projects/Rust_and_Rainbow/Tasks]] for open items.

## Status Summary
- Scheduling: ✅ Cron active — `0 10 * * 1,3,5` (Mon/Wed/Fri 10am)
- 3-platform posting: ✅ Instagram + TikTok + Pinterest all working
- All 5 content pillars: ✅ Covered as of 2026-05-21
- Etsy listings: 16+ new as of 2026-05-21
- Monitoring (sales): ⚠️ `sales` hardcoded 0 — low priority until real sales start
- META token: ⚠️ Expires 2026-07-01 — must refresh by June 25

## Cron Entry
```
0 10 * * 1,3,5  cd "~/Claude/Projects/side business/Rust & Rainbow" && /usr/bin/python3 agent.py --mode market --yes >> ~/Library/Logs/rust_rainbow_market.log 2>&1
```

## Content Pillars
| Pillar | Status | Example |
|---|---|---|
| pride_breed | ✅ Published | Rainbow Heart Vizsla |
| pnw_dog_life | ✅ Published | Oregon Vizsla |
| gay_dog_dad | ✅ Published | Gay Agenda |
| hungarian_chaos | ✅ Published | Retro Vizsla Poster |
| velcro_dog | ✅ Published | Velcro Dog Typography |

## Products per Design
T-shirt, mug, hoodie, sticker (blueprint 400 — Kiss-Cut Stickers)

## Key Platform Limits
- TikTok photo posts: 90 char max — hook-only caption + 2-3 hashtags
- META_ACCESS_TOKEN: expires 2026-07-01, renew at developers.facebook.com

## Related
- [[Projects/Rust_and_Rainbow/Tasks]]
- [[Knowledge_Base/Learnings_and_Conventions]]
