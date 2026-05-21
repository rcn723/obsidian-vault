---
title: AI Co-Working Protocol
type: system
updated: 2026-05-21
---

# AI Co-Working Protocol

Shared memory and communication layer between Claude Code and Antigravity.
Start every session at [[_Dashboard]] — it's the live view across all projects.

---

## Core Directives

### 1. Start of Session
- Open [[_Dashboard]] — Dataview queries show all open tasks, blocked items, and deadlines
- Read `_Inbox/To_Claude.md` or `_Inbox/To_Antigravity.md` for handoffs
- Read the relevant `Projects/[Project]/State.md` if focused on a specific project

### 2. During Session
- Update `Projects/[Project]/State.md` as work progresses
- Check off tasks in `Projects/[Project]/Tasks.md` when complete — mark `[x]`
- Add new tasks to the relevant Tasks.md with proper inline fields (see format below)
- Log new conventions or bugs in [[memory/Learnings_and_Conventions]]

### 3. End of Session
- Log completed work in `Worklogs/Claude_Log.md` or `Worklogs/Antigravity_Log.md`
- Update `updated:` frontmatter date on any State.md files changed
- Write to the other AI's inbox if handoff is needed
- Clear your own inbox after addressing all messages (replace with `- (Inbox clear)`)
- **Always update `_Inbox/To_Antigravity.md`** when Claude updates any memory or state file

---

## Obsidian Conventions

These apply to **all new notes** written to this vault.

### YAML Frontmatter (required on every note)
```yaml
---
title: Note Title
project: hubitat | stock-agent | rust-and-rainbow | system
type: state | tasks | worklog | system | dashboard
updated: YYYY-MM-DD
tags: [tag1, tag2]
---
```

### Task Format
All tasks use `- [ ]` checkboxes with inline Dataview fields:
```
- [ ] Task description [owner:: ryan] [priority:: high] [status:: open]
- [ ] Blocked task [owner:: ryan] [priority:: high] [status:: blocked]
- [x] Completed task [owner:: claude] [priority:: medium] [status:: done]
```

**owner values:** `ryan` | `claude` | `antigravity` | `auto`
**priority values:** `high` | `medium` | `low`
**status values:** `open` | `in-progress` | `blocked` | `done`
**due (optional):** `[due:: YYYY-MM-DD]`

### Wikilinks
Link between related notes using `[[Path/To/Note]]` or `[[Path/To/Note|Display Name]]`.
Every State.md links to its Tasks.md and back. Dashboard links to all State files.

### Tags
Use `#ryan-action`, `#blocked`, `#urgent` in note body for quick filtering.
Use the `tags:` frontmatter array for note-level classification.

---

## File Structure

```
MyVault/
├── _Dashboard.md              ← Start here every session
├── _Inbox/
│   ├── To_Claude.md
│   └── To_Antigravity.md
├── Projects/
│   ├── Hubitat/
│   │   ├── State.md
│   │   └── Tasks.md
│   ├── Stock_Agent/
│   │   ├── State.md
│   │   └── Tasks.md
│   └── Rust_and_Rainbow/
│       ├── State.md
│       └── Tasks.md
├── memory/
│   ├── Project_State.md       ← Index only, points to Projects/
│   └── Learnings_and_Conventions.md
├── Worklogs/
│   ├── Claude_Log.md
│   └── Antigravity_Log.md
└── System/
    └── Protocol.md            ← This file
```

---

## Recommended Obsidian Plugins
- **Dataview** — powers all `_Dashboard.md` queries (essential)
- **Tasks** — due dates, recurring tasks, task view in sidebar
- **Templater** — standardized frontmatter on new notes
- **Periodic Notes** — daily/weekly review notes linked to worklogs
