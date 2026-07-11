---
title: Claude Usage SOP — how Ryan and Claude work together
project: cross-project
type: sop
updated: 2026-07-10
tags: [sop, process, claude, skills, automation]
---

# Claude Usage SOP

> **What this is:** the standard operating procedure for how Claude sessions run across all of Ryan's projects, derived from a full audit of ~35 logged sessions (2026-05-20 → 2026-07-04). It names what was going wrong, the skills/agents built to fix it, and the small set of behavior changes that matter. Companion doc: [[Knowledge_Base/Automation_Architecture]].

---

## 1. What the usage audit found

**Working well (keep doing):**
- The `arch-review` gate + continuous-learning loop — 49 bug patterns, real blockers caught before nearly every deploy.
- Runbooks for ops incidents (DNS, NAS SSH, headless Claude, app review) — incidents became 5-minute lookups.
- `_RYAN_TODO.md` as the single Ryan-facing doc.
- The `/welra` T0–T3 loop and the stage-and-notify growth pipeline.
- Adversarial validation of plans (s5: refuted 2 of 8 recommendations, found 3 live bugs).

**Recurring failures (each now has a named fix):**

| # | Failure (evidence) | Fix |
|---|---|---|
| 1 | Memory-loop lapses — full sessions ended with State/Worklog/To_Antigravity stale until Ryan called it out (s22) | `session-close` skill; `vault-scribe` agent for mid-session milestones |
| 2 | Deploy drift — live-but-uncommitted code (s25), concurrent-session git drift (s29), 4 consecutive deploy failures from skipped local builds | `deploy-gate` skill, mandatory before any deploy |
| 3 | Weekly review procedure re-derived every Sunday from a prompt baked into a shell script | `sunday-review` skill (versioned, improvable) |
| 4 | Growth pipeline generated ideas 4×/day while 7 Ryan-owned outreach items sat unexecuted across 6+ runs — idea supply outran execution | Execution-debt gate in the pipeline (skips idea generation at ≥5 stalled items) + cadence cut to 2×/day + `monday-kickoff` brief |
| 5 | Platform app applications repeatedly relearned the same reviewer traps (Etsy ×3, TikTok ×2) | `app-review` skill |
| 6 | Ops-incident → runbook rule existed only as prose; format/indexing inconsistent | `capture-runbook` skill |

---

## 2. The session lifecycle (the core behavior change)

Every working session follows: **Open → Work → Milestone → Close.**

**Open.** Read `_Dashboard.md` + `_Inbox/To_Claude.md`; for Welra, start with `/welra` (or the [[Projects/Welra/Continuation_Playbook]]). Check memory reminders. Don't rebuild what exists.

**Work.** Existing rules apply: read before write, verify against source, plan before 3+-file changes. Before presenting any plan/strategy/findings as final → spawn the **`adversarial-validator` agent**. Before calling any scaffold/schema/multi-service work done → **`arch-review`**.

**Milestone** (a deploy went green, a feature shipped, a decision landed). Close the loop NOW, not at session end: run **`deploy-gate`** for the deploy itself, then **`session-close`** (or delegate to the **`vault-scribe`** agent to keep building).

**Close.** Run **`session-close`**. If any troubleshooting ran >~5 diagnostic steps → **`capture-runbook`** first.

## 3. Skill map — invoke by situation

| Situation | Invoke |
|---|---|
| About to run `railway up` / `vercel deploy` / `deploy.sh` / prod env edit | `deploy-gate` |
| Milestone reached or session ending | `session-close` |
| Weekly ops check (Sundays) | `sunday-review` |
| Ops incident just resolved / >5 diagnostic steps | `capture-runbook` |
| Drafting/reviewing any platform API application | `app-review` |
| Scaffold/schema/multi-service work "done" | `arch-review` |
| Welra session start / re-rank | `/welra` |
| Pre-prod Welra deep test | `welra-e2e-audit` workflow |
| Plan/recommendation about to be presented | `adversarial-validator` agent |
| Vault bookkeeping mid-flow | `vault-scribe` agent |
| Dashboard/task queries noisy · monthly hygiene · "are the task lists right?" | `vault-audit` (added 2026-07-10) |

## 4. Standing rules (unchanged, restated for one-stop reference)

- **Execution-first:** when Ryan-owned outreach items are ≥5, Claude's job is to shrink the queue (sharpen, unblock, remove friction), never to lengthen it. This is now enforced in the growth pipeline's Stage 0 gate.
- `tsc --noEmit` + `npm run build` before every push. git push does NOT deploy Welra. Railway Logs tab, not Deploy tab. Railway never reads `.env`.
- **Harness enforcement (added 2026-07-06 PM):** a PreToolUse hook in `~/.claude/settings.json` injects a deploy-gate reminder into Claude's context on any `railway up` / `vercel deploy` / `deploy.sh` command — the gate no longer depends on Claude remembering. Non-blocking; silent on all other commands.
- `delivered` status never proves an email sent — only the send log does.
- Verify credentials/tokens by live API call against the correct host, never file presence.
- Never lead with "AI" in customer/platform-facing copy; "clear," not "plain English."
- First-person content claims must trace to a vault artifact (s28 fabrication lesson).
- Code bugs → `feedback_scaffold_quality.md` + arch-review skill; ops incidents → runbooks. Different homes.
- **Task-system contract (added 2026-07-10):** [[_RYAN_TODO]] = Ryan's curated workbench; [[_Master_Tasks]] = the complete Dataview-powered inventory (all owners); project Tasks.md = Claude's per-project layer. Every live task line carries `owner/priority/status` fields; cold storage uses `◻` not `- [ ]` so queries stay clean (2026-07-10 overhaul cut 272 phantom-open tasks to 69 real ones). Drift → `vault-audit`.

## 5. Ryan's usage changes (the short list)

1. **Trust the Monday kickoff.** Every Monday 7:30am you get a 3-item week plan from `_RYAN_TODO.md`. Do those three; ignore the rest of the queue.
2. **Say the trigger words.** "Deploy" fires `deploy-gate` end-to-end; "wrap up" fires `session-close`; "sunday review" fires the weekly check. You don't need to remember the checklists — the skills are the checklists.
3. **Expect fewer growth-pipeline pings.** It now runs 2×/day and stays silent while your queue is ≥5 deep. Fewer, better asks.
4. **Report task completions immediately** ("sent the DMs", "they said yes") — that's what re-opens the idea tap and re-ranks everything.
5. When starting any *new* project scaffold, the same gates apply automatically — arch-review before "done," deploy-gate before shipping, session-close after.

## 6. Maintenance of this SOP

This doc is Claude's to maintain. When a skill gains a failure mode, or an automation changes schedule/behavior, update this file and [[Knowledge_Base/Automation_Architecture]] in the same session (that's part of `session-close` step 6 spirit: learnings live where the next session will look).
