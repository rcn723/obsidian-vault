---
title: Welra Strategy Review — Path to Launch
project: Welra
type: strategy-review
updated: 2026-06-09
tags: [welra, strategy, pricing, architecture, review, launch]
---

# Welra Strategy Review — 2026-06-09

Full review of business plan v5, pricing, implementation state, and key learnings, requested before continuing to Stripe live mode. Findings were drafted from all source documents ([[Projects/AutoBiz/Business_Plan]], [[Projects/AutoBiz/State]], [[Projects/AutoBiz/Tasks]], [[Projects/Welra/State]], [[Knowledge_Base/Learnings_and_Conventions]]) plus direct code and Stripe API verification, then **adversarially validated by an independent review agent** that refuted two of my draft conclusions and surfaced three live bugs. Everything below survived that pass.

---

## Verdict: the business is sound; the sequencing was drifting

The fundamentals hold up. The whitespace claim ("nothing under $149/mo writes plain-English cross-platform weekly reports") was re-checked against the competitive table and still stands. Unit economics are excellent (95–97% gross margin), capital risk is trivial (~$500), and the infrastructure now demonstrably works end-to-end (billing loop validated today).

The risk is **not** the model, the market, or the stack. It is that months of effort went into billing/infra while the actual product — report quality on real seller data — has never run once with real data, and the two longest-lead-time dependencies (Etsy + Shopify developer approvals, 4–8 weeks) were never submitted. The plan itself sequenced beta validation (Phase 5) *before* launch; execution drifted past it toward the live-mode switch.

---

## 1. Critical path (do these first, in this order)

1. **Submit Etsy developer application + Shopify Partner application — today.** Free, 15 minutes each, 4–8 week approval lead. Every week of delay is a week added to the launch date. Nothing else on this list blocks them. [owner:: ryan]
2. **Build CSV upload (the plan's own "universal fallback").** The risk register's #1 mitigation — "WooCommerce + CSV launch while waiting for Etsy" — is half unbuilt: there is **no CSV upload, no Google Sheets bridge, no Make webhook** in the codebase. Until Etsy approval or CSV lands, the beta pool is WooCommerce-only while the primary ICP is Etsy sellers. CSV unblocks beta recruitment from *any* platform. [owner:: claude]
3. **Recruit 3–5 beta users on free accounts before live mode.** This is the plan's Phase 5, skipped in practice. Live-mode Stripe is not the gating item for learning; report quality is. Note: `REPORT_DRY_RUN` is a global flag — beta sends are manual or all-on, there is no per-customer gating (build one if needed). [owner:: ryan]
4. **Then** flip Stripe live (see pricing actions below).

## 2. Pricing — keep what's implemented, fix the documents

Three sources disagreed:

| Source | Tiers | Prices |
|---|---|---|
| Business plan v5 | Starter/Pro/Multi/Agency | $19 / $49 / $99 / $299 |
| Implemented (Stripe + site + code) | Starter/Pro/Growth | $19 / $69 / $129 |
| AutoBiz State.md | plan prices | stale |

**Decision (recommended, applied to docs):** the implementation is the source of truth. $69/$129 still sits under the $149 whitespace ceiling with better unit economics, and the pricing-page code documents the Growth annual discount (25%, 3 months free) as a **deliberate conversion hook** — my draft recommendation to "fix" it to $1,290 was refuted by the adversarial review and dropped. Agency tier is deferred until demand signal (site already has a contact-sales path).

**Validation still owed:** willingness-to-pay at $69/$129 is untested. Treat beta as the pricing test: ask every beta user the Van Westendorp basics before launch.

**Live-mode landmine (now mitigated in code):** `getPlanFromPriceId` silently defaulted unknown price IDs to `'starter'` — one typo'd `STRIPE_PRICE_*` var during live-price recreation would mis-plan every customer with zero errors. It now logs loudly. Still: **verify all 6 price-ID env vars against the live products when switching.**

## 3. Bugs found by this review (fixed today, deployed)

All three were in the project's *own* conventions library as "lessons learned" yet still live in code — see §6 for what that means for process.

| Bug | Impact | Fix |
|---|---|---|
| `REPORT_DRY_RUN: z.coerce.boolean()` — `Boolean('false') === true` | The documented launch step "set REPORT_DRY_RUN=false" would have **silently no-opped; reports would never send** | Strict `z.enum(['true','false'])` + safe default `'true'` |
| `mapStripeStatus: incomplete → 'trialing'` | `incomplete` = initial payment **failed**; scheduler serves `trialing` → failed payments got product access | Maps to `'past_due'` |
| `getPublicUrl` on the private `reports` bucket | Every stored `pdf_url` was a permanent 403 | 12-month signed URL (matches retention policy) |

Also noted: a live `trialing` customer row exists (test user, trial ends 2026-06-24) and the Sunday scheduler targets `active`+`trialing` — the pipeline's **first-ever run will happen automatically this Sunday** for a customer with no integrations. Dry-run is confirmed ON in Railway, so nothing sends; expect a partial/empty report log. Watch it — it's a free integration test.

## 4. Architecture — sound; add the safety rails that prevent rework

The stack (Fastify/Railway, Supabase, BullMQ, Next/Vercel, Resend, Stripe) is validated and right-sized. No re-platforming recommended. Gaps, in priority order:

1. **CI pipeline (GitHub Actions: `tsc --noEmit` + build on every push)** — zero test files and no CI exist today. This directly attacks the documented "4 consecutive deploy failures" pattern. Later: vitest for webhook handler + plan-mapping logic (the code that costs money when wrong).
2. **Wire Railway GitHub auto-deploy** (already a tracked task) — `railway up` as the only deploy path is a single-operator trap.
3. **Sentry + Uptime Robot before live** — both are marked "✅ Mitigated" in the risk register but neither is installed. Free tiers, ~30 min.
4. **Report-quality eval harness** — the report **is** the product and has zero testing loop. Build 3–5 golden sample datasets (synthetic Etsy/Woo/multi-channel weeks) → generate reports → score against a rubric (accuracy of numbers, no hallucinated causes, actionability). Run on every prompt change. This is the highest-leverage testing investment available.
5. **Model choice:** both passes use `claude-haiku-4-5` (valid ID). During beta, A/B the synthesis pass against a Sonnet-class model — at ~$0.50→$2/customer/mo the margin impact is negligible and synthesis quality is the differentiator.
6. **Dead code:** `packages/types` still exports `'agency'` in `PlanTier` and reportGenerator carries agency TIER_CONFIG while checkout rejects it — remove or gate to avoid confusing future sessions.

## 5. EU/compliance gaps (pre-live, cheap)

- Checkout has **no EU billing-address check** — the plan specifies 3 enforcement layers; only middleware exists. Add the Stripe billing-address check before live.
- UK GDPR applies **in-scope** (UK is a launch market). The published Privacy Policy's claims ("raw data never stored long-term") have never been audited against actual data handling. One session: trace data flow vs policy.

## 6. Process: the risk register is aspirational, and lessons aren't closing the loop

Two systemic findings:

1. **The risk register marks 20/20 risks "✅ Mitigated," but several mitigations are unbuilt or unverified** (CSV upload, Sentry, retry ladder, token-expiry emails, onboarding sequence, feedback loop, export, cost cap). A status column that says "mitigated" when the mitigation is a paragraph of prose is how a postmortem gets written. **New convention: a risk is "Mitigated" only when the mitigation is deployed and verified; otherwise it is "Planned."** Register re-audited below (§8 actions).
2. **All three bugs fixed today were already documented in Learnings_and_Conventions.md as past lessons** — the library described the disease while the code still had it. Lesson: when a pattern is added to the library, **grep the live codebase for it the same day** and fix or ticket. Added to the arch-review continuous-learning loop.

## 7. How Ryan can get more out of Claude

- **Connect the Supabase MCP** (supabase plugin is installed, not authenticated). Today's DB checks went through curl + service-role key; the MCP makes those one-liners and adds migration tooling.
- **Add a Stripe MCP or keep the API pattern from today.** Dashboard work was blocked by browser safety restrictions; the API path proved faster and scriptable. Everything (endpoint creation, event replay) is reproducible via `curl` now documented in the worklog.
- **Scheduled checks:** create a weekly scheduled task ("Welra Monday review": check Sunday cron logs, Stripe MRR, 👎 flags, Sentry) and a one-time reminder for META_ACCESS_TOKEN before 2026-06-25. The scheduled-tasks MCP is already connected.
- **Keep the gates that worked:** `arch-review` after scaffolds, `welra-e2e-audit` workflow before deploys, adversarial agents on strategy decisions (this review's adversarial pass refuted 2 of 8 draft recommendations and found 3 shipped bugs — highest-value 5 minutes of the session).
- **One source of truth per concern:** AutoBiz project = business/legal/tax only; Welra project = product/engineering. Stale CLAUDE.md/Tasks.md cost real time this session (dead URLs, open tasks for done work). Synced today; keep the discipline of updating docs in the same session as the change.
- **CI as a Claude multiplier:** once GitHub Actions is wired, Claude sessions get automatic verification on push instead of manual `tsc` + deploy-and-pray.

## 8. Actions taken this session

- [x] 3 pre-live bugs fixed, typechecked, built, committed (a75c7b3), deployed via `railway up`
- [x] `getPlanFromPriceId` hardened against live-mode env mistakes
- [x] Business plan pricing section corrected to implemented reality (tiers, prices, discounts, Agency deferred)
- [x] AutoBiz State.md pricing + stale Phase 0B tasks synced; growth/multi naming decision closed (resolved: 'growth')
- [x] Welra CLAUDE.md: dead URLs, stale webhook config, stale status fixed
- [x] New tasks added to [[Projects/Welra/Tasks]] (created) with priorities: Etsy/Shopify submissions, CSV upload, CI, Sentry, eval harness, EU billing check, privacy audit, beta recruitment, dead agency code
- [x] New bug patterns + process rules logged to the scaffold-quality library
- [x] This review written; worklog + To_Antigravity updated

## Open decisions for Ryan (none block the critical path)

1. Confirm pricing stays $19/$69/$129 (docs now assume yes; revert is easy pre-launch)
2. Beta recruitment channel: r/woocommerce first (only working integration until Etsy approves) — or wait for CSV upload to widen the pool
3. Whether to trademark WELRA now ($350) or post-revenue (existing open task)

---
*Review conducted with adversarial agent validation, 2026-06-09. See [[Worklogs/Claude_Log]] session 5 entry.*
