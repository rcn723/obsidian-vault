---
title: AutoBiz Tasks v5
project: AutoBiz
type: tasks
updated: 2026-06-04
tags: [business, tasks, saas]
---

# AutoBiz Tasks — All Phases

---

## Phase 0 — Pre-Build (Ryan — Before Writing Code)

- [x] Register gr3nb.com domain — registered ✅ [owner:: ryan] [priority:: high] [status:: done]
- [x] Save gr3nb.com domain receipt → ~/Documents/GR3NB/Tax/2026/Receipts/Formation/ — PDF filed ✅ [owner:: ryan] [priority:: high] [status:: done]
- [x] File GR3NB LLC in Oregon at sos.oregon.gov ($100 — act as own registered agent) — **APPROVED** ✅ 2026-06-01 · Registry #258223198 [owner:: ryan] [priority:: high] [status:: done]
- [x] Save Oregon LLC receipt + Articles of Organization PDF → ~/Documents/GR3NB/Legal/ AND Tax/2026/Receipts/Formation/ [owner:: ryan] [priority:: high] [status:: open]
- [x] File DBA "Welra" as Assumed Business Name at Oregon SOS (~$50) — submitted 2026-06-04, awaiting approval [owner:: ryan] [priority:: high] [status:: done]
- [x] File DBA "Rust & Rainbow" as Assumed Business Name at Oregon SOS (~$50) — submitted 2026-06-04, awaiting approval [owner:: ryan] [priority:: high] [status:: done]
- [ ] Save both DBA confirmation PDFs → ~/Documents/GR3NB/Legal/ AND Tax/2026/Receipts/Formation/ [owner:: ryan] [priority:: high] [status:: open]
- [x] Apply for EIN at IRS.gov (free, 15 min) — EIN: 42-2858110 ✅ 2026-05-30 [owner:: ryan] [priority:: high] [status:: done]
- [x] Print/screenshot EIN confirmation page immediately → ~/Documents/GR3NB/Legal/EIN_Confirmation_GR3NB_LLC.pdf ✅ 2026-05-30 [owner:: ryan] [priority:: high] [status:: done]
- [x] Add EIN to ~/Documents/GR3NB/README.md (top line) ✅ 2026-05-30 [owner:: claude] [priority:: high] [status:: done]
- [ ] Submit Etsy developer application at etsy.com/developers [owner:: ryan] [priority:: high] [status:: open]
- [ ] Submit Shopify Partner application at partners.shopify.com [owner:: ryan] [priority:: high] [status:: open]
- [ ] Open Mercury Bank account (mercury.com) [owner:: ryan] [priority:: high] [status:: open]
- [ ] Generate Privacy Policy + ToS + DPA via Termly ($30/mo, cancel after) [owner:: ryan] [priority:: high] [status:: open]
- [ ] Save Termly receipt → Tax/2026/Receipts/Services/ and all 3 PDFs → Legal/ [owner:: ryan] [priority:: high] [status:: open]
- [ ] Create Operating Agreement (Rocket Lawyer free template) [owner:: ryan] [priority:: medium] [status:: open]
- [ ] Save signed Operating Agreement PDF → ~/Documents/GR3NB/Legal/ [owner:: ryan] [priority:: medium] [status:: open]
- [x] Choose SaaS product brand name (DBA under GR3NB) — **Welra**, welra.io registered [owner:: ryan] [priority:: high] [status:: done]
- [x] Save welra.io domain receipt → Tax/2026/Receipts/Formation/ — PDF filed ✅ [owner:: ryan] [priority:: high] [status:: done]
- [ ] File USPTO trademark for WELRA (~$350, tmsearch.uspto.gov to confirm clear, then file via USPTO Trademark Center) [owner:: ryan] [priority:: medium] [status:: open]
- [ ] Create Lemon Squeezy account (payment backup, standby only) [owner:: ryan] [priority:: medium] [status:: open]
- [ ] Complete Home Office Worksheet → ~/Documents/GR3NB/Home_Office/Home_Office_Worksheet_2026.md [owner:: ryan] [priority:: medium] [status:: open]
- [ ] Take photo of workspace → ~/Documents/GR3NB/Home_Office/workspace_photo_2026.jpg [owner:: ryan] [priority:: medium] [status:: open]
- [ ] Add GR3NB expense log habit to calendar: 1st of every month, 10 min [owner:: ryan] [priority:: medium] [status:: open]
- [ ] Set calendar reminders for quarterly IRS estimated tax payments (Apr 15 / Jun 16 / Sep 15 / Jan 15) [owner:: ryan] [priority:: high] [status:: open]
- [ ] Set calendar reminder for Oregon LLC annual renewal (~May 2027, $100) [owner:: ryan] [priority:: medium] [status:: open]

---

## Phase 0B — Infrastructure Activation (Ryan — Do These to Launch the Build)
*The codebase is scaffolded at `~/Claude/Projects/side business/Welra/`. These accounts and credentials activate it.*

### Supabase (Database + Auth)
- [ ] Create project at supabase.com (free tier is fine) [owner:: ryan] [priority:: high] [status:: open]
- [ ] In Supabase Dashboard → SQL Editor → paste contents of `apps/api/src/lib/db/schema.sql` → Run [owner:: ryan] [priority:: high] [status:: open]
- [ ] In Supabase Dashboard → Storage → Create bucket named `reports` (private, 10MB limit) [owner:: ryan] [priority:: high] [status:: open]
- [ ] Copy `SUPABASE_URL` and `SUPABASE_SERVICE_ROLE_KEY` from Project Settings → API → add to `apps/api/.env` [owner:: ryan] [priority:: high] [status:: open]
- [ ] Copy `NEXT_PUBLIC_SUPABASE_URL` and `NEXT_PUBLIC_SUPABASE_ANON_KEY` → add to `apps/web/.env.local` [owner:: ryan] [priority:: high] [status:: open]
- [ ] Save Supabase credentials to ~/Documents/GR3NB/README.md (private notes section) [owner:: ryan] [priority:: high] [status:: open]

### Railway (Backend API hosting)
- [ ] Create account at railway.app (free tier to start) [owner:: ryan] [priority:: high] [status:: open]
- [ ] Create new project → "Deploy from GitHub" → connect `apps/api` folder [owner:: ryan] [priority:: high] [status:: open]
- [ ] Add Railway Redis plugin (needed for BullMQ job queue) [owner:: ryan] [priority:: high] [status:: open]
- [ ] Set all env vars from `apps/api/.env.example` in Railway dashboard [owner:: ryan] [priority:: high] [status:: open]
- [ ] Copy Railway deployment URL → add as `NEXT_PUBLIC_API_URL` in Vercel env vars [owner:: ryan] [priority:: high] [status:: open]
- [ ] Confirm `/health` endpoint returns `{"status":"healthy"}` [owner:: ryan] [priority:: high] [status:: open]

### Vercel (Frontend hosting)
- [ ] Create account at vercel.com (free tier) [owner:: ryan] [priority:: high] [status:: open]
- [ ] Import project → connect `apps/web` folder [owner:: ryan] [priority:: high] [status:: open]
- [ ] Set all env vars from `apps/web/.env.example` in Vercel dashboard [owner:: ryan] [priority:: high] [status:: open]
- [ ] Add custom domain: welra.io → point DNS from Namecheap to Vercel nameservers [owner:: ryan] [priority:: high] [status:: open]
- [ ] Confirm landing page loads at welra.io [owner:: ryan] [priority:: high] [status:: open]

### Stripe (Payments)
- [ ] Create account at stripe.com → complete business verification (GR3NB LLC, EIN 42-2858110) [owner:: ryan] [priority:: high] [status:: open]
- [ ] Create 8 products in Stripe Dashboard (Products → Add product): [owner:: ryan] [priority:: high] [status:: open]
  - Welra Starter Monthly — $19/mo recurring
  - Welra Starter Annual — $182/yr recurring
  - Welra Pro Monthly — $49/mo recurring
  - Welra Pro Annual — $470/yr recurring
  - Welra Multi Monthly — $99/mo recurring
  - Welra Multi Annual — $950/yr recurring
  - Welra Agency Monthly — $299/mo recurring
  - Welra Agency Annual — $2,870/yr recurring
- [ ] Enable 14-day free trial on all products (Stripe Dashboard → product → trial period) [owner:: ryan] [priority:: high] [status:: open]
- [ ] Enable Stripe Tax (automatic sales tax collection) [owner:: ryan] [priority:: medium] [status:: open]
- [ ] Configure Stripe Customer Portal (Settings → Billing → Customer portal) [owner:: ryan] [priority:: high] [status:: open]
- [ ] Add all 8 Stripe Price IDs to `apps/api/.env` (STRIPE_PRICE_* vars) [owner:: ryan] [priority:: high] [status:: open]
- [ ] Set up Stripe webhook → point to `https://api.welra.io/webhooks/stripe` → copy signing secret to .env [owner:: ryan] [priority:: high] [status:: open]
- [ ] Create Lemon Squeezy account (standby backup — don't configure yet) [owner:: ryan] [priority:: medium] [status:: open]

### Resend (Email delivery)
- [ ] Create account at resend.com (free tier: 3k emails/mo) [owner:: ryan] [priority:: high] [status:: open]
- [ ] Add and verify domain: welra.io (add DNS TXT records in Namecheap) [owner:: ryan] [priority:: high] [status:: open]
- [ ] Copy API key → add `RESEND_API_KEY` to `apps/api/.env` [owner:: ryan] [priority:: high] [status:: open]
- [ ] Send test email to confirm welra.io domain is verified [owner:: ryan] [priority:: high] [status:: open]

### Anthropic API Key
- [ ] Go to console.anthropic.com → API Keys → Create key [owner:: ryan] [priority:: high] [status:: open]
- [ ] Add `ANTHROPIC_API_KEY` to `apps/api/.env` [owner:: ryan] [priority:: high] [status:: open]
- [ ] Set `REPORT_DRY_RUN=true` initially — set to `false` only when ready to send real emails [owner:: ryan] [priority:: high] [status:: open]

### Git Setup
- [ ] Create GitHub repo: `gr3nb/welra` (private) [owner:: ryan] [priority:: medium] [status:: open]
- [ ] `cd "~/Claude/Projects/side business/Welra" && git init && git add . && git commit -m "Initial scaffold"` [owner:: ryan] [priority:: medium] [status:: open]
- [ ] Push to GitHub → connect Railway and Vercel to repo for auto-deploy [owner:: ryan] [priority:: medium] [status:: open]

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
