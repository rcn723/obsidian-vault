---
title: Rust & Rainbow State
project: rust-and-rainbow
type: state
updated: 2026-05-22
tags: [etsy, printify, social-media, python, automation]
---

# Rust & Rainbow

Automated Vizsla/LGBTQ+ niche product business. Generates designs, publishes to Printify/Etsy, posts to 3 social platforms.
Path: `~/Claude/Projects/side business/Rust & Rainbow/`

See [[Projects/Rust_and_Rainbow/Tasks]] for open items.

## Status Summary
- Scheduling: ✅ 5 launchd agents active — all paths correct as of 2026-05-22
- 3-platform posting: ✅ Instagram + TikTok + Pinterest all working
- All 5 content pillars: ✅ Covered as of 2026-05-21
- Etsy listings: 16+ new as of 2026-05-21
- Monitoring (sales): ✅ Fixed via `--mode report` (Printify orders API)
- Weekly report: ✅ `--mode report` built — runs Mon 7:00am, saves to `reports/YYYY-MM-DD.md`
- META token: ⚠️ Expires 2026-07-01 — must refresh by June 25

## launchd Agents
All agents live in `~/Library/LaunchAgents/` and `~/Claude/Projects/side business/Rust & Rainbow/`.

| Agent | Schedule | Script |
|---|---|---|
| `com.rustandrainbow.generate` | Sun 2:00am | `run_generate.sh` |
| `com.rustandrainbow.market` | Mon/Wed/Fri 10:00am | `run_market.sh` |
| `com.rustandrainbow.monitor` | Sun 11:00pm | `run_monitor.sh` |
| `com.rustandrainbow.refresh_token` | Every 45 days | `run_refresh.sh` |
| `com.rustandrainbow.report` | Mon 7:00am | `run_report.sh` |

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

## Key Platform Limits & Notes
- TikTok photo posts: 90 char max — hook-only caption + 2-3 hashtags
- META_ACCESS_TOKEN: expires 2026-07-01, renew at developers.facebook.com
- Printify orders API: NO `limit` param — page-based only (`?page=N`)
- launchd on modern macOS: `launchctl load` may show "Load failed: 5" but still works — verify with `launchctl list | grep <label>`

## Related
- [[Projects/Rust_and_Rainbow/Tasks]]
- [[memory/Learnings_and_Conventions]]
