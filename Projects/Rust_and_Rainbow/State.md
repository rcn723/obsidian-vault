---
title: Rust & Rainbow State
project: rust-and-rainbow
type: state
updated: 2026-05-31
tags: [etsy, printify, social-media, python, automation]
---

# Rust & Rainbow

Automated Vizsla/LGBTQ+ niche product business. Generates designs, publishes to Printify/Etsy, posts to 3 social platforms.
Path: `~/Claude/Projects/side business/Rust & Rainbow/`

See [[Projects/Rust_and_Rainbow/Tasks]] for open items.

## Status Summary
- Scheduling: ✅ launchd only (cron market line removed 2026-05-28 — was duplicating posts)
- 3-platform posting: ✅ Instagram + TikTok + Pinterest all working
- TikTok music: ✅ `autoAddMusic: true` enabled 2026-05-28 — TikTok adds trending music automatically
- TikTok hashtags: ✅ Moved to `tiktokSettings.description` (4000 chars) — title is now pure hook
- Instagram hashtags: ✅ Expanded to 30–42 tags (added broad reach: #dogsofinstagram etc.)
- All 5 content pillars: ✅ Covered as of 2026-05-21
- Etsy listings: 16+ new as of 2026-05-21
- Monitoring (sales): ✅ Fixed via `--mode report` (Printify orders API)
- Weekly report: ✅ `--mode report` — runs Mon 7:00am, outputs structured data for Claude Code narrative
- META token: ⚠️ Expires 2026-07-01 — must refresh by June 25
- designs_log.json: ✅ Duplicate Gay Dog Dad Retro (May 11 entry) removed 2026-05-28
- Sunday assessment: ✅ `com.rustandrainbow.welra_assessment` launchd agent — every Sun 9:00am

## Scheduling Architecture (as of 2026-05-28)

**launchd is the sole scheduler.** The old market cron line was removed — it was running in parallel with launchd and risked double-posting on weeks both fired.

All agents live in `~/Library/LaunchAgents/` and `~/Claude/Projects/side business/Rust & Rainbow/`.

| Agent | Schedule | Script | Log |
|---|---|---|---|
| `com.rustandrainbow.generate` | Sun 2:00am | `run_generate.sh` | `generate.log` |
| `com.rustandrainbow.market` | Mon/Wed/Fri 10:00am | `run_market.sh` | `market.log` |
| `com.rustandrainbow.monitor` | Sun 11:00pm | `run_monitor.sh` | `monitor.log` |
| `com.rustandrainbow.refresh_token` | Every 45 days | `run_refresh.sh` | `refresh.log` |
| `com.rustandrainbow.report` | Mon 7:00am | `run_report.sh` | `report.log` |

**Watchdog cron** (crontab, not launchd): `10 10 * * 1,3,5` — runs `watchdog.sh`, fires macOS notification if `market.log` was not updated today. Checks local `market.log` (not the old main log).

**Weekly Welra assessment** (launchd): `com.rustandrainbow.welra_assessment` — every Sunday 9:00am. Runs `run_welra_assessment.sh`, which invokes Claude Code CLI to autonomously assess R&R vs Welra, implement fixes, and update the vault. Output → `welra_assessment.log`.

**Mac sleep risk:** launchd `StartCalendarInterval` does NOT retry missed jobs if Mac is asleep at fire time. If Mac sleeps at 10am, the post is skipped silently — watchdog catches it at 10:10am.

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
- TikTok photo posts: 90-char title limit (`content` field) — keep as pure hook, no hashtags
- TikTok hashtags: use `tiktokSettings.description` (4000-char limit, separate from title) — all tags go here
- TikTok music: `autoAddMusic: true` in `tiktokSettings` — TikTok picks trending music automatically. No API for specific song IDs.
- Instagram hashtags: broad reach first (#dogsofinstagram etc.), then niche (#vizsla etc.), then pillar-specific, then POD/shop
- META_ACCESS_TOKEN: expires 2026-07-01, renew at developers.facebook.com
- Printify orders API: NO `limit` param — page-based only (`?page=N`)
- launchd on modern macOS: `launchctl load` may show "Load failed: 5" but still works — verify with `launchctl list | grep <label>`
- Zernio TikTok post payload: must include `tiktokSettings.contentPreviewConfirmed: true` and `expressConsentGiven: true` or posts can silently fail
- Weekly report (`--mode report`): outputs structured markdown — drop into Claude Code for narrative. No ANTHROPIC_API_KEY needed.

## Related
- [[Projects/Rust_and_Rainbow/Tasks]]
- [[memory/Learnings_and_Conventions]]
