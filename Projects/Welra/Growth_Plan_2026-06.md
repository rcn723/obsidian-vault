---
title: Welra Growth Plan — beyond weekly reports
project: Welra
type: strategy
updated: 2026-06-11
tags: [welra, growth, roadmap, architecture, on-demand]
---

# Welra Growth Plan

Where Welra goes after the beta validates report quality. Five phases, each with an entry gate (don't start it earlier), milestones, and the architecture delta it requires. Companion docs: [[Projects/Welra/Marketing_Campaign_2026-06]] (awareness plays), [[Projects/Welra/State]], AutoBiz Business_Plan (iOS = Phase 7 there; folded in here as G4).

## The through-line

Welra's brand is a radar. The product ladder follows the metaphor:
1. **Weekly sweep** (today) — scheduled batch report.
2. **Ping on demand** (G3) — ask the radar anytime.
3. **Always-on radar** (G5) — it tells YOU when a blip appears.

Each rung justifies a higher tier and deepens the moat (history + context no competitor has on day one).

---

## G1 — Launch foundation (gate: beta NPS ≥ promising + eval pass rate ≥ 90%)

**Goal:** convert beta into paying customers. Mostly already built.

Milestones: Stripe live mode · REPORT_DRY_RUN=false · 3 solid ingestion paths (CSV, Woo, Shopify) · referral program ("give a month, get a month") · first 10 paying customers.

Architecture delta: minimal — referral codes table + Stripe coupon wiring; usage metering columns (tokens/cost per report already logged on reports table).

## G2 — Data depth (gate: 10+ paying; Month 1–3)

**Goal:** make week 8 dramatically more valuable than week 1. Retention is the business.

- **Trend memory:** store each shop's weekly aggregates permanently → 12-week trend lines, seasonal callouts ("3rd year-low Tuesday in a row"), month-over-month narrative.
- **Etsy live** (pending API approval, resubmit Jun 25) · **Google Sheets bridge** (GA4 traffic) · **Make webhook receiver** (everything else).
- **Radar Score:** one 0–100 composite weekly health score (revenue trend, order momentum, AOV, source mix). Shareable card in brand colors — every share is an ad. Streaks gamify retention.
- **Benchmarks (careful):** "shops like yours grew 4% this week." ⚠️ MUST exclude Etsy-sourced data — our Etsy application promises data is "never combined across shops," and Etsy's ToU prohibits cross-shop analytics. Benchmarks compute ONLY from Shopify/Woo/CSV-sourced metrics, opt-in, k-anonymized (no cohort smaller than 20 shops). Legal review of privacy policy wording before shipping.

Architecture delta: `weekly_metrics` table (shop × week × metric, written by the report pipeline); benchmark aggregation job (nightly, k-anonymity enforced in SQL); score calculator in the report generator.

## G3 — Radar On-Demand: the Growth-tier flagship (gate: 20+ paying or $2k MRR; Month 2–4)

**Goal:** the $129 tier's killer feature — don't wait for Monday. Two faces:

1. **Ping** — one button: pull fresh data now, 60-second mini-report ("since Monday: 14 orders, $612, Mug #3 is moving — restock risk by Friday").
2. **Ask your shop** — natural-language Q&A grounded in the shop's own stored data, every number cited: "How did my sale weekend actually do vs the weekend before?" · "What should I restock for fall?" · "Which listing is quietly dying?" Scenario questions allowed but clearly labeled as estimates.

Tier gating: Growth = unlimited fair-use (soft cap ~100 pings/mo, then throttle); Pro = 3/month as a taste (upgrade hook); Starter = none.

**Architecture delta (the real work):**
- **Persistent normalized order store.** Today API integrations pull-and-discard each run; CSV already stores normalized orders. Extend that model to ALL sources: `orders_normalized` (customer-scoped, date, order id, total, line items) refreshed on each pull. This is the substrate for Q&A, trends, and benchmarks alike. ⚠️ Requires privacy-policy wording update (the CSV retention amendment already planned covers the pattern — broaden it) and inclusion in the retention/deletion job (extend the cron that already scrubs CSV data on cancellation).
- **Query agent service:** Claude with tool use — tools are (a) `query_metrics` (parameterized SQL over the customer's OWN rows via scoped Supabase RPCs — never raw SQL from the model), (b) `fresh_pull` (invoke the existing integration fetchers), (c) `get_trends` (weekly_metrics). Haiku parses/routes, Sonnet synthesizes; prompt caching on the system prompt; answers stream via SSE on Fastify.
- **Cost guardrails:** per-customer monthly token budget table with hard stop + "you've used 80%" email; ~$0.02–0.06/ping at current pricing → even heavy Growth users stay >90% margin.
- **Eval extension:** the existing eval harness gains a Q&A golden set (questions + expected grounded numbers) — same hallucination-judge pattern.

## G4 — Mobile app (gate: 10+ paying with proven retention; Month 4–6)

Per the business plan's Phase 7, now with a sharper reason to exist: **Radar On-Demand IS the mobile app.** Weekly emails don't need an app; "ping my shop from my phone at the craft fair" does.

- React Native + Expo, same TS monorepo (`apps/mobile`), same API.
- Push notifications: report ready · anomaly blip · on-demand answers.
- Pricing: web subscribers log in free; new mobile signups via Apple IAP at mobile-adjusted prices ($24.99/$79.99/$149.99) with RevenueCat (free under $2.5k MRR).
- Architecture delta: token auth already works (Supabase JWT); add push token registry + notification service; SSE→ WebSocket or polling fallback for chat on mobile.

## G5 — Always-on radar (gate: 50+ paying or $5k MRR; Month 6+)

- **Daily micro-sweeps:** light cheap pull per shop per day (counts only, no synthesis) → blip detection: sudden spike/drop, listing going viral, stockout risk, review bombs.
- **Blip alerts** push/email with one-tap "explain this" (runs an on-demand ping).
- **Shopify order webhooks** replace polling where available (real-time, cheaper).
- **Forecasting:** simple seasonal baselines first (no ML training on platform data — house models on the customer's own aggregates only, consistent with platform ToU).
- Stretch: resurrect the Agency tier (multi-shop accounts, white-label PDF) when 3+ agencies ask.

Architecture delta: `daily_metrics` + threshold engine (plain SQL, no ML needed); webhook ingestion endpoint per platform; alert dedupe/cooldown table (reuse token_health_alerts pattern).

---

## Milestone gates summary

| Gate | Unlocks |
|---|---|
| Eval ≥90% + beta NPS positive | G1 launch, Stripe live |
| 10 paying | G2 data depth; G4 planning |
| 20 paying / $2k MRR | G3 Radar On-Demand build |
| Proven 3-mo retention | G4 mobile app |
| 50 paying / $5k MRR | G5 always-on |

## Compliance guardrails baked in (non-negotiable)

1. Etsy-sourced data: never cross-shop, never benchmarks, never model training — per our application promises and Etsy ToU.
2. Every new stored dataset (orders_normalized, weekly_metrics, daily_metrics) enters the retention/deletion cron the same day it ships.
3. Privacy policy updated BEFORE each phase ships, not after (the audit habit).
4. Scenario/forecast outputs always labeled as estimates — reports are "informational only" per ToS.

## Status

- [ ] Review growth plan with Ryan; pick G2/G3 sequencing once beta data exists [owner:: ryan] [priority:: medium] [status:: open]
- [ ] G3 design spike: orders_normalized schema + scoped-RPC query tools (1 session, no deploy) [owner:: claude] [priority:: low] [status:: open]
