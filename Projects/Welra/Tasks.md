---
title: Welra Tasks
project: Welra
type: tasks
updated: 2026-06-09
tags: [welra, tasks, launch]
---

# Welra Tasks — Product & Engineering

Source of truth for product/engineering work. Business/legal/tax tasks live in [[Projects/AutoBiz/Tasks]].
Priorities set by [[Projects/Welra/Strategy_Review_2026-06-09]].

## Critical Path (in order)

- [ ] Submit Etsy developer application at etsy.com/developers — free, 15 min, 4–8 wk approval lead. DO FIRST. [owner:: ryan] [priority:: high] [status:: open]
- [ ] Submit Shopify Partner application at partners.shopify.com — same lead time. [owner:: ryan] [priority:: high] [status:: open]
- [x] Build CSV upload + format auto-detection — DONE 2026-06-10: POST /uploads/csv (JWT-authed), Etsy/Shopify/Woo/generic auto-detect, normalized orders in private storage, wired into report generation, deployed + smoke-tested. Parser verified against all 3 formats. **First working commerce ingestion path.** [owner:: claude] [priority:: high] [status:: done]
- [ ] Recruit 3–5 beta users on free accounts BEFORE Stripe live mode. ⚠️ CORRECTION (2026-06-10): etsy/shopify/woocommerce/stripe integration modules are 5-line STUBS returning null — **CSV upload (shipped tonight) is the ONLY working ingestion path**. Beta users from any platform can join via weekly CSV export. Ask Van Westendorp pricing questions. [owner:: ryan] [priority:: high] [status:: open]
- [x] Implement WooCommerce integration for real — DONE 2026-06-10: REST v3, week + prev-week order aggregation (completed/processing only), top products, unique customers, AOV. Connection contract: `access_token = "ck_…:cs_…"`, `shop_id = store URL`. Verified against mocked fixtures; subdirectory WP installs supported. ⚠️ Verify `status[]` array param against the first real beta store. [owner:: claude] [priority:: high] [status:: done]
- [ ] Implement Etsy integration for real once developer app approved (currently a stub) [owner:: claude] [priority:: high] [status:: blocked]
- [ ] Run first real-data report generation for a beta user; verify accuracy against their dashboard [owner:: claude] [priority:: high] [status:: open]
- [ ] Switch Stripe to live mode: recreate products/prices, swap sk_live/pk_live/price IDs in Railway + Vercel, create live webhook endpoint via API, VERIFY all 6 STRIPE_PRICE_* env vars match live price IDs [owner:: ryan] [priority:: high] [status:: blocked]
- [ ] Flip REPORT_DRY_RUN=false in Railway (env schema now validates strictly) + confirm a real report email sends [owner:: claude] [priority:: high] [status:: blocked]

## Pre-Live Hardening

- [ ] GitHub Actions CI: workflow WRITTEN (.github/workflows/ci.yml, untracked locally) but the saved GitHub PAT lacks `workflow` scope so it can't be pushed. Ryan: add `workflow` scope to the PAT at github.com/settings/tokens, then `git add .github && git commit -m "Add CI" && git push`. [owner:: ryan] [priority:: high] [status:: blocked]
- [ ] Wire Railway GitHub auto-deploy (Settings → Source) so git push triggers rebuild [owner:: claude] [priority:: medium] [status:: open]
- [x] Sentry wiring shipped 2026-06-10 (lazy, activates on SENTRY_DSN; boot log confirms). Remaining: Ryan creates Sentry account + sets SENTRY_DSN in Railway (tracked below in arch-review section). [owner:: claude] [priority:: high] [status:: done]
- [ ] Set up Uptime Robot on /health [owner:: claude] [priority:: medium] [status:: open]
- [x] EU billing-address check — DONE 2026-06-10: billing_address_collection required at checkout; webhook rejects EU27 billing countries and cancels the (untrialed-charge) subscription before any activation. [owner:: claude] [priority:: high] [status:: done]
- [x] Audit actual data handling vs published Privacy Policy claims — DONE 2026-06-10 → [[Projects/Welra/Privacy_Audit_2026-06-10]] (3 unimplemented promises found) [owner:: claude] [priority:: high] [status:: done]
- [ ] Amend Privacy Policy wording: disclose CSV-upload data retention; soften ZIP-export promise until built (Termly edit) [owner:: ryan] [priority:: high] [status:: open]
- [x] Build retention/deletion job — DONE 2026-06-10: daily 3am UTC BullMQ cron (retentionCron.ts). On cancellation: tokens nulled + CSV order data deleted from storage. 12mo post-cancellation: reports + PDFs deleted. Arch-review caught + fixed a blocker: `canceled_at` was never cleared on re-subscribe → stale timestamp could trigger premature irreversible deletion; webhooks now manage canceled_at on every status transition. [owner:: claude] [priority:: high] [status:: done]
- [x] Build ZIP export — DONE 2026-06-10: GET /reports/export streams all delivered reports as ZIP (PDF, HTML fallback). Privacy-audit promise #3 now TRUE — Termly edit only needs the CSV-retention wording now. [owner:: claude] [priority:: medium] [status:: done]
- [x] Remove dead 'agency' code path — DONE 2026-06-10 (PlanTier, TIER_CONFIG, synthesis prompts; site contact-sales path kept) [owner:: claude] [priority:: medium] [status:: done]
- [ ] Re-audit risk register: re-mark every "✅ Mitigated" whose mitigation is unbuilt/unverified as "Planned" (CSV, Sentry, retry ladder, token emails, onboarding sequence, feedback loop, export, cost cap) [owner:: claude] [priority:: medium] [status:: open]
- [x] Verify META_ACCESS_TOKEN task target — RESOLVED 2026-06-10: belongs to Rust & Rainbow (NAS Instagram agent), not Welra. Already tracked in [[Projects/Rust_and_Rainbow/Tasks]] with due 2026-06-25; `refresh_meta_token.py` exists in the R&R repo to do the refresh. Removed from Welra scope. [owner:: claude] [priority:: medium] [status:: done]

## Report Quality (the product)

- [x] Report-quality eval harness — BUILT 2026-06-10: `npm run eval` in apps/api; 3 golden datasets (Etsy strong week / Woo down week / multi-channel+CSV), production prompts, number/phrase/action checks + hallucination judge. **First full run blocked on API credits.** [owner:: claude] [priority:: high] [status:: done]
- [ ] Run eval harness once credits added; iterate prompts on failures; then A/B synthesis via REPORT_SYNTHESIS_MODEL env var (toggle shipped 2026-06-10) [owner:: claude] [priority:: high] [status:: blocked]
- [ ] Watch Sunday 2026-06-14 cron: first-ever scheduler run fires for test customer (no integrations, dry-run on) — free integration test, check logs Monday [owner:: claude] [priority:: medium] [status:: open]

## From arch-review 2026-06-10 (overnight session)

- [ ] **ADD ANTHROPIC API CREDITS** — console.anthropic.com → Plans & Billing. Both local and Railway keys have zero balance; ALL report generation fails until this is done. Then run `npm run eval` in apps/api to verify. [owner:: ryan] [priority:: high] [status:: open]
- [ ] [DEFERRED from arch-review] Migration: add 'printify','instagram' to integrations.platform CHECK (or drop those modules from scope) — both fail at DB insert today [owner:: ryan] [priority:: medium] [status:: open]
- [x] [DEFERRED from arch-review] Validate :platform param against allowlist in POST /integrations/:platform/token — DONE 2026-06-10 (ALLOWED_PLATFORMS mirrors schema CHECK; keep in sync if printify/instagram migration lands) [owner:: claude] [priority:: medium] [status:: done]
- [ ] [DEFERRED from arch-review] Lazy-init Resend in emailService.ts + feedback.ts per convention [owner:: claude] [priority:: low] [status:: open]
- [x] [DEFERRED from arch-review] Implement /auth/me and /reports routes — DONE 2026-06-10: profile endpoint, report list/detail (fresh 1-hr signed PDF URL), deployed + smoke-tested (401 unauthenticated) [owner:: claude] [priority:: medium] [status:: done]
- [ ] [DEFERRED from arch-review] Set SENTRY_DSN in Railway after creating Sentry account (code wiring shipped 2026-06-10) [owner:: ryan] [priority:: high] [status:: open]

## Marketing & Brand (added 2026-06-10)

- [x] Brand icon + color scheme — DONE 2026-06-10: radar-sweep mark + 6-color palette → [[Projects/Welra/Brand_Identity]]; favicon/logo SVGs + Tailwind tokens committed (commit 3516185) [owner:: claude] [priority:: high] [status:: done]
- [x] Cheap marketing campaign plan — DONE 2026-06-10 → [[Projects/Welra/Marketing_Campaign_2026-06]] ($0 beta phase, ≤$150/mo launch runway) [owner:: claude] [priority:: high] [status:: done]
- [x] Etsy + Shopify developer application walkthrough — DONE 2026-06-10 → [[Projects/Welra/Etsy_Shopify_Developer_Applications]] (key finding: Etsy personal access = 5 shops immediately — beta is NOT blocked on commercial review) [owner:: ryan] [priority:: high] [status:: done]
- [ ] Apply brand palette to landing page (header, CTAs, pricing cards) + report email template [owner:: claude] [priority:: medium] [status:: open]
- [ ] Social/OG card images (1200×630 + square) in brand colors [owner:: claude] [priority:: low] [status:: open]
- [ ] Start beta recruitment cadence per campaign plan (Reddit/FB give-first week, then beta-tester posts + 20 DMs) [owner:: ryan] [priority:: high] [status:: open]
- [ ] Add "Founding Seller beta" banner + waitlist capture to landing page [owner:: claude] [priority:: medium] [status:: open]

## Carried Forward

- [ ] Fix apex domain SSL cert — provision welra.io cert in Vercel Domains settings [owner:: claude] [priority:: medium] [status:: open]
- [ ] Google Sheets bridge (GA4) — second unbuilt ingestion path [owner:: claude] [priority:: medium] [status:: open]
- [ ] Make webhook receiver — third unbuilt ingestion path [owner:: claude] [priority:: low] [status:: open]
- [ ] Weekly "Welra Monday review" scheduled task: Sunday cron logs, Stripe MRR, 👎 flags, Sentry [owner:: claude] [priority:: low] [status:: open]
