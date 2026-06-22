---
title: AutoBiz State v5
project: AutoBiz
type: state
updated: 2026-06-21
brand: Welra
tags: [business, saas, autonomous, multi-channel]
---

# AutoBiz — Project State

## Current Phase
**BUILDING** — Phase 1 scaffold complete. Supabase schema, API backend, and Next.js frontend scaffolded.
iOS app added to business plan as Phase 7 growth vector. Multi-growth strategy documented.

## Holding Company
**GR3NB LLC** — Oregon LLC (not Wyoming — see Legal Structure decision below)
G=Grace/Grant · R3=Ryan · N=Northam · B=Brock
Registry #258223198 · Approved 2026-06-01
Name cleared — zero conflicts across all channels
Domain to register: gr3nb.com

## Legal Structure Decision (2026-05-28)
Switched from Wyoming Series LLC to **Oregon LLC** after analysis:
- Operating from Oregon → must register Wyoming LLC as Foreign LLC anyway (~$275 + $100/yr extra)
- Net extra cost of Wyoming: ~$274/year with zero income tax savings
- Oregon Series LLC doesn't exist; Wyoming Series liability protection unsettled in OR courts
- Oregon LLC + DBAs covers both businesses at Phase 1 ($200 total setup)
- Revisit child LLCs when Welra has paying customers; revisit Series LLC if 4+ ventures

## Product 1
AI-written weekly business intelligence reports for multi-channel small sellers.
**Core value prop:** "One AI-written weekly report for sellers who sell everywhere."
Product brand name (DBA): **Welra** (welra.io — registered ✅)

## Geographic Scope
✅ US, Canada, Australia, UK
❌ EU excluded at launch (GDPR complexity)
⏳ EU waitlist captured for future expansion

## Pricing (synced to implementation 2026-06-09)
- Starter: $19/mo · $190/yr (2 months free)
- Pro: $69/mo · $690/yr (2 months free)
- Growth: $129/mo · $1,161/yr (3 months free — deliberate hook)
- Agency: deferred until demand signal (contact-sales path on site)
Annual presented as default on pricing page.
See [[Projects/Welra/Strategy_Review_2026-06-09]] — beta users to validate willingness-to-pay.

## Primary Markets (Tier 1)
- Etsy: 8.13M sellers, zero reporting tools exist
- WooCommerce: 4.5M stores, major analytics gap, plugin model

## Integration Model (4 Paths)
1. Direct API — Etsy, WooCommerce plugin, Stripe, Gumroad
2. Google Sheets bridge — GA4 data via official add-on
3. CSV upload — universal fallback
4. Make templates — Meta Ads, TikTok, etc.

## Planning Milestones Completed
- [x] Business plan v1 drafted
- [x] Holding company name confirmed: GR3NB LLC
- [x] Name cleared (no conflicts)
- [x] Environmental scan: 16+ platforms assessed
- [x] Competitive landscape mapped
- [x] Integration strategy revised (no Google/Meta direct APIs)
- [x] Risk register: 20 risks, all with remediations
- [x] SWOT analysis complete
- [x] All gaps identified and fixed:
  - [x] Claude API fallback + retry logic
  - [x] Mobile-first HTML email report
  - [x] Liability disclaimer (ToS + report footer)
  - [x] EU geo-block + waitlist
  - [x] 5-email onboarding sequence
  - [x] 👍/👎 feedback loop
  - [x] Annual pricing tiers
  - [x] Data export + retention policy
  - [x] Stripe backup (Lemon Squeezy)
  - [x] Customer segmentation strategy
  - [x] Platform concentration monitoring
- [x] Business plan v3 complete
- [x] Tasks.md fully populated (6 phases, 80+ tasks)

## Execution Milestones
- [x] gr3nb.com domain registered ✅
- [x] welra.io domain registered ✅
- [x] Oregon LLC **APPROVED** ✅ 2026-06-01 — Registry #258223198
- [x] EIN obtained — **42-2858110** ✅ 2026-05-30
- [x] DBAs filed and **APPROVED** ✅ 2026-06-05
  - Welra DBA Registry #258497594
  - Rust and Rainbow DBA Registry #258496893
- [ ] Etsy developer app submitted
- [ ] Shopify Partner app submitted
- [x] Mercury Bank account opened ✅ 2026-06-04
- [x] Privacy Policy + ToS + DPA generated ✅ 2026-06-05
  - HTML embed codes saved to ~/Documents/GR3NB/Legal/
  - Custom DPA written from scratch (Termly doesn't offer DPA) → Welra_DPA.md
  - Termly Pro+ cancelled after saving all three documents
- [x] SaaS product brand name chosen: **Welra** (welra.io registered) ✅
- [x] **BUILD STARTED** ✅ 2026-05-30
  - Monorepo: `~/Claude/Projects/side business/Welra/`
  - Supabase schema: complete (`schema.sql`)
  - API backend (Fastify + TypeScript): scaffolded
  - Report generator + Claude API pipeline: built (prompt caching added 2026-05-31)
  - BullMQ worker + retry logic: built
  - Token health cron: built
  - Report scheduler cron: built
  - Stripe webhook handler: built
  - Email service (Resend): built
  - Report HTML renderer: built
  - PDF renderer (Puppeteer): built
  - Next.js frontend: scaffolded (landing page + dashboard)
  - Shared types package: complete
  - Printify integration: built 2026-05-31 (`integrations/printify.ts`)
  - Instagram integration: built 2026-05-31 (`integrations/instagram.ts`)
- [x] Supabase project created + schema deployed ✅ 2026-06-06 · project: ozhekoiehpajeytwltrv · reports bucket created
- [x] Railway project created + API deployed ✅ 2026-06-07 — deploy green after 6 deploys (BullMQ lazy-init, Stripe lazy-init, Node 22 for Supabase realtime-js WebSocket, env.ts crash fixes)
- [ ] Etsy integration: full implementation
- [ ] WooCommerce integration: full implementation
- [ ] Stripe integration: full implementation
- [ ] Connections Hub UI
- [ ] Beta users onboarded (target: 3)
- [ ] Paid signups live
- [ ] First paying customer

## iOS App (Phase 7 — Month 4–6)
Added to business plan v5 as growth vector.
Stack: React Native + Expo + RevenueCat
Trigger: 10+ paying web customers with proven retention
- [ ] Apple Developer Program enrollment ($99/yr)
- [ ] React Native + Expo scaffold
- [ ] IAP pricing configured (30% premium over web)
- [ ] App Store submission

## Key Open Decisions
- Pricing confirmation: docs now assume implemented $19/$69/$129 stands (revert easy pre-launch)
- Tier naming resolved 2026-06-09: **'growth'** (code, Stripe, and site all use it; business plan updated)
- Critical path per [[Projects/Welra/Strategy_Review_2026-06-09]]: submit Etsy + Shopify dev apps NOW (4–8 wk lead); build CSV upload; recruit 3–5 beta users before Stripe live mode.

> **Welra build status (as of 2026-06-21, session 22):** API + web both deployed (commit `a0933df`). Two report-email bugs found by dogfooding and fixed (synthesis markdown rendered raw; UTC date parse showed wrong week label). `welra.io/sample` is LIVE — dedicated page with the full real report + beta CTA. Scoreboard: 0 users / 0 revenue / Stripe TEST. Warm-network outreach is the path to beta user #1 (cold channels too new-account-taxed). Stale Continuation_Playbook — needs refresh next session. Welra `reportGenerator.ts` model ID updated to `claude-haiku-4-5-20251001` (canonical) — needs `railway up` to deploy. See [[Projects/Welra/State]] for full session-by-session history.

> **Note:** Product/engineering state now lives in [[Projects/Welra/State]] + [[Projects/Welra/Tasks]].
> This AutoBiz project tracks business/legal/tax only. (Source-of-truth split, 2026-06-09.)

## Links
- [[Projects/AutoBiz/Business_Plan]]
- [[Projects/AutoBiz/Tasks]]
- [[Projects/AutoBiz/Tax_Reference]]
