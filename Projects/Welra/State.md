---
title: Welra State
project: Welra
type: state
updated: 2026-06-12 (session 10)
tags: [welra, saas, ecommerce, ai-reports]
---

# Welra — Project State

> **New session? Read [[Projects/Welra/Continuation_Playbook]] FIRST** — it's the model-agnostic entry point: current blockers, the ordered path, operating rules, and the doc map.

Welra is a SaaS product delivering plain-English weekly business reports for multi-channel e-commerce sellers. Built by Ryan Northam (ryan@welra.io). (Brand language rule: never lead with "AI" — see playbook §1.)

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
- [x] **Repo README.md written** (commit 0f63249 — architecture, ingestion status, routes, deploy rules, hard conventions) + [[Projects/Welra/Brand_Identity]] expanded into full style guide (typography, logo usage, component rules, voice) [owner:: claude]
- [x] **Vercel CLI verified authenticated as rcn723** — `npx vercel deploy --prod` from repo root is a valid web-deploy path that bypasses the blocked git push (deploy itself awaiting Ryan's go-ahead) [owner:: claude]

### Completed This Session (session 8 — 2026-06-10 afternoon)
- [x] **Brand palette applied to landing page + report email** (commit 595c01c) — ink/radar/signal across nav (logo SVG), hero, pricing cards (highlight card now ink with teal CTA), footer (dark ink), report email (teal revenue card, teal/red deltas, signal highlights). Email footer contact fixed ryan@gr3nb.com → ryan@welra.io. [owner:: claude]
- [x] **Founding Seller beta banner + waitlist capture shipped** — banner at top of landing page (offer per campaign plan: free Pro during beta → 50% off 6 mo) posting to new public POST /waitlist (zod email validation, 5/min/IP rate limit, sources founding-seller/eu). EU waitlist page converted from mailto hack to the same endpoint. [owner:: claude]
- [x] ⚠️ **`waitlist` table migration NOT yet applied** — Claude's Supabase apply_migration was permission-denied (production DB change needs Ryan's explicit OK). DDL is in schema.sql; the route degrades gracefully (falls back to emailing the signup to RESEND_REPLY_TO so nothing is lost). Ryan: say "apply the waitlist migration". [owner:: ryan]
- [x] **arch-review run on the change set** — 1 blocker caught + fixed pre-commit: next/image 400s on SVG sources at runtime (builds clean) → plain `<img>` for the nav logo. Bug pattern library +1 (28 patterns), skill updated. Risk noted: Tailwind `slate` brand token shadows the built-in slate scale (low; tracked in Tasks). [owner:: claude]
- [x] Deployed API green via `railway up --service welra` (report email rebrand + /waitlist live); web changes committed but go live only with the next web deploy (PAT push or `npx vercel deploy --prod` on Ryan's OK — now **5 commits** waiting: c67d799, f72b002, 3516185, 0f63249, 595c01c). [owner:: claude]
- [x] Re-verified 🔴 Anthropic credits still ZERO (live API call) — eval run still blocked on Ryan. [owner:: claude]

### Completed This Session (session 8 continued — 2026-06-10 evening, keys arrived)
- [x] **Etsy + Shopify credentials received from Ryan and stored in Railway** — ETSY_CLIENT_ID/SECRET, SHOPIFY_CLIENT_ID/SECRET, SHOPIFY_CLI_PARTNERS_TOKEN (expires 2026-12-10), plus redirect URI env vars [owner:: claude]
- [x] **OAuth flows built + deployed** (routes/oauth.ts): GET /integrations/{etsy,shopify}/connect (JWT) → authorize URL; callbacks exchange tokens, fetch shop name, upsert encrypted into integrations. Etsy = OAuth2+PKCE w/ Redis state; Shopify = HMAC-verified. Etsy token_expires_at set to the 90-day refresh horizon (NOT the 1-hr access token) so tokenHealthCron doesn't false-expire it — caught in self-review. [owner:: claude]
- [x] ⚠️ **Etsy keystring fails openapi-ping (403 "not found or not active")** — verified against live API; control test with the banned R&R key returns the identical error. App likely still pending activation on Etsy's side, or keystring mistyped. Re-test before building the Etsy fetcher. [owner:: claude]
- [x] 🔴 **Discovered (Chrome check): Etsy app "rust-and-rainbow" is BANNED** on the Chrome-logged-in Etsy account — the Welra app lives on a different account (couldn't inspect its settings). Flagged in [[Projects/Rust_and_Rainbow/Tasks]]. [owner:: claude]

### Completed This Session (session 8 continued — Etsy denial response)
- [x] **Etsy API application DENIED** (Etsy email 2026-06-10: unclear use case / appears third-party). Full root-cause + reapplication playbook → [[Projects/Welra/Etsy_API_Approval_Strategy]] (read full current API ToU + community/staff guidance; Ryan confirms his description did not mention AI — operative causes: site's AI copy, framing, account signals). [owner:: claude]
- [x] **All web + marketing materials de-AI'd** ("AI-written" → "plain-English"; hero, pricing, sample, OG/meta, privacy intro, terms; AI processor disclosure retained in privacy policy). Etsy trademark disclaimer added to footer. Commit de527a5. [owner:: claude]
- [x] **welra.io DEPLOYED LIVE via `npx vercel deploy --prod`** — verified: plain-English copy + Etsy disclaimer live, zero "AI-written", radar favicon live. This also shipped the entire queued web backlog (brand palette, Founding Seller banner) that git-push blocking had held. CI push still needs the PAT fix. [owner:: claude]
- [x] Reapplication form answers prepared (strategy doc, "Exact application copy"); ⏸️ BLOCKED on Ryan switching Chrome's Etsy session to the Welra-app account — current session is the banned-R&R account, must not submit from there. [owner:: ryan]
- [x] **2026-06-11: cool-off agreed → resubmit on/after Jun 25.** One-time reminder scheduled (`etsy-api-resubmit-reminder`, 9am Jun 25, desktop scheduled task). New facts: R&R was banned over AI-generated content; its API appeal is FINAL; both Etsy identities share a network (assume linked — no evasion, clean reapplication on merits). R&R Etsy API path closed permanently → R&R Tasks updated + shop-standing check added there. [owner:: claude]

### Completed This Session (session 9 — 2026-06-11, autonomous build)
- [x] **Shopify fetcher built + deployed** (apps/api/src/integrations/shopify.ts) — Admin REST 2025-01: week + prev-week paid-order aggregation (excludes cancelled/test/unpaid), top products, cart abandonment from abandoned-checkout counts, Link-header pagination, store-local day bucketing via shop.json iana_timezone. Sessions deliberately absent (need restricted analytics scope) — ShopifyWeekData fields made optional, JSON.stringify prompt path omits them cleanly. ⚠️ Untested against a live store until a dev store installs. [owner:: claude]
- [x] **/dashboard/integrations page built + deployed** — Etsy OAuth button, Shopify shop-domain form, WooCommerce ck/cs form (working beta path!), CSV card, disconnect, OAuth result banners. Guards: no-customer-row users → activation screen (FK seam), Etsy card carries "finishing review" caption until keystring activates. [owner:: claude]
- [x] **Fixed live snake_case-cast bug in web dashboard** — `as Report[]`/`as Integration[]` casts would have crashed /dashboard on the first real report (sourcesIncluded undefined) and showed the subscribe banner to active subscribers (stripeSubscriptionId vs stripe_subscription_id). New web-side mapper apps/web/src/lib/rows.ts; token columns no longer selected by the web app at all. Pattern recurrence logged to memory. [owner:: claude]
- [x] arch-review run: 0 blockers, 6 risks (2 mitigated in-session), 2 deferred → tasks. Key find: **Shopify "Protected customer data" gate** — orders.json 403s on real stores until enabled in Partner Dashboard (Ryan task). [owner:: claude]
- [x] Deploys verified green: `railway up` (health 200, all 4 workers registered) + `npx vercel deploy --prod` (welra.io aliased, /dashboard/integrations 307→login as expected). [owner:: claude]
- [x] Etsy keystring re-pinged: still 403 — consistent with the denial; won't activate before the 6/25 reapproval. Task re-marked blocked (no point re-copying the key). [owner:: claude]

### Completed This Session (session 9 continued — credits arrived, EVAL PASSING)
- [x] **🎉 #1 BLOCKER CLEARED: Ryan purchased Anthropic credits → eval iterated to 3/3 PASSING, stable across 3 consecutive runs.** Report generation fully unblocked. [owner:: ryan+claude]
- [x] **Prompts honesty-hardened** (8 iterations against the hallucination judge): causes may only appear as checks to run ("worth checking whether…"), absent metrics (traffic/conversion/new-vs-returning) never described, week-over-week only where both values exist, PRIORITY ACTIONS justified only by the seller's own numbers (the old example literally taught citing external benchmarks — judge correctly flags those), bad→good rewrite examples embedded in both prompts. [owner:: claude]
- [x] **Synthesis model switched to claude-sonnet-4-6** (`REPORT_SYNTHESIS_MODEL` set in Railway): haiku synthesis fabricated mechanisms in EVERY run ("likely has stronger visual coverage", "every sale came from a new customer" — contradicted by the data). Haiku stays for pass-1 source analysis. Cost delta ~$0.02-0.05/report. [owner:: claude]
- [x] **Eval harness fixed where it measured wrong, not just prompts**: judge → sonnet (haiku judge was run-to-run noise on edge cases), explicit rubric (investigation framing + derivable arithmetic = NOT hallucination), judge now receives the pipeline-derived totals the synthesis gets (was flagging our own computed numbers), robust JSON extraction. [owner:: claude]
- [x] API redeployed green (health 200, 4 workers); commit 47f555a local. **Sunday 6/14 cron will now generate a real (dry-run) report — first true end-to-end test.** [owner:: claude]

### Completed This Session (session 9 continued — platform expansion: Printify + Instagram LIVE)
- [x] **Feasibility matrix for Printify/TikTok Shop/Instagram/Facebook + 6 more platforms** → [[Projects/Welra/Platform_Feasibility_2026-06]]. Built the two that fit current boundaries; TikTok = CSV today/API post-beta; Facebook sales API not feasible (Meta wound it down). [owner:: claude]
- [x] **Printify integration LIVE end-to-end** (Ryan-approved prod migration adding printify+instagram to platform CHECK): token validated against shops.json at connect (shop resolved server-side), fetcher hardened (early-exit pagination, cancelled excluded, fixture-tested), dashboard card live. Strategic note: covers R&R's Etsy sales via their own POD data — no Etsy API needed. [owner:: claude]
- [x] **Instagram integration LIVE** (Graph API, business accounts): connect card (token + account ID), validation at connect, 60-day expiry tracked for token-health emails. Engagement-only — pipeline verified safe for revenue-less sources. [owner:: claude]
- [x] **Waitlist mystery resolved**: table already existed in prod with RLS — task had stayed open; closed. [owner:: claude]
- [x] **arch-review catch**: token-expiry emails linked to a never-built /reconnect route on the cert-less apex domain → now WEB_URL/dashboard/integrations. First integration with real expiry (Instagram) made this live. New pattern logged: grep every backend-emitted URL against the frontend route table. [owner:: claude]
- [x] Privacy page updated BEFORE feature ship (platform list + revocable-token wording) per compliance rule. Both deploys verified green. [owner:: claude]
- **→ Ryan next: paste R&R's Printify token on welra.io/dashboard/integrations** (Printify → My Account → API) — first live fetcher verification + first dogfood beta account. [owner:: ryan]

### Completed This Session (session 9 final — press machine + dashboard completion)
- [x] **Free-press strategy shipped end-to-end**: Phase 4 added to [[Projects/Welra/Marketing_Campaign_2026-06]] (anti-dashboard angle, never "AI"); press kit LIVE at welra.io/press; [[Projects/Welra/Press_Playbook]] (how/when for every Ryan deliverable) + [[Projects/Welra/Press_Drafts]] (field-by-field paste-ready copy: Qwoted/Featured/SourceBottle profiles, BetaList, survey form + distribution post, 3 personalized podcast pitches). [owner:: claude]
- [x] **Dashboard is now 404-free**: /dashboard/reports (list + detail, sandboxed-iframe render, fresh signed PDF links) and /dashboard/settings (editable name + IANA-validated timezone via new PATCH /auth/me; email change via Supabase secure dual confirmation w/ customers.email reconciliation; Stripe billing portal via new POST /checkout/portal; ZIP export; sign out). [owner:: claude]
- [x] **Brand lockup everywhere**: Logo component (radar icon + "Welra") in all 11 prominent spots; logo SVG wordmark fixed "welra"→"Welra". [owner:: claude]
- [x] **Critical config catch: Supabase Auth Site URL was still `http://localhost:3000`** (fallback for ALL auth email links; allowlist was exact-path only). Ryan fixed: Site URL → https://www.welra.io + `/**` wildcard redirects. Pattern logged to scaffold memory + arch-review skill. Remaining: fresh throwaway-signup e2e test. [owner:: ryan+claude]
- [x] Key learnings logged to [[Knowledge_Base/Learnings_and_Conventions]]: noisy-judge calibration before prompt iteration; synthesis model tier = quality control not cost knob; Supabase Site URL go-live checklist; secure email change pattern. [owner:: claude]

### Completed This Session (session 10 — 2026-06-12: Shop Radar Scan + Week Cards LIVE)
- [x] **Free Shop Radar Scan SHIPPED** (Marketing Phase 3 asset #1): public `POST /scan` (no auth, NOTHING stored, per-IP 4/hr + global 200/day Claude-call cap with stats-only degradation, full-prior-week-coverage guard on comparisons) + welra.io/scan page (drop zone, headline numbers, daily mini-chart, honesty-rule mini-analysis, "want this every Monday?" CTA). Homepage nav + footer link to it. E2E-verified against production incl. a real Claude analysis. [owner:: claude]
- [x] **Shareable Week Cards SHIPPED** (Phase 3 asset #2): 1080×1080 brand PNG per report (trend % + order count ONLY — no revenue), Puppeteer-rendered, uploaded with 12-mo signed URL, embedded in the report email with a download CTA. Failure-tolerant (card error never blocks the report). Covered by retentionCron deletion. [owner:: claude]
- [x] **arch-review catches (1 blocker, fixed pre-deploy)**: ① missing `trustProxy: true` behind Railway's proxy meant EVERY per-IP rate limit (incl. waitlist) was one shared global bucket — the 4/hr scan limit would have locked out all visitors; ② Week Card PNGs weren't in retentionCron's delete predicate (would outlive the 12-mo deletion promise); ③ partial-prior-week comparisons inflated change %. All fixed + two new patterns logged to scaffold memory + the skill. [owner:: claude]
- [x] **Live-test catch**: scan analysis mislabeled weekdays (model derived them from raw dates) — weekday names now computed server-side and passed in the prompt. [owner:: claude]
- [x] Homepage sample-report excerpt reworded to match the honesty-hardened report voice (removed "usually points to checkout friction" causal claims + external Etsy benchmark) — visitors comparing the sample against a real free scan now see a consistent voice. [owner:: claude]
- [x] **Ryan's full action list written** → [[Projects/Welra/Ryan_Action_List_2026-06-12]] (Batch A: PAT scope, auth e2e test, Printify token, Sentry, Shopify protected-data, Termly wording verbatim, redirect URLs · Batch B: press setup with Press_Drafts §refs · Batch C: calendar items). [owner:: claude]

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
