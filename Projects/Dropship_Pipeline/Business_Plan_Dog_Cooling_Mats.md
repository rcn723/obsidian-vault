---
title: Dog Cooling Mats — Business Plan (True Dropship, Bootstrap Ramp)
project: Dropship_Pipeline
type: plan
updated: 2026-07-04
tags: [dropship, business-plan, dog-cooling-mats, gate5, no-inventory, bootstrap]
---

# Dog Cooling Mats — Step-by-Step Business Plan (True Dropship, Bootstrap Ramp)

Source: pipeline-generated plan (7/3 second pass, `plans-log.md`) + validator verdict (7/3 second pass, `verdicts-log.md`) — **conditional GO**. Revised 2026-07-04, third pass, at Ryan's direction: **initial cash outlay capped under $100, reinvesting revenue to fund each subsequent stage, and reusing Welra infrastructure wherever it's actually free to do so.**

## What changed this revision
1. **Cash cap:** initial outlay ≤ $100 (down from the prior revision's ~$665–940). This is not a smaller version of the same test — it changes Phase 3 from a single 10–14 day paid-traffic sprint into a **multi-round ramp**, each round funded by the previous round's revenue. See Phase 3 below; this is the biggest structural change.
2. **Shopify dropped.** $40/mo doesn't fit under a $100 *total* cap once ad spend and a sample order are in it. Replaced with a $0-hosting storefront built on infrastructure Ryan already has running for Welra (below).
3. **Ad-account warmup as a separate paid line is dropped.** At this budget, the first ad round *is* the warmup — accept a noisier early CAC read as the cost of the smaller budget, not a free simplification.

## Leveraging Welra infrastructure — what's actually reusable at $0, and what isn't
Checked against Welra's actual setup (`Continuation_Playbook.md`), not assumed:
- **Vercel: reuse it.** Welra's web app deploys via `vercel deploy --prod` under Ryan's account. If that account is on a paid Team/Pro plan (likely, since it hosts a live commercial product), a second small project costs **$0 extra** — Vercel's per-seat/team pricing doesn't charge per-project. **Confirm the plan tier first** — if it's still on the free Hobby tier, Vercel's Hobby terms explicitly restrict commercial use, and running a for-profit storefront there would need an upgrade (not free) or a separate Hobby account (against ToS spirit, not recommended).
- **Stripe: do NOT reuse.** Welra's Stripe is explicitly in TEST mode and flagged as a standing **do-not-touch** item until a validated Welra beta user pays — going live on that account for an unrelated physical-goods store isn't in scope of that gate and would commingle two different businesses on one account right before Phase 5 planned a *separate* LLC/bank subaccount anyway. **Create a new, separate Stripe account instead — free to create, no monthly fee, only per-transaction fees (~2.9% + 30¢), paid out of revenue as it comes in, not upfront cash.** This is the right call for clean accounting even setting cost aside.
- **Railway: skip.** Railway is usage-based billing for Welra's API — adding a second workload there has a real, if small, marginal cost. Not free reuse; not worth it for a static storefront anyway.
- **Domain: defer, don't buy yet.** Use a free Vercel-provided subdomain (e.g. `dogcoolingmats.vercel.app`) for the test phase. Buy a real domain (~$10–15/yr via the same Namecheap account used for welra.io) only in Phase 5, after Gate 5 passes — it's a real but small cost not worth spending before there's a validated reason to.
- **Email: reuse.** Use the existing `ryannortham3@gmail.com` (already the designated inbox for side-project/monitoring email) as the storefront's contact address — $0, no new inbox needed at this stage.

## The storefront, concretely (replacing Shopify)
A single static product page (mat + bundle upsell), hosted on Vercel under the same account as Welra, using **Stripe Payment Links or Stripe Checkout** for the actual purchase — no Shopify subscription, no cart system needed for a one-SKU-plus-upsell test. Stripe Tax (a per-transaction add-on, not a monthly fee) handles sales tax collection without needing Shopify's built-in tax engine. Order notifications come via Stripe's dashboard/email — you manually forward each paid order to the chosen dropship supplier, same manual-fulfillment approach as the prior revision (still correct: full auto-sync is closer to a standing supplier contract than a test at this scale warrants).

**Trade-off, stated honestly:** this is less polished than a Shopify storefront (no cart, no built-in reviews/upsell widgets) and takes a few hours of setup work instead of a few clicks — that's the cost being paid instead of the $40/mo, and it's the right trade at this budget.

## The condition this plan hangs on (unchanged from prior revision)
**Real per-unit + shipping cost from whichever dropship channel turns out cheapest**, confirmed by logging in directly (every channel checked blocks automated price-checking — confirmed on CJdropshipping, Alibaba, and Doba this session).

**Three dropship channels to compare:**
1. **Alibaba's own Dropshipping Center** — dropship-tagged suppliers, single-unit orders, ship direct to customer, no MOQ. Typically 20–40% below AliExpress/CJ markups since it's closer to the factory — check this first.
2. **CJdropshipping** — confirmed matching SKU exists, no-MOQ, but read as the most expensive of the three — keep as fallback only.
3. **AliExpress** (via DSers or similar) — classic single-unit ship-direct, priced between the other two typically.

**Every dollar figure below is TBD until this is confirmed.** Treat the budget/ramp tables as placeholders.

## North star / definition of done
Reach a real go/no-go signal (Gate 5: measured blended CAC) with **zero capital ever at risk in inventory, and initial cash outlay under $100** — funding every stage past the first with realized revenue, not a larger upfront commitment.

---

## Phase 0 — Decision (today)
**Goal:** Ryan confirms the candidate, the model, and the cash cap.
- [ ] Confirm: proceed with Dog Cooling Mats via true dropship fulfillment, initial cash outlay capped at **under $100**
- [ ] Confirm: check Welra's Vercel plan tier before building the storefront there (Pro/Team → free reuse; Hobby → don't put a commercial store on it without upgrading)
- [ ] Accept the trade-offs: slower shipping (2–3 weeks), a DIY storefront instead of Shopify, a noisier first-round CAC read (no separate warmup budget), and a longer overall timeline than the original plan since later rounds wait on revenue rather than a single upfront ad budget

**Gate to move on:** Ryan says go.

---

## Phase 1 — Week 1: Confirm the supplier, build the $0 storefront, set up compliance
**Goal:** real per-unit dropship cost, a live and compliant storefront, all at $0–~$20 cash.

| Step | Action | Owner | Cost |
|---|---|---|---|
| 1 | Check **Alibaba's Dropshipping Center** first for a dropship-tagged cooling-mat supplier. Get real per-unit price + US shipping cost + delivery time | Ryan | $0 |
| 2 | Check **AliExpress** (via DSers or similar) as a second data point | Ryan | $0 |
| 3 | Log into **CJdropshipping** for their number too — fallback only | Ryan | $0 |
| 4 | Pick the cheapest that also passes the safety-documentation check (Step 5). Confirm a backup channel needs no storefront rebuild to switch to | Ryan | $0 |
| 5 | Confirm the chosen supplier can provide **non-toxic-gel safety documentation or a lab test certificate.** No real documentation = fail that supplier, move to backup | Ryan | $0 |
| 6 | Identify a second no-MOQ item for the **post-purchase upsell bundle** (cooling bandana or portable water bowl) — the actual differentiator being tested | Ryan | $0 |
| 7 | Confirm Welra's Vercel account plan tier (Pro/Team vs. Hobby) — determines whether the storefront is truly free to host | Ryan | $0 |
| 8 | Build the single-product storefront on Vercel (free subdomain), with Stripe Payment Links/Checkout for the mat + bundle upsell. Create a **new, separate** Stripe account — do not use Welra's | Ryan (or delegate) | $0 |
| 9 | Enable Stripe Tax for sales-tax collection (per-transaction fee, not upfront cash) | Ryan | $0 upfront |
| 10 | **Operationalize the shipping-time disclosure**: product page, checkout, and confirmation email all state "ships in 2–3 weeks"; pre-write the FTC-required delay-notice/cancellation-refund email template now | Ryan | $0 |
| 11 | Draft 5–8 dog-reaction-style TikTok ad concepts built around the bundle | Ryan | $0 |

**Gate to move on:** real per-unit dropship cost confirmed, $0-cost storefront live with tax/shipping-disclosure/delay-notice in place, safety documentation confirmed.

**Stop condition:** if the confirmed mat + bundle cost pushes contribution margin below ~$3–4/unit at benchmark CAC, stop here — needs a different candidate or a price fix before spending on ads.

---

## Phase 2 — Week 2: One test order, minimal ad setup
**Goal:** confirm fulfillment works and the product is safe, at the smallest possible spend.

| Step | Action | Owner | Cost |
|---|---|---|---|
| 1 | Place **one personal test order** (mat + bundle) through the live storefront to confirm fulfillment works and inspect real product quality | Ryan | ~$15–25 |
| 2 | Inspect both units against the safety documentation from Phase 1 | Ryan | included above |
| 3 | Write the manual-fulfillment steps as a runbook | Ryan | $0 |
| 4 | Set up TikTok Ads Manager + pixel. **No separate warmup spend budgeted** — Phase 3's Round 1 doubles as warmup; expect a noisier early CAC read as the trade-off for the smaller cap | Ryan | $0 |
| 5 | If the test order reveals a quality/safety problem: switch to the backup supplier before any ad spend | Ryan | — |

**Gate to move on:** one real order fulfilled and inspected, runbook written, ad account created.

**Running total so far: ~$15–25.**

---

## Phase 3 — Bootstrap Ad Ramp (replaces the single Week-3 Gate 5 sprint)
**Goal:** reach the same statistical bar the original Gate 5 required (10–14 days, cumulative spend past 3x target CPA), but funded in rounds by realized revenue instead of one upfront commitment. **This phase is open-ended in calendar time — it runs as long as it takes to either fund itself to a confident read or hit an early-kill signal.**

### Round 1 — Seed (the only round funded from the initial $100 cap)
| Step | Action | Cost |
|---|---|---|
| Launch conversion campaign on TikTok at **$10–15/day** | Run ~5–7 days | **~$60–75** |
| Monitor fulfillment daily via the Phase 2 runbook | — | — |
| **Early-kill check:** if Round 1 spends its full budget with zero sales, or CAC is wildly above ~$22 on the sales it does get, stop here — don't reinvest into a dead signal | — | — |

**Running total after Round 1: ~$75–100 (personal test order + Round 1 ad spend) — this is the entire cash cap. Everything past this point is funded by revenue, not new cash.**

### Round 2+ — Reinvestment rounds (funded by Round 1's revenue, and so on)
| Rule | Detail |
|---|---|
| **Reinvestment rate** | Reinvest 100% of net revenue (sales minus refunds/chargebacks, minus Stripe fees) from each round into ad spend for the next round, until the cumulative spend/time reaches the original Gate 5 bar |
| **Cumulative target** | Keep rounds going until total ad spend crosses roughly the original Gate 5 window — ~$500–700 equivalent cumulative, over a minimum ~10–14 days of *actual running* (excluding any pauses) |
| **Pacing** | If Round 1 sells well, later rounds can run at $30–50/day like the original plan once there's revenue to support it — the cap only constrains the *first* round, not the ceiling |
| **If revenue lags spend** | Don't borrow ahead — if a round's revenue doesn't cover the next round's target spend, run the next round smaller (whatever revenue actually supports) rather than dipping into new cash. This is slower than the original fixed-budget plan; that's the deliberate trade for keeping the cash cap real |
| **Stockout / refund handling** | Unchanged from the prior revision: pause immediately on stockout, switch to backup supplier, confirm one order before resuming; model 5–10% refund rate and read CAC net of refunds |

**Gate 5 — what it measures and what passes (unchanged targets, now read against cumulative ramp data):**
- **Metric:** blended CAC = cumulative ad spend ÷ cumulative **net** orders, read once cumulative spend clears ~3x target CPA (~$40–45) **and** the running window covers at least 10–14 days of actual ad-running time
- **Target CAC:** $13–15
- **Pass:** net CAC ≤ ~$13–15 and contribution margin (mat + bundle cost, net of refunds) stays positive → proceed to Phase 5
- **Soft pass:** net CAC ≤ ~$18 → keep ramping at the same pace, iterate creative, before increasing round size
- **Fail:** net CAC > ~$22, or unit economics net-negative even at benchmark CAC → kill the SKU, stop reinvesting

---

## Phase 4 — Decide (once the ramp reaches a confident read)
**Goal:** clean keep/scale/kill call.

| Result | Action |
|---|---|
| **Pass** | Proceed to Phase 5 — LLC/compliance checklist, then scale ad spend using ongoing revenue (and, if it now makes sense, some retained profit rather than needing new capital) |
| **Soft pass** | Iterate creative, keep ramping at current pace before growing round size |
| **Fail** | Kill this SKU. Nothing to unwind — no inventory, no warehouse. Take down the storefront, stop ad spend |

Re-check the seasonal timing flag: summer season runs through mid-September in target markets. Since the ramp's calendar length now depends on sales velocity, a slow Round 1 could push the confident-read point later into the season than the original fixed-timeline plan assumed — factor that in when deciding whether to keep ramping this summer or bank the learnings for next spring.

---

## Phase 5 — Only after Gate 5 passes: entity & compliance
- [ ] LLC placement decision — see `dropship-pipeline/SETUP.md`
- [ ] Bank subaccount for this SKU's cash flow
- [ ] Resale certificate
- [ ] Buy a real domain now (deferred from Phase 1) — ~$10–15/yr
- [ ] Automate the supplier order-sync integration (deferred from Phase 1's manual forwarding)
- [ ] (Nexus + insurance remain post-traction items; sales tax collection was already live via Stripe Tax from Phase 1)

---

## Budget summary — initial cash cap vs. total program cost

| Item | Cash required upfront |
|---|---|
| Storefront hosting (Vercel, reused) | $0 |
| Stripe account (new, separate from Welra) | $0 |
| Domain | $0 (deferred to Phase 5) |
| One personal test order (mat + bundle) | ~$15–25 |
| Round 1 ad spend (seed + de facto warmup) | ~$60–75 |
| **Total initial cash required** | **~$75–100** |
| Round 2+ ad spend | $0 new cash — funded entirely by Round 1+ revenue |

Compare to the prior revision's ~$665–940 upfront and the original bulk-buy model's ~$1,100–1,900 — this version needs **under $100** in new cash, full stop. The cost of that: a longer, revenue-paced timeline instead of a single fixed 10–14 day sprint, and a noisier first-round CAC read since there's no separate warmup budget.

## Unit economics — needs recalculation, flagged not assumed
Unchanged concern from the prior revision: the validator's $5–8/unit contribution estimate assumed bulk landed cost, not dropship per-unit cost, which is likely higher across all three channels checked. Confirm real numbers in Phase 1 before trusting any margin figure here.

## Timeline at a glance

| Stage | Milestone | Cash needed |
|---|---|---|
| 0 (today) | Ryan decision to proceed | $0 |
| 1 | Supplier + bundle confirmed, $0-storefront live, compliance in place | $0 |
| 2 | Test order placed + inspected, runbook written, ad account created | ~$15–25 |
| 3, Round 1 | Seed ad flight, ~5–7 days | ~$60–75 |
| 3, Round 2+ | Reinvestment rounds, length depends on sales velocity | $0 new cash |
| 4 | Confident-read decision: keep/iterate/kill | — |
| 5+ (only if pass) | Entity/compliance, domain purchase, order-sync automation, scale | — |

## Related
[[Projects/Dropship_Pipeline/State]] · [[Projects/Dropship_Pipeline/Tasks]] · full research in `dropship-pipeline/plans-log.md` and `dropship-pipeline/verdicts-log.md` (7/3 second-pass entries) · prior revisions: true-dropship rewrite (peer-reviewed, found refund/stockout/differentiator gaps), this pass adds the <$100 cash cap and Welra-infra reuse
