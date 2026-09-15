---
title: Dashboard
type: dashboard
updated: 2026-09-13
---

# Dashboard

> Start here every session. Ryan's working doc is **[[_RYAN_TODO]]**; the full cross-project inventory is **[[_Master_Tasks]]**.
> Dataview queries below stay clean because of the 2026-07-10 task overhaul — if they fill with noise again, run `vault-audit`.
> 🔴 2026-09-13: NAS SSH is down (blocks Rust & Rainbow + Stock Agent live checks) — see [[_RYAN_TODO]] top item.

---

## The two task docs

| Doc | What it's for |
|---|---|
| ⭐ [[_RYAN_TODO]] | **Ryan works ONLY from this** — priority-ordered, exact steps, paste-ready copy |
| 🗂 [[_Master_Tasks]] | Complete live inventory (all owners, all projects, Dataview-powered) — the audit view |

---

## Projects

| Project | State | Tasks | Focus (2026-09-13) |
|---|---|---|---|
| [[Projects/Welra/State\|Welra]] | [[Projects/Welra/Continuation_Playbook\|Playbook ⭐]] | [[Projects/Welra/Tasks\|Tasks]] | Infra verified healthy today (crons, report delivery) · 1 free beta customer, $0 revenue · staged blog post 22 days un-shipped |
| [[Projects/Rust_and_Rainbow/State\|Rust & Rainbow]] | [[Projects/Rust_and_Rainbow/State\|State]] | [[Projects/Rust_and_Rainbow/Tasks\|Tasks]] | 🔴 NAS SSH down (unverified posting/supervisor) · Mac-side tokens all live · bg-removal queue grew to 16 |
| [[Projects/Stock_Agent/State\|Stock Agent]] | [[Projects/Stock_Agent/Go_Live_Plan\|Go-Live Plan]] | [[Projects/Stock_Agent/Tasks\|Tasks]] | 🔴 Unverified — NAS down; last confirmed 06-25/26 (23/30 trades, gate failing correctly) |
| [[Projects/Dropship_Pipeline/State\|Dropship Pipeline]] | [[Projects/Dropship_Pipeline/Business_Plan_Dog_Cooling_Mats\|Business Plan]] | [[Projects/Dropship_Pipeline/Tasks\|Tasks]] | Running clean daily · latest verdicts (08-12) both stalled · still waiting on Ryan's supplier pricing |
| [[Projects/Hubitat/State\|Hubitat]] | [[Projects/Hubitat/State\|State]] | [[Projects/Hubitat/Tasks\|Tasks]] | Rule Machine build-out — no deadline, Hubitat-app evenings |
| [[Projects/AutoBiz/State\|AutoBiz (GR3NB)]] | [[Projects/AutoBiz/State\|State]] | [[Projects/AutoBiz/Tasks\|Tasks]] | LLC formation DONE — only home-office worksheet + calendar reminders + trademark decision left |

---

## Ryan — Action Required (high priority)

```dataview
TASK
FROM "Projects"
WHERE !completed AND contains(string(owner), "ryan") AND priority = "high" AND status != "blocked"
SORT file.folder ASC
```

## Blocked Tasks

```dataview
TASK
FROM "Projects"
WHERE !completed AND status = "blocked"
GROUP BY file.folder
```

## Upcoming Deadlines

```dataview
TASK
FROM "Projects"
WHERE !completed AND due
SORT due ASC
```

---

## Inboxes & Logs
- [[_Inbox/To_Claude]] · [[_Inbox/To_Antigravity]]
- [[Worklogs/Claude_Log]] · [[Worklogs/Antigravity_Log]]

## Operating system
- [[Knowledge_Base/Claude_Usage_SOP]] — how sessions run (skills, lifecycle, trigger words)
- [[Knowledge_Base/Automation_Architecture]] — every scheduled job in one place
- Vault hygiene: `vault-audit` skill (task-drift + clutter check; also part of `sunday-review`)
