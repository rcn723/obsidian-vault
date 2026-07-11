---
title: Master Tasks — every open task, every project, every owner
type: tasks-index
updated: 2026-07-10
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

## 📌 Snapshot — 2026-07-10 (static, for reading outside Obsidian)

*Claude refreshes this section whenever `vault-audit` or `session-close` runs. Counts after the 2026-07-10 cleanup:*

| Project | Open | What's actually live |
|---|---|---|
| **Welra** (21) | Beta user #1 outreach (DMs sent, watch replies) · IH warm-up · Resend broadcast · TikTok demo video → submit · Shopify readiness flip + smoke test · BetaList · gated go-live items (Stripe live mode, connection caps) | [[Projects/Welra/Tasks]] |
| **Hubitat** (17) | All Ryan-in-app: fix presence/ThinQ/Ecobee blockers, then build the 8 rules — no deadline | [[Projects/Hubitat/Tasks]] |
| **Rust & Rainbow** (11) | 🔴 Meta Business Verification · FB/IG bio website fields · first real `--mode generate` review · TikTok review watch · blank-cost check · commit agent.py changes | [[Projects/Rust_and_Rainbow/Tasks]] |
| **Stock Agent** (7) | Forward-test reporter deploy (one `./deploy.sh stock`) · watch 30-trade gate (auto) · strategy repairs (Claude, low) | [[Projects/Stock_Agent/Tasks]] |
| **Dropship** (7) | Vercel tier check · 3-channel supplier pricing · gel safety docs · bundle item · then storefront build | [[Projects/Dropship_Pipeline/Tasks]] |
| **AutoBiz/GR3NB** (6) | Home-office worksheet + photo · 3 calendar reminders · trademark decision (deferrable) · Supabase creds → README | [[Projects/AutoBiz/Tasks]] |

**Cross-project daily habits (from [[_RYAN_TODO]]):** 2 give-first comments/day (IH counts) · Reddit/FB round 2 gated on fixing the FB profile first.

---

## Rules that keep this working

1. Every task line in any `Projects/*/Tasks.md` carries `[owner:: ryan|claude|antigravity|auto] [priority:: high|medium|low] [status:: open|in-progress|blocked|done]` — no naked checkboxes.
2. Cold storage never uses `- [ ]` — neutralize to `◻` (see the Welra Archive section for the pattern).
3. A Ryan-action must ALSO exist in [[_RYAN_TODO]] with steps + paste-ready copy; this file is the safety net, that file is the workbench.
4. Drift between the two = run `vault-audit`.
