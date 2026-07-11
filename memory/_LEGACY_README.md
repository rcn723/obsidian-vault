---
title: LEGACY — do not add to this folder
type: system
updated: 2026-07-10
tags: [legacy, memory]
---

# ⚠️ Legacy memory layer (pre-June 2026)

This `memory/` folder was the original Claude Cowork memory system (last real update 2026-05-31). It is **superseded**:

- Session memory → Claude Code's memory dir (`~/.claude/projects/.../memory/`, indexed by `MEMORY.md`)
- Conventions/runbooks → [[Knowledge_Base/Learnings_and_Conventions]] and `Knowledge_Base/*_Runbook.md`
- Project state → `Projects/*/State.md` + [[_Dashboard]]
- Tasks → [[_RYAN_TODO]] + [[_Master_Tasks]] + `Projects/*/Tasks.md`

Kept for history and because other tools (Cowork/Antigravity) may still read it. **Don't write new memory here.** The `CLAUDE.md` inside instructing "read all files at session start" is stale — ignore it.
