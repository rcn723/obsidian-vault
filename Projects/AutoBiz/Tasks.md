---
title: AutoBiz Tasks v3
project: AutoBiz
type: tasks
updated: 2026-05-22
tags: [business, tasks, saas]
---

# AutoBiz Tasks — All Phases

---

## Phase 0 — Pre-Build (Ryan — Before Writing Code)

- [ ] Register gr3nb.io domain on Namecheap (~$15) [owner:: ryan] [priority:: high] [status:: open]
- [ ] File GR3NB Wyoming Series LLC at sos.wyo.gov ($100) [owner:: ryan] [priority:: high] [status:: open]
- [ ] Apply for EIN at IRS.gov (free, 15 min) [owner:: ryan] [priority:: high] [status:: open]
- [ ] Submit Etsy developer application at etsy.com/developers [owner:: ryan] [priority:: high] [status:: open]
- [ ] Submit Shopify Partner application at partners.shopify.com [owner:: ryan] [priority:: high] [status:: open]
- [ ] Engage Northwest Registered Agent ($39/year) [owner:: ryan] [priority:: high] [status:: open]
- [ ] Open Mercury Bank account (mercury.com) [owner:: ryan] [priority:: high] [status:: open]
- [ ] Generate Privacy Policy + ToS + DPA via Termly ($30/mo, cancel after) [owner:: ryan] [priority:: high] [status:: open]
- [ ] Create Operating Agreement (Rocket Lawyer free template) [owner:: ryan] [priority:: medium] [status:: open]
- [x] Choose SaaS product brand name (DBA under GR3NB) — **Welra**, welra.io registered [owner:: ryan] [priority:: high] [status:: done]
- [ ] File USPTO trademark for WELRA (~$350, tmsearch.uspto.gov to confirm clear, then file via USPTO Trademark Center) [owner:: ryan] [priority:: medium] [status:: open]
- [ ] Create Lemon Squeezy account (payment backup, standby only) [owner:: ryan] [priority:: medium] [status:: open]

---

## Phase 1 — Core Pipeline (Claude — Week 1–2)

### Database & Infrastructure
- [ ] Supabase schema: customers, integrations, reports, jobs, token_health, feedback, exports [owner:: claude] [priority:: high] [status:: open]
- [ ] Railway project setup + environment variables [owner:: claude] [priority:: high] [status:: open]
- [ ] BullMQ job queue (max 10 concurrent, timezone-aware per customer) [owner:: claude] [priority:: high] [status:: open]
- [ ] Sentry error monitoring (free tier) [owner:: claude] [priority:: high] [status:: open]
- [ ] Uptime Robot monitoring (cron job health) [owner:: claude] [priority:: high] [status:: open]

### Payments
- [ ] Stripe Checkout (all 4 monthly tiers + 4 annual tiers = 8 products) [owner:: claude] [priority:: high] [status:: open]
- [ ] Stripe webhook handler: checkout.session.completed, customer.subscription.deleted, invoice.payment_failed, invoice.payment_succeeded [owner:: claude] [priority:: high] [status:: open]
- [ ] Stripe Customer Portal configuration (upgrades, downgrades, cancellations) [owner:: claude] [priority:: high] [status:: open]
- [ ] Stripe Tax enabled [owner:: claude] [priority:: high] [status:: open]
- [ ] 14-day trial configuration in Stripe (card required, no charge until Day 15) [owner:: claude] [priority:: high] [status:: open]

### Data Integrations
- [ ] WooCommerce WordPress plugin (pull orders, revenue, top products, conversion) [owner:: claude] [priority:: high] [status:: open]
- [ ] CSV upload handler + format auto-detection (top 10 platform formats) [owner:: claude] [priority:: high] [status:: open]
- [ ] Column mapping UI for unrecognised CSV formats [owner:: claude] [priority:: medium] [status:: open]
- [ ] Google Sheets OAuth + data reader (GA4 bridge) [owner:: claude] [priority:: high] [status:: open]
- [ ] Etsy OAuth wizard (or API key fallback if approval pending) [owner:: claude] [priority:: high] [status:: open]
- [ ] Stripe API connector (for Stripe-only businesses) [owner:: claude] [priority:: medium] [status:: open]

### AI Report Pipeline
- [ ] Claude API modular prompt: per-source mini-analysis (Pass 1) [owner:: claude] [priority:: high] [status:: open]
- [ ] Claude API synthesis prompt: unified narrative from mini-analyses (Pass 2) [owner:: claude] [priority:: high] [status:: open]
- [ ] Per-customer cost cap + alert at 2x expected cost [owner:: claude] [priority:: medium] [status:: open]

### Report Delivery
- [ ] Mobile-optimised HTML email template (primary reading experience) [owner:: claude] [priority:: high] [status:: open]
- [ ] Puppeteer PDF renderer (attachment/archive) [owner:: claude] [priority:: high] [status:: open]
- [ ] Resend email delivery with timezone-aware 6am Monday scheduling [owner:: claude] [priority:: high] [status:: open]
- [ ] Data freshness stamp in every report (sources + pull timestamp) [owner:: claude] [priority:: high] [status:: open]
- [ ] Liability disclaimer in every report footer [owner:: claude] [priority:: high] [status:: open]
- [ ] 👍 / 👎 feedback links in report email footer (tracked URLs) [owner:: claude] [priority:: high] [status:: open]

### Safety Systems
- [ ] Pre-report sanity check: revenue = $0 when last week > $0 → halt + alert [owner:: claude] [priority:: high] [status:: open]
- [ ] Spike detection: >300% week-over-week deviation → halt + alert [owner:: claude] [priority:: high] [status:: open]
- [ ] Partial report fallback: if one source fails, deliver rest + explanation [owner:: claude] [priority:: high] [status:: open]
- [ ] Claude API retry logic: fail → retry +2hr, +4hr → delay email if still failing by 5am [owner:: claude] [priority:: high] [status:: open]
- [ ] Automated delay email template ("report delayed, arrives Tuesday") [owner:: claude] [priority:: high] [status:: open]
- [ ] Tuesday retry job after delay email sent [owner:: claude] [priority:: medium] [status:: open]

### Token Health Monitor
- [ ] Daily cron: query all OAuth tokens + expiry dates [owner:: claude] [priority:: high] [status:: open]
- [ ] 7-day pre-expiry email with one-click re-auth link [owner:: claude] [priority:: high] [status:: open]
- [ ] 3-day pre-expiry second email [owner:: claude] [priority:: high] [status:: open]
- [ ] Day-of-expiry: partial report + re-auth prompt [owner:: claude] [priority:: high] [status:: open]

### Feedback Loop
- [ ] Supabase: log feedback clicks (customer, report date, sentiment) [owner:: claude] [priority:: high] [status:: open]
- [ ] Trigger: two consecutive 👎 → automated personal follow-up email from ryan@ [owner:: claude] [priority:: high] [status:: open]
- [ ] Flag 👎 customers in Supabase dashboard view [owner:: claude] [priority:: medium] [status:: open]

### Data Retention & Export
- [ ] Self-serve ZIP export button in dashboard settings [owner:: claude] [priority:: high] [status:: open]
- [ ] Export: generate ZIP with all PDFs + metrics CSV, deliver via Resend link [owner:: claude] [priority:: high] [status:: open]
- [ ] Cancellation confirmation email with export reminder + date [owner:: claude] [priority:: high] [status:: open]
- [ ] Scheduled Supabase deletion job (12 months post-cancellation) [owner:: claude] [priority:: medium] [status:: open]

---

## Phase 2 — Connections Hub (Claude — Week 3)

- [ ] Report Power score UI component (% complete, visual bar) [owner:: claude] [priority:: high] [status:: open]
- [ ] Integration cards: connected state, locked state, coming-soon state [owner:: claude] [priority:: high] [status:: open]
- [ ] In-report gap callouts (replace blurred preview concept) [owner:: claude] [priority:: high] [status:: open]
- [ ] New customer data confirmation step after first connection [owner:: claude] [priority:: high] [status:: open]
- [ ] Etsy guided setup wizard (3-step OAuth) [owner:: claude] [priority:: high] [status:: open]
- [ ] GA4 Sheets bridge wizard (3-step: add-on → share → connect) [owner:: claude] [priority:: high] [status:: open]
- [ ] Meta Ads Make template wizard (branch on Business Manager setup) [owner:: claude] [priority:: medium] [status:: open]
- [ ] CSV upload wizard with drag-and-drop [owner:: claude] [priority:: medium] [status:: open]
- [ ] Agency invite flow (email invite to third-party for account access) [owner:: claude] [priority:: low] [status:: open]

---

## Phase 3 — Landing Page & Geo-Block (Claude — Week 4)

### Geo-Block (EU Exclusion)
- [ ] Vercel Edge Middleware: EU IP geolocation block at signup route [owner:: claude] [priority:: high] [status:: open]
- [ ] EU waitlist capture page (friendly message, email capture) [owner:: claude] [priority:: high] [status:: open]
- [ ] Stripe billing address check: reject EU addresses [owner:: claude] [priority:: high] [status:: open]
- [ ] "Available in US, CA, AU, UK — EU coming soon" footer on landing page [owner:: claude] [priority:: high] [status:: open]

### Landing Page
- [ ] Next.js landing page on Vercel [owner:: claude] [priority:: high] [status:: open]
- [ ] Pricing page: annual tiers as default, monthly as toggle [owner:: claude] [priority:: high] [status:: open]
- [ ] Sample report embedded (anonymised, mobile-optimised HTML version) [owner:: claude] [priority:: high] [status:: open]
- [ ] Segment landing page variants: Etsy / WooCommerce / Multi-channel / Agency [owner:: claude] [priority:: medium] [status:: open]
- [ ] Privacy Policy page (from Termly) [owner:: claude] [priority:: high] [status:: open]
- [ ] Terms of Service page (includes liability disclaimer) [owner:: claude] [priority:: high] [status:: open]
- [ ] FAQ (data security, read-only, platforms, geographic availability, trial) [owner:: claude] [priority:: medium] [status:: open]

---

## Phase 4 — Onboarding & Retention Automation (Claude — Week 4, Parallel)

- [ ] 5-email onboarding sequence in Resend: [owner:: claude] [priority:: high] [status:: open]
  - Day 0: Welcome + connect first platform
  - Day 2: "Report in X days" + sample preview
  - Day 5: "Generating tonight" reminder
  - Day 7: First report delivery
  - Day 8: "How was your report?" NPS prompt
- [ ] Stripe Portal: annual → monthly downgrade flow [owner:: claude] [priority:: medium] [status:: open]
- [ ] Weekly Mercury transfer reminder (move Stripe balance to bank) [owner:: ryan] [priority:: low] [status:: open]

---

## Phase 5 — Beta Validation (Ryan + Claude — Week 5)

- [ ] Recruit 3 beta users from US/CA/AU/UK (Etsy or WooCommerce sellers) [owner:: ryan] [priority:: high] [status:: open]
- [ ] Confirm reports accurate against real data [owner:: ryan] [priority:: high] [status:: open]
- [ ] Test mobile HTML email on iOS + Android [owner:: claude] [priority:: high] [status:: open]
- [ ] Test PDF render on desktop [owner:: claude] [priority:: medium] [status:: open]
- [ ] Confirm 👍/👎 tracking fires correctly [owner:: claude] [priority:: high] [status:: open]
- [ ] Confirm onboarding sequence triggers and delivers [owner:: claude] [priority:: high] [status:: open]
- [ ] Confirm EU IP block works (test with VPN) [owner:: claude] [priority:: high] [status:: open]
- [ ] Confirm annual billing charges correctly at checkout [owner:: claude] [priority:: high] [status:: open]
- [ ] Iterate on report narrative tone based on beta feedback [owner:: claude] [priority:: high] [status:: open]

---

## Phase 6 — Launch (Ryan — Week 6)

- [ ] Enable paid Stripe signups [owner:: claude] [priority:: high] [status:: open]
- [ ] Post in r/Etsy [owner:: ryan] [priority:: high] [status:: open]
- [ ] Post in r/woocommerce [owner:: ryan] [priority:: high] [status:: open]
- [ ] Post in r/Entrepreneur [owner:: ryan] [priority:: high] [status:: open]
- [ ] Post in r/smallbusiness [owner:: ryan] [priority:: high] [status:: open]
- [ ] Post in Etsy Seller Facebook groups [owner:: ryan] [priority:: high] [status:: open]
- [ ] ProductHunt launch [owner:: ryan] [priority:: medium] [status:: open]
- [ ] SEO post: "Etsy weekly report automated" [owner:: claude] [priority:: medium] [status:: open]
- [ ] SEO post: "WooCommerce business intelligence small store" [owner:: claude] [priority:: medium] [status:: open]
- [ ] SEO post: "Multi-channel ecommerce analytics affordable" [owner:: claude] [priority:: medium] [status:: open]

---

## Month 2–3 — Expand

- [ ] Shopify integration (if Partner approval granted) [owner:: claude] [priority:: high] [status:: open]
- [ ] Gumroad API integration [owner:: claude] [priority:: medium] [status:: open]
- [ ] Make templates for Meta Ads + TikTok CSV [owner:: claude] [priority:: medium] [status:: open]
- [ ] Affiliate program (20% recurring commission via Rewardful) [owner:: ryan] [priority:: medium] [status:: open]
- [ ] Submit to SaaSHub, G2, Capterra [owner:: ryan] [priority:: low] [status:: open]
- [ ] Check platform concentration: no single platform >40% of integrations [owner:: ryan] [priority:: medium] [status:: open]
- [ ] Review Etsy developer changelog (monthly) [owner:: ryan] [priority:: medium] [status:: open]
- [ ] Transfer Stripe balance to Mercury (weekly habit) [owner:: ryan] [priority:: medium] [status:: open]
- [ ] File IRS Form 2553 when ARR hits $60k [owner:: ryan] [priority:: low] [status:: open]
- [ ] Evaluate EU expansion readiness [owner:: ryan] [priority:: low] [status:: open]
