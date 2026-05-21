---
title: To Antigravity
type: inbox
updated: 2026-05-21
---

# To Antigravity

*Inbox for handoffs from Claude Code to Antigravity.*

---

## 2026-05-21 — Vault Restructure

**From:** Claude Code
**Read:** ☐

Hi Antigravity — the vault has been restructured to use proper Obsidian conventions. Here's what changed and what you need to know going forward.

### What changed

The old flat `memory/Project_State.md` mega-file has been split into per-project files. `Project_State.md` is now just an index pointing to the new structure.

**New file structure:**
```
Projects/
  Hubitat/       State.md + Tasks.md
  Stock_Agent/   State.md + Tasks.md
  Rust_and_Rainbow/  State.md + Tasks.md
_Dashboard.md    ← start every session here
```

### Conventions going forward (both of us)

All new notes need YAML frontmatter:
```yaml
---
title: Note Title
project: hubitat | stock-agent | rust-and-rainbow | system
type: state | tasks | worklog | system | dashboard
updated: YYYY-MM-DD
tags: [tag1, tag2]
---
```

All tasks use `- [ ]` checkboxes with inline Dataview fields:
```
- [ ] Task description [owner:: ryan] [priority:: high] [status:: open]
```

Link between notes with `[[wikilinks]]`. The Dashboard uses Dataview to query all tasks across `Projects/`.

### Your open task

You have one open task in `Projects/Rust_and_Rainbow/Tasks.md`:
- Fix `run_monitor()` — `sales` hardcoded 0. Needs Printify order API (`GET /v1/shops/{shop_id}/orders.json`) to pull real sales counts. Low priority until sales actually start.

### Install Dataview plugin

The `_Dashboard.md` queries won't render until Dataview is installed in Obsidian. Install it from Settings → Community plugins → search "Dataview".

---

Questions? Write back in `_Inbox/To_Claude.md`.

---

## 2026-05-21 — New Project: AutoBiz (DataBrief)

**From:** Claude Code
**Read:** ☐

Ryan asked for an autonomous business plan. I drafted a full plan for **DataBrief** — an AI-powered B2B SaaS that auto-generates weekly business intelligence reports for small businesses.

New files created:
- `Projects/AutoBiz/Business_Plan.md` — full plan
- `Projects/AutoBiz/State.md`
- `Projects/AutoBiz/Tasks.md`
- Added to `_Dashboard.md`

Ryan needs to make two decisions before building starts:
1. Confirm business name (DataBrief or alternative)
2. File Wyoming LLC ($100 at sos.wyo.gov)

No code built yet — awaiting Ryan's go-ahead.
