---
title: Welra Architecture Roadmap — infrastructure, toolsets, and anti-rework invariants
project: Welra
type: architecture
updated: 2026-06-11
tags: [welra, architecture, infrastructure, roadmap, living-doc]
---

# Welra Architecture Roadmap

**Living document.** Re-reviewed at every growth gate (see Check-in protocol at the bottom). Companion to [[Projects/Welra/Growth_Plan_2026-06]]. Purpose: know what infrastructure each phase needs BEFORE we need it, and lock the design rules that keep today's choices from cornering tomorrow's features.

## 1. Current baseline (G0/G1 — verified live 2026-06-11)

| Layer | Tool | Notes / limits that matter |
|---|---|---|
| Web | Next.js 14 on Vercel (`welra-web`) | Deploys on git push (PAT-blocked) or `npx vercel deploy --prod` |
| API | Fastify on Railway, Docker `node:22-slim` | Single service, single region; deploy ONLY via `railway up --service welra` |
| DB / Auth / Storage | Supabase (Postgres + RLS, JWT auth, private `reports` bucket) | Service role in API; RLS guards client access; signed URLs only |
| Queue / cron | BullMQ on Railway Redis plugin | 4 workers: reports (conc. 10), scheduler (Sun 23:00 UTC), token health (daily 02:00), retention (daily 03:00) |
| LLM | Claude API (per-source analysis + synthesis), prompt caching on system prompts, `REPORT_SYNTHESIS_MODEL` A/B env toggle | 🔴 account needs credits; cost logged per report (tokens on reports table) |
| Email | Resend (welra.io domain, DKIM/SPF) | Free tier = 3k emails/mo |
| PDF | Puppeteer in the API container | Heaviest dependency — see cliff #1 |
| Payments | Stripe (test mode) | Webhook w/ signature verify + idempotency table |
| Ingestion | CSV upload (live) · WooCommerce REST (live) · Etsy/Shopify OAuth flows (live, fetchers pending) | All normalize toward one canonical order shape |
| Observability | Sentry (wired, needs DSN) · pino logs · Railway Logs tab | Uptime Robot pending |
| CI | GitHub Actions written, push blocked on PAT scope | Eval harness (`npm run eval`) exists; not yet a CI gate |

## 2. Phase deltas — what each gate adds (and what it must NOT add)

### G1 · Launch (no new infrastructure)
Referral codes table + Stripe coupons. **Resist:** any new service. Everything fits the current box.

### G2 · Data depth
- `weekly_metrics` table (customer_id, source, week_start, metric, value) — written by the report pipeline as a side effect, never recomputed from platform APIs.
- Nightly benchmark aggregation job = one more BullMQ repeatable (pattern exists ×4).
- **New tool: none.** This phase is pure schema + crons.
- ⚠️ Source-tag every row (`source` column) from day one — the Etsy-exclusion compliance rule (`WHERE source != 'etsy'` in all cross-shop SQL) must be mechanical, not remembered.

### G3 · Radar On-Demand (the one phase with real new architecture)
- `orders_normalized` table — the canonical store ALL sources write to (CSV already does this in storage; move/extend to Postgres rows: customer_id, source, order_date, order_id, total, line_items jsonb). Trends, Q&A, benchmarks, and future features all read THIS, never platform APIs directly.
- Query agent: Claude tool-use where every tool is a **scoped Supabase RPC** (`p_customer_id` enforced server-side; the model never writes SQL). Haiku routes, Sonnet synthesizes.
- **New tools:** SSE streaming on Fastify (no lib needed, raw `reply.raw`); per-customer token-budget table + hard stop; Q&A golden set added to the eval harness.
- **Consider:** Anthropic **Batch API for the Sunday weekly run** (50% cost, async fits perfectly) — keep realtime for pings. Decision at G3 start.
- **Resist:** vector DB / pgvector (no semantic search need yet), GraphQL, a separate "AI service".

### G4 · Mobile
- `apps/mobile` in the same monorepo: Expo + EAS Build, RevenueCat (free <$2.5k MRR), Expo Push.
- API additions: push-token registry table + notification dispatch (reuse alert/cooldown pattern from token_health_alerts).
- **No backend rework if invariant #5 held** (API-first, JWT auth, no web-session coupling).

### G5 · Always-on
- `daily_metrics` + plain-SQL threshold engine (no ML), alert dedupe/cooldown table.
- Public webhook ingestion endpoints (Shopify order webhooks first) with per-platform HMAC verify — pattern already proven in the Stripe webhook.
- **Likely first real scale spend:** split the PDF/render worker into its own Railway service (see cliff #1) and upgrade Supabase/Resend tiers.
- **Resist:** Kafka/event bus, microservices, multi-region — see §5.

## 3. Anti-rework invariants (the rules that keep us out of corners)

Violating one of these is how a weekend feature becomes a quarter of rework. Check them at every gate and in every arch-review.

1. **One canonical order shape.** Every ingestion path (CSV, Woo, Shopify, Etsy, webhooks, Sheets) normalizes into the same `NormalizedOrder` → `orders_normalized`. New features read the canonical store, never a platform API directly. Platform quirks live in `metadata` jsonb, never as core columns.
2. **Source-tagged everything.** Every stored metric/order row carries its `source` platform — compliance exclusions (Etsy), per-platform debugging, and future per-source pricing all depend on it.
3. **LLM never touches raw SQL or another customer's rows.** All model-facing data access via scoped RPCs with customer_id bound server-side. This is both the security and the compliance story.
4. **New workload = new BullMQ queue, not new service.** Split a service only when a measured resource conflict exists (see cliff #1 for the one we expect).
5. **API-first, one auth.** Everything a client needs is a JWT-authed REST/SSE endpoint. The mobile app must require zero backend rework. No Next.js-server-only data paths for product features.
6. **Every new dataset enters retentionCron in the same PR** that creates it, and the privacy policy updates BEFORE the feature ships.
7. **Metered from day one.** Any feature that calls Claude writes tokens/cost per customer per call. Budgets are enforceable only if usage is recorded.
8. **Renderers stay pure.** Report HTML/PDF/email builders are pure functions of data — portable to a worker split or a different host without change.
9. **Secrets:** AES-256-GCM at rest, lazy-init SDKs, zod-optional env (boot never crashes on a missing optional key).
10. **Boring beats clever** until a gate says otherwise: Postgres for everything (queues excepted), plain SQL over warehouses, cron over streams.

## 4. Known scaling cliffs (what breaks first, and the trigger to act)

| # | Cliff | Breaks at (est.) | Early signal | Pre-planned fix |
|---|---|---|---|---|
| 1 | Puppeteer PDF rendering in the API container (RAM burst ~300MB/render) | ~50+ reports in one Sunday timezone cohort | Railway memory graph spikes Sunday night; render failures in logs | Split `render-worker` Railway service consuming a `pdf` queue (invariant #8 makes this a move, not a rewrite) |
| 2 | Sunday thundering herd (all reports at once) | ~200 customers | Queue depth > 1hr drain | Already timezone-staggered; next lever = Anthropic Batch API for the weekly run (also −50% cost) |
| 3 | Claude rate limits / cost | Depends on tier | 429s in worker logs; cost/customer trend in metering | Request tier raise; Batch API; cache more aggressively; Haiku for per-source passes |
| 4 | Resend free tier (3k emails/mo) | ~300 customers × (report + onboarding) | Resend dashboard | $20/mo tier — budget non-event |
| 5 | Supabase storage (PDFs ≈ 200KB × customers × 52/yr) | ~500 customers ≈ 5GB/yr | Storage dashboard | Tier upgrade; retention job already prunes post-cancellation |
| 6 | Single Railway region (us-west) | Only if EU launch happens | n/a (EU geo-blocked by policy) | Revisit only with EU decision |
| 7 | Single Redis instance | ~10k jobs/day | BullMQ latency | Railway Redis upgrade; still no reason for a second broker |

**Cost model sanity row** (recheck actuals at each gate): at 50 customers ≈ $5–15/mo Claude (batched) + $20 Railway + $25 Supabase + $0 Resend → infra <$75/mo against ~$2.5k+ MRR. The margin story survives every phase if metering (invariant #7) stays honest.

## 5. Deliberately NOT adopting (and what would change the answer)

| Tool | Status | Adopt only when |
|---|---|---|
| Microservices / k8s | ❌ | Never at this scale; revisit >$50k MRR with a team |
| Kafka / event bus | ❌ | A second consumer needs the same event stream (BullMQ + Postgres cover G5 webhooks) |
| Data warehouse (BigQuery/DuckDB) | ❌ | Cross-customer analytics exceed what nightly SQL aggregates handle (>5k shops) |
| Vector DB / pgvector | ❌ | A real "search my past reports semantically" demand appears |
| GraphQL | ❌ | Never likely; REST+SSE serves web and mobile |
| Terraform/IaC | ❌ | Second environment or second engineer |
| Datadog etc. | ❌ | Sentry + Railway metrics insufficient at >1k customers |
| PostHog/Amplitude | 🔶 deferred | At G2, when funnel questions become real — start with the free tier |

## 6. Check-in protocol (how this doc stays honest)

**When:** at every growth gate (G1–G5), and additionally at 25 / 100 / 500 customers — whichever comes first. Calendar trigger: piggyback the existing weekly "Welra Monday review" task once it exists.

**The check-in (15 min, run with Claude):**
1. Re-read §3 invariants → grep the codebase for violations (e.g., any fetcher consumed outside the canonical store, any unmetered Claude call, any dataset missing from retentionCron).
2. §4 cliff table → fill in ACTUAL numbers (customers, Sunday queue drain time, Railway RAM peak, Claude cost/customer, storage GB) next to the estimates. Update estimates that were wrong.
3. §2 next-phase delta → still right? Adjust before building.
4. §5 — is anyone tempted to adopt a ❌ tool? Write down the trigger that justifies it or don't.
5. Run the `arch-review` skill on anything built since the last check-in.
6. Append a dated entry to the Decision log below.

## Decision log (append-only)

- **2026-06-11** — Doc created. Locked invariants 1–10. Chose: canonical order store in Postgres (not storage JSON) for G3; scoped-RPC pattern for the query agent; Batch API decision deferred to G3 start; PDF worker split pre-planned as cliff #1's fix. Rejected (for now): vector DB, event bus, warehouse, GraphQL.

Related: [[Projects/Welra/Growth_Plan_2026-06]] · [[Projects/Welra/State]] · [[Knowledge_Base/Learnings_and_Conventions]]
