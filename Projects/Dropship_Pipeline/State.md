---
title: Dropship Pipeline — State
project: Dropship_Pipeline
type: state
updated: 2026-07-04
tags: [dropship, automation, launchd, claude-headless]
---

# Dropship Pipeline — State

## What it is
Daily automated product-research pipeline: 4 chained headless `claude -p` agents (trend scanner → feasibility screener → plan builder → validator/devil's-advocate) appending to markdown logs in `~/MyVault/dropship-pipeline/`. Feeds the existing LLC; a GO verdict means "worth a Gate 5 paid-traffic test", not a validated business. Source unpacked from `~/Downloads/dropship-pipeline`.

## Current status (2026-07-04)
**Running for real, not theory.** Fired daily via launchd 7/2–7/4, spending real API cost ($0.66–$1.66/agent/day). Produced a **conditional GO on Dog Cooling Mats** (7/3 second pass, see verdicts-log.md) — Mouth Tape has been validated 3x and stays ITERATE on the same two unresolved blockers (undrafted safety disclaimer, no FTC ad-copy pass). Reaching an actual sale requires Ryan action below — the pipeline only produces research/decision output, it does not execute Gate 5 itself.

**Bug found + fixed this session:** agents/03-plan-builder.md and agents/04-validator.md prompts said "ready to append to X-log.md," ambiguous enough that the validator agent tried to write the file directly, got blocked in headless mode, and appended its own confused "I don't have write permission" narration into production verdicts-log.md instead of clean output. Fixed: both prompts now explicitly say the agent has no file access; added `--allowedTools ""` to every validator call site in run-pipeline.sh. Contaminated 7/4 entry was cleaned. Full pattern logged in [[feedback_scaffold_quality]] (global memory).

## What "production" actually requires from here
Business plan now at its third revision — see [[Projects/Dropship_Pipeline/Business_Plan_Dog_Cooling_Mats]] (single source of truth for the plan; don't duplicate detail here):
1. **True dropship, not bulk-buy** (rev 2): zero cash ever committed to inventory; every sale fulfilled order-by-order by a supplier shipping direct to the customer. Peer-reviewed by an adversarial agent, which found and forced fixes for refund/stockout handling, unoperationalized FTC shipping-disclosure, missing sales-tax setup, and a claimed-but-never-built bundle differentiator.
2. **<$100 cash cap, bootstrap ramp** (rev 3, current): Shopify dropped for a $0-hosting storefront on Vercel (reusing Welra's account) + Stripe (a NEW, separate account — Welra's stays untouched, it's in TEST mode under a standing do-not-touch). Initial cash ~$75–100 (one personal test order + a seed ad round); every round after is funded by the prior round's revenue, not new cash. This makes the ad-test phase open-ended in calendar time instead of a fixed 1-week sprint — the trade for the smaller cap.
3. Still open regardless of revision: get a real per-unit dropship cost (checked Alibaba's Dropshipping Center, AliExpress, CJdropshipping — all three block automated price lookups, Ryan must log in manually; CJ alone read too expensive, hence checking the other two).
4. Only after the ramp reaches a confident CAC read and passes: LLC placement, bank subaccount, resale certificate, buy a real domain, automate supplier order-sync.
None of this can be automated further — it's Ryan's calls and real-world actions (supplier logins, ad spend, entity paperwork).

## Prior status (2026-07-02, session: install + arch-review)
- **Installed** at `~/MyVault/dropship-pipeline/` (vault path — NOT `~/Documents/MyVault` as SETUP.md assumed; plist paths corrected).
- **Scheduled**: launchd job `com.ryan.dropship-pipeline` loaded, fires 7:00 daily + on login (`RunAtLoad`), marker-file dedup verified. Logs to `dropship-pipeline/logs/`.
- **BLOCKED on one Ryan action**: `claude` CLI keychain OAuth token expired 2026-06-22 → every headless call 401s. Re-login steps are at the top of `_RYAN_TODO.md`. Failed runs self-retry (no marker written), so it starts working automatically after re-login + next trigger.
- **Arch-review run**: 1 blocker (the auth), 5 silent-failure risks found and FIXED:
  1. `tac` doesn't exist on macOS → persistence gate saw empty history forever, agents 2–4 would never run (→ `tail -r`).
  2. Same-day retry after mid-pipeline failure duplicated scan entries → fake persistence (→ script owns `## $TODAY` heading + skips agent 1 if present).
  3. `grep -qi ADVANCE` matched prose like "no candidates advanced" (→ case-sensitive `\bADVANCE\b`).
  4. GO notification matched the GO inside NO-GO and went silent on mixed GO/NO-GO days (→ verdict-line regex, unit-tested).
  5. API errors died with empty logs (→ `run_claude` wrapper logs error + per-call `total_cost_usd`).
- **Per-agent models** (Ryan's request, token cost): scanner=haiku, screener=haiku, planner=sonnet, validator=sonnet — via `--model` in [run-pipeline.sh](../../dropship-pipeline/run-pipeline.sh).

## Expected behavior once unblocked
Days 1–2: scan entries only (screener correctly kills everything — needs 3 days of persistence). Day 3+: candidates can ADVANCE → plans → verdicts. macOS notification fires only on a real GO verdict line.

## Related
[[Knowledge_Base/Headless_Claude_Runbook]] · [[Projects/Dropship_Pipeline/Tasks]] · Gate-5 entity/compliance checklist lives in `dropship-pipeline/SETUP.md`.
