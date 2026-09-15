---
title: Master Tasks — every open task, every project, every owner
type: tasks-index
updated: 2026-09-13
tags: [tasks, master, live]
---

# 🗂 Master Tasks — all projects, all owners

> **How this relates to [[_RYAN_TODO]]:** that file is Ryan's curated *do-this-next* doc — ordered, with exact steps and paste-ready copy. **This file is the complete live inventory** — every open task across every project's Tasks.md, including Claude-owned and automation-owned work, powered by Dataview so it can never go stale. Use it to audit ("is anything falling through?"), not to plan your day.
>
> **Kept trustworthy by:** the 2026-07-10 vault overhaul (272 → 69 open tasks; stale/superseded items closed with evidence, cold-storage checkboxes neutralized to ◻) and the `vault-audit` skill, which re-checks for drift. If a query below shows junk, that's a vault-audit trigger, not a reason to ignore this file.

---

## 🔴 Ryan — high priority (the queue that matters)

```dataview
TASK
FROM "Projects"
WHERE !completed AND contains(string(owner), "ryan") AND priority = "high" AND status != "blocked"
SORT file.folder ASC
```

## 🟠 Ryan — everything else open

```dataview
TASK
FROM "Projects"
WHERE !completed AND contains(string(owner), "ryan") AND (priority != "high" OR status = "blocked")
GROUP BY file.folder
```

## 🤖 Claude / automation — open queue

```dataview
TASK
FROM "Projects"
WHERE !completed AND (contains(string(owner), "claude") OR contains(string(owner), "auto") OR contains(string(owner), "antigravity")) AND !contains(string(owner), "ryan")
GROUP BY file.folder
```

## ⛔ Blocked — waiting on something

```dataview
TASK
FROM "Projects"
WHERE !completed AND status = "blocked"
GROUP BY file.folder
```

## 📊 Open-task count by project

```dataview
TABLE length(filter(file.tasks, (t) => !t.completed)) AS "Open tasks", file.frontmatter.updated AS "Last updated"
FROM "Projects"
WHERE file.name = "Tasks"
SORT length(filter(file.tasks, (t) => !t.completed)) DESC
```

---

## 📌 Snapshot — 2026-09-13 (static, for reading outside Obsidian)

*Claude refreshes this section whenever `vault-audit` or `session-close` runs. Full refresh from today's sunday-review — the first REAL one since 2026-07-12 (the automated weekly job silently failed 8 of the last 9 weeks on an expired headless-CLI refresh token; see `Knowledge_Base/Headless_Claude_Runbook.md`). Not a first-of-month vault-audit — task counts grew modestly (75 across the original 6 projects, vs the 69 baseline) and don't look noisy yet; next full audit due first Sunday of October (2026-10-04):*

| Project | Open | What's actually live |
|---|---|---|
| **Welra** (23) | ✅ Infra fully healthy (health 200, git clean, all crons firing, last Sunday's report confirmed delivered) · 1 free beta customer (R&R), $0 revenue, Stripe test mode · staged blog post now 22 days un-shipped, awaiting approve+deploy · beta user #1 outreach ongoing | [[Projects/Welra/Tasks]] |
| **Hubitat** (17) | Not in sunday-review scope this week — unchanged since 2026-05-21 | [[Projects/Hubitat/Tasks]] |
| **Rust & Rainbow** (16) | 🔴 NAS SSH down (blocks posting-log/supervisor checks) · Mac-side tokens all live (Instagram, FB Page, Zernio) · **NEW:** bg-removal queue grew 2→16 pending designs · still-unverified 3-post manual deletion from 07-17 · Meta Business Verification still pending | [[Projects/Rust_and_Rainbow/Tasks]] |
| **Photo_Archive** (10) | Not in sunday-review scope this week — unchanged since 2026-07-12 | [[Projects/Photo_Archive/Tasks]] |
| **Stock Agent** (8) | 🔴 UNVERIFIED — NAS SSH down, couldn't confirm paper_mode/trade count/reporter-deploy live; last confirmed 06-25/26 (23/30 trades, gate failing correctly) | [[Projects/Stock_Agent/Tasks]] |
| **Dropship** (7) | ✅ Running clean daily since 07-04, no real gaps · fixed 2 fresh exit-127 failures with a retry · latest verdicts (08-12) both stalled: Qi2 ITERATE, water bottles NO-GO · Dog Cooling Mats still waiting on Ryan's supplier pricing | [[Projects/Dropship_Pipeline/Tasks]] |
| **AutoBiz/GR3NB** (6) | Not in sunday-review scope this week — unchanged since 2026-06-21 | [[Projects/AutoBiz/Tasks]] |
| **WordBloom (Petal Words)** (22) | Not in sunday-review scope this week — dormant since 2026-07-17 (App-Store-ready to the Xcode boundary) | [[Projects/WordBloom/Tasks]] |

**Cross-project daily habits (from [[_RYAN_TODO]]):** 2 give-first comments/day (IH counts) · Reddit/FB round 2 gated on fixing the FB profile first.

---

## Rules that keep this working

1. Every task line in any `Projects/*/Tasks.md` carries `[owner:: ryan|claude|antigravity|auto] [priority:: high|medium|low] [status:: open|in-progress|blocked|done]` — no naked checkboxes.
2. Cold storage never uses `- [ ]` — neutralize to `◻` (see the Welra Archive section for the pattern).
3. A Ryan-action must ALSO exist in [[_RYAN_TODO]] with steps + paste-ready copy; this file is the safety net, that file is the workbench.
4. Drift between the two = run `vault-audit`.
