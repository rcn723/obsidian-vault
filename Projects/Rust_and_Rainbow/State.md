---
title: Rust & Rainbow State
project: rust-and-rainbow
type: state
updated: 2026-06-14
tags: [etsy, printify, social-media, python, automation]
---

# Rust & Rainbow

Automated Vizsla/LGBTQ+ niche product business. Generates designs, publishes to Printify/Etsy, posts to 3 social platforms.
Path: `~/Claude/Projects/side business/Rust & Rainbow/`
GitHub: `https://github.com/GR3NB/rustandrainbow` (transferred from rcn723 2026-06-06)
GitHub Pages (legal docs): `https://gr3nb.github.io/rustandrainbow/`

See [[Projects/Rust_and_Rainbow/Tasks]] for open items.

## Status Summary
- Scheduling: ✅ launchd only (cron market line removed 2026-05-28 — was duplicating posts)
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
