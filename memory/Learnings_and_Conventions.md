---
title: Learnings and Conventions
type: system
updated: 2026-05-22
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

### Meta Access Token — Expiry (2026-05-21 / ongoing)
META_ACCESS_TOKEN for Rust & Rainbow expires **2026-07-01**. Must refresh by **June 25** at developers.facebook.com → Tools → Access Token Debugger → Extend. Failing to refresh causes Instagram + Facebook posts to fail silently.

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
