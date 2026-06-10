---
title: Welra State
project: Welra
type: state
updated: 2026-06-10 (session 7)
tags: [welra, saas, ecommerce, ai-reports]
---

# Welra — Project State

Welra is a SaaS product delivering weekly AI-written business intelligence reports for multi-channel e-commerce sellers. Built by Ryan Northam (ryan@welra.io).

## Repos & Services

| Service | URL / Location |
|---------|---------------|
| Web (Next.js) | Vercel → welra.io |
| API (Fastify) | Railway → welra-production.up.railway.app |
| GitHub | rcn723/welra (transferred from GR3NB org) |

## Domain Status

- DNS: A record `@` → 216.198.79.1, CNAME `www` → 8c9626efefcfe26d.vercel-dns-017.com (set in Namecheap)
- Vercel showed conflict warning about old A record (162.255.119.212) — deleted; warning is cache lag, will clear on its own

## Pages Status

All six previously-404 pages are live: `/login`, `/signup`, `/contact`, `/privacy`, `/terms`, `/eu-waitlist`. Contact email across all public pages updated to ryan@welra.io (commit ed09c3f on main).

## Stripe Setup — IN PROGRESS

Three products to create in Stripe (live mode):

| Product | Monthly | Annual |
|---------|---------|--------|
| Welra Starter | $19/mo | $190/yr |
| Welra Pro | $69/mo | $690/yr |
| Welra Growth | $129/mo | $1,161/yr |

Webhook: `https://welra-production.up.railway.app/webhooks/stripe`
Events: `checkout.session.completed`, `customer.subscription.updated`, `customer.subscription.deleted`, `invoice.payment_failed`

**9 keys still needed from Ryan:**
- `sk_live_...` — Stripe secret key
- `pk_live_...` — Stripe publishable key
- `whsec_...` — Webhook signing secret
- 6× price IDs (Starter monthly/annual, Pro monthly/annual, Growth monthly/annual)

## Environment Variables — PENDING (waiting on Stripe keys)

### Railway (via CLI — `railway variables set KEY=VALUE`)
```
STRIPE_SECRET_KEY=sk_live_...
STRIPE_WEBHOOK_SECRET=whsec_...
STRIPE_PRICE_STARTER_MONTHLY=price_...
STRIPE_PRICE_STARTER_ANNUAL=price_...
STRIPE_PRICE_PRO_MONTHLY=price_...
STRIPE_PRICE_PRO_ANNUAL=price_...
STRIPE_PRICE_GROWTH_MONTHLY=price_...
STRIPE_PRICE_GROWTH_ANNUAL=price_...
```

### Vercel (dashboard or CLI)
```
NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY=pk_live_...
NEXT_PUBLIC_API_URL=https://welra-api-production.up.railway.app
```

## Current Status — Test Mode, Pre-Launch

All infrastructure is live. 13 bugs found and fixed by 44-agent e2e audit (2026-06-08). Currently in **Stripe test mode** — validating end-to-end flow before switching to live keys.

### Stripe (test mode)
- Products: Starter ($19/$190), Pro ($69/$690), Growth ($129/$1,161) ✅
- Webhook: configured for 4 events ✅
- Keys: set in Railway and Vercel ✅
- Mode: test — switch to live after e2e validation passes

### Completed This Session (session 2)
- [x] Stripe products + prices created [owner:: ryan]
- [x] Railway env vars set (8 Stripe vars + WEB_URL) [owner:: claude]
- [x] Vercel env vars set (pk + API URL) [owner:: claude]
- [x] Auth callback route built (/auth/callback) [owner:: claude]
- [x] Subscribe button + checkout API route built [owner:: claude]
- [x] 44-agent e2e audit run — 13 bugs found and fixed [owner:: claude]
- [x] Checkout endpoint secured with JWT auth [owner:: claude]
- [x] Webhook upsert fixes silent null customer bug [owner:: claude]
- [x] DB trigger updated to save plan field [owner:: ryan] (run SQL in Supabase)
- [x] CHECK constraint fixed: 'multi' → 'growth' [owner:: ryan] (run SQL in Supabase)

### Completed This Session (session 3 — 2026-06-09)
- [x] RLS enabled on 4 missing tables (report_jobs, token_health_alerts, stripe_events, onboarding_emails) [owner:: ryan]
- [x] Login hang fixed — hard redirect + missing cookies.get() in all createServerClient calls [owner:: claude]
- [x] Railway domain generated — welra-production.up.railway.app [owner:: claude]
- [x] NEXT_PUBLIC_API_URL updated in Vercel → https://welra-production.up.railway.app [owner:: claude]
- [x] Stripe webhook updated to new Railway URL + new whsec set in Railway [owner:: claude]
- [x] checkout route fixed — Railway was serving stale image; railway up forced fresh build [owner:: claude]
- [x] WEB_URL updated in Railway → https://www.welra.io (fixes SSL cert mismatch on redirect) [owner:: claude]
- [x] Stripe checkout tested end-to-end with test card 4242 — Stripe page loaded and processed ✅

### Completed This Session (session 4 — 2026-06-09 evening)
- [x] Discovered the "new" Stripe webhook endpoint was never actually created — only the old endpoint (dead URL `welra-api-production.up.railway.app`) existed; the whsec in Railway matched no endpoint [owner:: claude]
- [x] Created webhook endpoint `we_1TgdoUHQhXwdEcI9y0HXZsGM` via Stripe API → `https://welra-production.up.railway.app/webhooks/stripe` (5 events: checkout.session.completed, customer.subscription.updated/deleted, invoice.payment_succeeded/failed) [owner:: claude]
- [x] New signing secret set in Railway `STRIPE_WEBHOOK_SECRET` + service redeployed green [owner:: claude]
- [x] Replayed missed event `evt_1TgbWhHQhXwdEcI9271nxISa` via `POST /v1/events/{id}/retry` API [owner:: claude]
- [x] Railway logs confirmed: `Processing Stripe event: checkout.session.completed` → `[webhook] Activated customer 0f0da7d7 on starter (monthly)` [owner:: claude]
- [x] Supabase customers row confirmed: stripe_customer_id `cus_UfxRzoNLN4WfoF`, stripe_subscription_id `sub_1TgbWdHQhXwdEcI9sssKQUkp`, status trialing, trial ends 2026-06-24 [owner:: claude]
- [x] stripe_events idempotency row confirmed (processed_at 2026-06-10T04:34Z) [owner:: claude]
- [x] Old dead-URL webhook endpoint `we_1TgD1gHQhXwdEcI9JWDV1ptj` disabled (not deleted — keeps event history; re-enable via API if ever needed) [owner:: claude]

**✅ E2E TEST-MODE VALIDATION COMPLETE — Stripe live-mode switch is unblocked.**

### Completed This Session (session 5 — 2026-06-09, strategy review)
- [x] Full strategy review with adversarial agent validation → [[Projects/Welra/Strategy_Review_2026-06-09]] [owner:: claude]
- [x] 3 pre-live bugs found & fixed & deployed (commit a75c7b3, deploy green): REPORT_DRY_RUN zod coercion ('false'→true), incomplete→trialing granting access, getPublicUrl on private bucket → 12-mo signed URL [owner:: claude]
- [x] getPlanFromPriceId hardened (loud error on unknown price ID — guards live-mode rotation) [owner:: claude]
- [x] Pricing reconciled: implementation ($19/$69/$129, Growth annual 25% deliberate) is source of truth; Business_Plan.md + AutoBiz State.md updated [owner:: claude]
- [x] Doc drift fixed: Welra CLAUDE.md URLs/webhook/status, AutoBiz Tasks Phase 0B closed, naming decision closed ('growth') [owner:: claude]
- [x] [[Projects/Welra/Tasks]] created — product/eng source of truth (AutoBiz = business/legal only) [owner:: claude]

**⚠️ Revised critical path (strategy review):** Etsy + Shopify dev apps (submit NOW, 4–8 wk lead) → CSV upload → 3–5 beta users on free accounts → THEN Stripe live mode. Live mode is not the gating item for learning; report quality on real data is.

**⏰ Sunday 2026-06-14:** first-ever scheduler cron run fires for the test customer (no integrations; dry-run confirmed ON). Check Railway logs Monday — free integration test. NOTE: report generation will fail regardless until API credits are added (see session 6).

### Completed This Session (session 6 — 2026-06-10 overnight, autonomous)
- [x] **CSV upload ingestion path built + deployed** — POST /uploads/csv, format auto-detect (Etsy/Shopify/Woo/generic), normalized orders → private storage → report pipeline. Parser verified on all 3 formats. The FIRST working commerce ingestion path. [owner:: claude]
- [x] **Discovered: etsy/shopify/woocommerce/stripe integration modules are 5-line stubs returning null** — only printify + instagram are real (and those two aren't in the DB platform CHECK). State.md's "built" claims referred to file existence, not function. [owner:: claude]
- [x] **Discovered + fixed: /integrations routes 401'd unconditionally** — request.customerId was never set anywhere; new lib/auth.ts JWT helper now used by all 3 routes + uploads. [owner:: claude]
- [x] **🔴 Discovered: Anthropic API account has ZERO credits (local + Railway keys, verified by live call)** — all report generation fails until Ryan adds credits. [owner:: claude]
- [x] EU billing-address enforcement (layer 3) in checkout + webhook (EU27 → cancel before activation) [owner:: claude]
- [x] Report-quality eval harness (`npm run eval`): 3 golden datasets, production prompts, hallucination judge — first full run blocked on credits [owner:: claude]
- [x] Sentry wired (lazy, on SENTRY_DSN), REPORT_SYNTHESIS_MODEL A/B toggle, lazy Anthropic init, agency tier removed [owner:: claude]
- [x] arch-review run: 2 new-code blockers fixed pre-deploy (Fastify 1MiB bodyLimit trap, UTC date-bucket shift); risk register re-audited in Business_Plan.md; privacy audit → [[Projects/Welra/Privacy_Audit_2026-06-10]] (3 unimplemented policy promises) [owner:: claude]
- [x] META_ACCESS_TOKEN mystery resolved — belongs to Rust & Rainbow NAS agent, already tracked there with due date [owner:: claude]
- [x] Deployed green (commits a75c7b3, f1d99d3), health 200, new routes smoke-tested. CI workflow written but push blocked: GitHub PAT lacks `workflow` scope (Ryan fix). [owner:: claude]

### Completed This Session (session 7 — 2026-06-10 day)
- [x] **Real WooCommerce integration shipped** — REST v3, week + prev-week aggregation (completed/processing orders), top products, unique customers, AOV. Connect via POST /integrations/woocommerce/token with `access_token="ck_…:cs_…"`, `shop_id=store URL`. Second working ingestion path after CSV. Verify the `status[]` array param against the first real beta store. [owner:: claude]
- [x] **Fixed latent cross-service bug: worker passed raw snake_case DB rows cast as the camelCase Integration type, and tokens were never decrypted** — every token-based fetcher read undefined (CSV unaffected — reads only `metadata`). New lib/integrationRow.ts mapper (snake→camel + AES decrypt, per-field failure isolation) now used in worker.ts. [owner:: claude]
- [x] **Retention/deletion job shipped** (privacy-audit promise #2) — jobs/retentionCron.ts, daily 3am UTC: on cancellation scrubs platform tokens + deletes CSV order data from storage; 12mo post-cancellation deletes reports + PDFs. Idempotent sweep, per-customer failure isolation. [owner:: claude]
- [x] **arch-review blocker found + fixed pre-deploy: `canceled_at` lifecycle** — no activation path cleared it and subscription.updated could set status canceled without stamping it → cancel/re-subscribe/cancel could trigger premature irreversible report deletion (or retain-forever on the null side). Webhooks now clear canceled_at on activation and stamp it (only-if-null) on canceled-via-updated. [owner:: claude]
- [x] Platform allowlist guard on POST /integrations/:platform/token (400 instead of CHECK-constraint 500) [owner:: claude]
- [x] Deployed green (commit c67d799, `railway up`): boot logs show all 4 workers incl. `[retention] cron registered 03:00 UTC`, health 200 on new container [owner:: claude]
- [x] Re-verified 🔴 Anthropic credits still ZERO (live API call, morning of 2026-06-10) — eval run remains blocked on Ryan [owner:: claude]
- [x] Bug pattern library +2 (DB-row-cast-to-domain-type; deletion-job-on-unmaintained-timestamp), arch-review skill updated with both examples [owner:: claude]
- [x] **/auth/me + /reports routes + ZIP export shipped** (commit f72b002, deployed green, smoke-tested 401s) — profile endpoint, report list/detail with fresh signed PDF URLs, GET /reports/export ZIP (privacy promise #3 now true) [owner:: claude]
- [x] **Brand identity created** → [[Projects/Welra/Brand_Identity]] — radar-sweep icon, ink-navy/radar-teal/signal-amber palette; favicon + logo SVGs + Tailwind tokens committed (3516185). ⚠️ Goes live on welra.io only after Ryan fixes the PAT and pushes (Vercel deploys from GitHub). [owner:: claude]
- [x] **Marketing campaign plan** → [[Projects/Welra/Marketing_Campaign_2026-06]] ($0 beta recruitment playbook; ≤$150/mo launch runway) [owner:: claude]
- [x] **Etsy + Shopify application guide** → [[Projects/Welra/Etsy_Shopify_Developer_Applications]] — verified against current docs; Etsy personal access covers 5 shops immediately, so beta is NOT gated on the 4–8-wk commercial review [owner:: claude]

## Remaining Steps (in order)
- [ ] Run `railway up --service welra` after any future code changes (GitHub auto-deploy not wired up) [owner:: claude] [priority:: high] [status:: open]
- [ ] Wire up Railway GitHub auto-deploy so git push triggers rebuild (currently requires `railway up`) [owner:: claude] [priority:: medium] [status:: open]
- [ ] Fix apex domain SSL cert — welra.io needs cert provisioned in Vercel Domains settings [owner:: claude] [priority:: medium] [status:: open]
- [ ] Switch to Stripe live mode (recreate prices, swap keys in Railway + Vercel; create live webhook endpoint via API to capture whsec — see session 4 learnings) [owner:: ryan] [priority:: high] [status:: open]
- [ ] Flip `REPORT_DRY_RUN=false` in Railway after live mode verified [owner:: claude] [priority:: high] [status:: blocked]
- [ ] Refresh META_ACCESS_TOKEN before 2026-06-25 (expires 2026-07-01) [owner:: ryan] [priority:: high] [status:: open]

## E2E Test Script

Reusable 44-agent audit script saved at `~/.claude/workflows/welra-e2e-audit.js`
Run any time before a deploy or after major changes:
```
Workflow({ name: 'welra-e2e-audit' })
```
Tests: auth flow, checkout (happy + negative), webhook signatures, dashboard states, all public pages, adversarial verification of every HIGH/BLOCKER finding.
