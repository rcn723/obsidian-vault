---
title: Dashboard
type: dashboard
updated: 2026-06-23
---

# Dashboard

> Powered by the [Dataview plugin](https://obsidian.md/plugins?id=dataview). Install it to activate all queries below.
> Start here every session — this replaces `Knowledge_Base/Project_State.md` as the entry point.

---

## Projects

| Project | State File | Focus |
|---|---|---|
| [[Projects/Hubitat/State\|Hubitat]] | [[Projects/Hubitat/Tasks\|Tasks]] | Rule Machine build-out |
| [[Projects/Stock_Agent/State\|Stock Agent]] | [[Projects/Stock_Agent/Tasks\|Tasks]] | Paper trading — 3/30 trades to go live |
| [[Projects/Rust_and_Rainbow/State\|Rust & Rainbow]] | [[Projects/Rust_and_Rainbow/Tasks\|Tasks]] | Live — posting now on NAS (Mac-independent); META token refresh due 6/25 |
| [[Projects/AutoBiz/State\|AutoBiz (DataBrief)]] | [[Projects/AutoBiz/Tasks\|Tasks]] | Planning — business plan drafted |
| [[Projects/Welra/State\|Welra]] | [[Projects/Welra/Tasks\|Tasks]] | Beta runway — **start at [[Projects/Welra/Continuation_Playbook\|Continuation Playbook]]**; blockers: Anthropic credits, Etsy resubmit 6/25 |

---

## Ryan — Action Required

```dataview
TASK
FROM "Projects"
WHERE !completed AND owner = "ryan"
SORT priority DESC
```

---

## Blocked Tasks

```dataview
TASK
FROM "Projects"
WHERE !completed AND status = "blocked"
GROUP BY file.folder
```

---

## Upcoming Deadlines

```dataview
TASK
FROM "Projects"
WHERE !completed AND due
SORT due ASC
```

---

## All Open Tasks by Project

```dataview
TASK
FROM "Projects"
WHERE !completed
GROUP BY file.folder
```

---

## Inboxes
- [[_Inbox/To_Claude]]
- [[_Inbox/To_Antigravity]]

## Worklogs
- [[Worklogs/Claude_Log]]
- [[Worklogs/Antigravity_Log]]
