---
title: Learnings and Conventions
type: system
updated: 2026-05-31
tags: [reference, bugs, api, conventions]
---

# Learnings and Conventions

*Shared knowledge, API gotchas, and conventions discovered by Claude or Antigravity. Add entries chronologically — never delete.*

---

## API Gotchas

### Printify — Orders Endpoint (2026-05-22)
`GET /v1/shops/{shop_id}/orders.json` does **not** support a `limit` query parameter.
Passing `?limit=100` returns a `400 Bad Request`. Use page-based pagination via `?page=N` if needed.
Default response is already paginated with `current_page`, `last_page`, `data[]` structure.

### Instagram Graph API — Insights Endpoint (2026-05-22)
`GET /{account_id}/insights` requires the `instagram_manage_insights` permission on the access token.
Standard long-lived user tokens do NOT include this permission by default.
Symptom: `400 Bad Request` on the insights endpoint even though the account endpoint works fine.
Workaround: pull `followers_count` and `media_count` directly from `GET /{account_id}?fields=followers_count,media_count` — these work with standard token permissions. Silently skip the insights call if it returns 400.
Full insights (reach, impressions) require re-generating the token with `instagram_manage_insights` scope — not worth it unless this becomes important.

### Zernio — TikTok Post Payload (2026-05-28)
When posting to TikTok via Zernio `/v1/posts`, include a `tiktokSettings` object or posts can fail silently:
```json
"tiktokSettings": {
  "privacyLevel": "PUBLIC_TO_EVERYONE",
  "allowComment": true,
  "autoAddMusic": true,
  "contentPreviewConfirmed": true,
  "expressConsentGiven": true
}
```
- `autoAddMusic: true` — TikTok's algorithm attaches recommended trending music to photo posts automatically. Only works for photo posts (not video). You cannot specify a particular song ID via the API.
- `contentPreviewConfirmed` + `expressConsentGiven` — required TikTok consent fields. Without them, posts may be accepted by Zernio but silently rejected by TikTok.
- `privacyLevel` must match one of the values returned by the TikTok creator info API for the account.

### Meta Access Token — Expiry (2026-05-21 / ongoing)
META_ACCESS_TOKEN for Rust & Rainbow expires **2026-07-01**. Must refresh by **June 25** at developers.facebook.com → Tools → Access Token Debugger → Extend. Failing to refresh causes Instagram + Facebook posts to fail silently.

---

## macOS Scheduling Conventions

### TikTok Hashtag Field — title vs description (2026-05-31)
TikTok photo post titles (`content` field) are capped at **90 characters**. Putting hashtags in the title wastes the limit and leaves no room for the hook.
The correct field is `tiktokSettings.description` — up to **4000 characters**, completely separate from the title limit.
Pattern: `content` = pure hook text only. `tiktokSettings.description` = all hashtags (dogtok discovery set + breed niche + pillar-specific + POD/shop + brand).

### Instagram Hashtag Strategy — Funnel Structure (2026-05-31)
Layer hashtags broad-to-narrow for maximum algorithmic surface area:
1. **Broad reach** (100M+ posts): `#dogsofinstagram #dogstagram #dogsofig #doglife #dogmom #dogdad`
2. **Breed niche** (1M–10M): `#vizsla #vizslaofinstagram #vizslagram #velcrodog #hungarianpointer`
3. **Pillar-specific**: gay/pride tags for relevant designs, PNW tags for Oregon content
4. **POD/shop discovery**: `#etsyshop #etsyseller #shopsmall #smallbusiness #dogtshirt`
5. **Brand**: `#rustandrainbow`
This yields 30–42 tags per post. Broad tags get initial exposure; niche tags convert engaged followers.

### Autonomous Assessment via Claude Code CLI (2026-05-31)
Pattern for scheduled autonomous sessions on local files: use `claude --print --dangerously-skip-permissions "PROMPT"` in a launchd shell script.
- `--print` runs non-interactively and outputs to stdout (captured in log via `>>`)
- `--dangerously-skip-permissions` allows file reads/writes without interactive prompts — only safe for trusted local automation scripts
- PATH must include `~/.npm-global/bin` (where `claude` lives) — add to shell script explicitly
- launchd does not inherit user PATH; always export it manually in the script

### Dual Scheduler Risk — cron + launchd (2026-05-28)
Do not run the same job in both cron AND launchd. On weeks where both fire, posts will be sent twice. The Rust & Rainbow market job was duplicated this way — cron writing to `~/Library/Logs/rust_rainbow_market.log` and launchd writing to local `market.log`. Fix: remove the cron line, keep launchd as the sole scheduler.

### Mac Sleep = Missed launchd Jobs (2026-05-28)
`launchd StartCalendarInterval` does NOT retry a job if the Mac was asleep when it was scheduled to fire. The job is simply skipped. The watchdog pattern (a second launchd/cron job 10 minutes later that checks the log file's modification date) is the right mitigation — it fires a macOS notification so the missed post can be run manually.

---

## macOS launchd Conventions

### `launchctl load` "Load failed: 5" on Modern macOS (2026-05-22)
On macOS Ventura/Sonoma, the old `launchctl load <plist>` command is deprecated. It often returns `Load failed: 5: Input/output error` even when the plist loaded successfully.
**Always verify with:** `launchctl list | grep <label>` — if the label appears, it's loaded.
**Modern equivalent:** `launchctl bootstrap gui/$(id -u) <plist>`
**To unload:** `launchctl bootout gui/$(id -u) <label>`

### Plist path with `&` in directory names (2026-05-22)
In XML plists, `&` in paths must be encoded as `&amp;` (e.g. `Rust &amp; Rainbow`).
The shell script called by the plist does NOT need encoding — use literal `&`.

### Rust & Rainbow Cron Files — Correct Path (2026-05-22)
Project moved from `~/Documents/Claude/Projects/` to `~/Claude/Projects/`.
All plists and shell scripts updated to use `~/Claude/Projects/side business/Rust & Rainbow/`.
The `~/Documents/Claude/Projects/` directory only contains `Stock/` — not Rust & Rainbow.

---

## Python / pip Conventions

### anthropic SDK (2026-05-22)
Installed via `pip3 install anthropic`. Version 0.104.1 as of 2026-05-22.
Installed to user Python 3.9 at `/Users/ryannortham/Library/Python/3.9/`.
Import: `import anthropic` — works without venv.
Usage in scripts: instantiate with `anthropic.Anthropic(api_key=ANTHROPIC_API_KEY)`.

### pip3 install — Corporate Mac Warning (2026-05-22)
`pip3 install` works correctly on this machine (unlike npm global installs).
Packages install to `~/Library/Python/3.9/lib/python/site-packages/` — user-owned, no permission issues.
The `urllib3 NotOpenSSLWarning` about LibreSSL 2.8.3 is harmless — suppress with `2>/dev/null` in shell scripts or filter in output.

---

## Coding Conventions

### agent.py Modes (Rust & Rainbow)
- `--mode generate` — design generation + Printify publish + Ryan approval
- `--mode market` — social posting (Instagram + TikTok + Pinterest), pillar rotation
- `--mode monitor` — legacy flag underperformer mode (now superseded by `--mode report`)
- `--mode report` — weekly self-learning loop: real data collection → AI narrative → Etsy optimisation → performance_log.json
- `--mode all` — runs generate → market → monitor in sequence (does NOT run report)
- `--yes` flag — skips all interactive confirmation prompts (required for cron/unattended runs)

### Optional API Keys Pattern (Rust & Rainbow — 2026-05-22)
When a feature depends on an optional API key (e.g. `ANTHROPIC_API_KEY` for AI narrative, Etsy keys for listing stats), the code should:
1. Check the key at runtime, not at startup
2. Log a clear `⚠` message explaining what's missing and what to do
3. Fall back gracefully to a reduced-feature mode (e.g. data-only report)
4. Never `sys.exit()` for optional features

### performance_log.json Structure (Rust & Rainbow — 2026-05-22)
Weekly performance data appended each Monday. Structure:
```json
{
  "weeks": [
    {
      "week_start": "YYYY-MM-DD",
      "week_end": "YYYY-MM-DD",
      "generated_at": "ISO timestamp",
      "orders_count": 0,
      "orders_this_week": 0,
      "revenue_this_week_cents": 0,
      "instagram": { "follower_count": 3, "recent_posts": [] },
      "listings": [],
      "optimizations_applied": []
    }
  ]
}
```
Etsy listing views are cumulative. Week-over-week delta = `this_week.views - prev_week.views`.
Always use `max(delta, 0)` — API occasionally returns a lower cumulative count on re-fetch.

---

## Vault Conventions

### YAML Frontmatter (required on all new notes)
```yaml
---
title: Note Title
project: hubitat | stock-agent | rust-and-rainbow | autobiz | system
type: state | tasks | worklog | system | dashboard | inbox
updated: YYYY-MM-DD
tags: [tag1, tag2]
---
```

### Task Format (Dataview-compatible)
```
- [ ] Task description [owner:: ryan|claude|antigravity|auto] [priority:: high|medium|low] [status:: open|in-progress|blocked|done]
```

### Wikilinks
Always link related notes with `[[Path/To/Note]]`. Paths are relative to vault root, no `.md` extension.
