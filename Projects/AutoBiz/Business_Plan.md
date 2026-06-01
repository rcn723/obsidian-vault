---
title: GR3NB — Full Business Plan v5
project: AutoBiz
type: business-plan
updated: 2026-05-30
tags: [business, saas, autonomous, ai, startup, multi-channel, ecommerce]
---

# GR3NB LLC — Multi-Channel AI Business Intelligence SaaS

> **Holding Entity:** GR3NB LLC (Oregon LLC)
> G=Grace/Grant · R3=Ryan · N=Northam · B=Brock
>
> **Product 1:** Autonomous AI-written weekly business intelligence reports
> for small sellers who sell across multiple platforms — Etsy, WooCommerce,
> Shopify, and beyond. One report. Every Monday. Zero manual work.

---

## Executive Summary

| | |
|---|---|
| **Holding Entity** | GR3NB LLC (Oregon LLC) |
| **Product 1 Brand** | **Welra** — DBA under GR3NB |
| **Core Value Prop** | One AI-written weekly report unifying all selling channels |
| **Primary ICP** | Multi-channel small sellers: Etsy + WooCommerce + Shopify |
| **Geographic Scope** | US, Canada, Australia, UK only (EU excluded at launch) |
| **Revenue Model** | Monthly + Annual SaaS subscription, self-serve |
| **Pricing (Monthly)** | $19 · $49 · $99 · $299/mo |
| **Pricing (Annual)** | $182 · $470 · $950 · $2,870/yr (20% discount) |
| **Capital to Launch** | ~$500 total |
| **Monthly OpEx** | ~$100/mo |
| **Break-even** | 6 paying customers |
| **Tax Entity** | GR3NB LLC pass-through → S-Corp at $60k ARR |
| **Launch Timeline** | 6 weeks |
| **Name Cleared** | GR3NB — zero conflicts across all channels |
| **Domain** | gr3nb.com |

---

## The Core Problem

Small sellers don't sell on one platform anymore. A typical Etsy seller also
has a Shopify store. A WooCommerce store owner also sells on Etsy and fulfils
through Printify. Every Monday morning they log into 3–4 different dashboards,
manually copy numbers into a spreadsheet, and spend 2 hours trying to figure
out what happened last week. Most give up and fly blind.

**The existing tools fail them:**
- Analytics tools exist per-platform — Etsy-only, Shopify-only, WooCommerce-only
- Enterprise tools (Triple Whale $149+, Northbeam $1,000+) are priced for
  DTC brands doing $1M+ revenue
- All existing tools show dashboards and raw numbers — none write a
  plain-English narrative telling the seller what happened, why, and what
  to do next

**The gap:** Nothing in the $19–$99/mo range delivers AI-written, cross-platform,
plain-English weekly business intelligence to multi-channel small sellers.

---

## The Solution

Every Sunday night the system automatically:

1. Pulls last 7 days of data from every platform the customer sells on
2. Compares to the prior period
3. Runs sanity checks — flags anomalies before they corrupt the report
4. Sends a structured data payload to Claude API
5. Claude generates a modular analysis per source, then synthesises
6. Report renders to mobile-optimised HTML (email body) + PDF (attachment)
7. Delivered by Monday 6am in the customer's local timezone
8. Stripe bills automatically on renewal date

**Sample report excerpt:**
> "Your Etsy shop had its strongest week of Q2 — $4,200 in revenue, up 23%
> vs last week. Your 'Sage Wedding Wreath' listing drove 38% of that with a
> 6.8% conversion rate, well above your 3.1% average. Your Shopify store
> dipped 11% — traffic held steady but cart abandonment rose to 74%.
> This week: run Etsy's thank-you coupon to wreath buyers (they repeat at
> 2.4x the rate of other products), and audit your Shopify checkout for
> friction — that abandonment rate suggests a payment or shipping issue."

---

## SWOT Analysis

### Strengths
- **Near-zero marginal cost per customer** — adding customer 100 costs the same as customer 1
- **95–97% gross margins** — infrastructure scales without proportional cost growth
- **Confirmed whitespace** — zero competitors at $19–$99/mo doing AI-narrative multi-platform reports
- **4-path data ingestion** — no single approval gatekeeper can kill the business
- **Self-serve end-to-end** — no sales team, no account managers
- **Recurring revenue** — predictable, compounding cash flow
- **Vast TAM** — Etsy (8.13M) + WooCommerce (4.5M) + Shopify (5.5M)
- **Founder can build it** — no outsourcing or technical co-founder needed
- **GR3NB Oregon LLC** — simple, low-cost structure; scale to child LLCs per venture as revenue warrants
- **Strong community distribution** — r/Etsy (1.2M), Etsy Facebook groups, r/woocommerce
- **AI narrative = new category** — not another dashboard; tells sellers what to do

### Weaknesses
- Zero brand recognition at launch
- Solo operator — support, iteration, bugs, marketing all on one person
- No paid marketing budget
- Report quality depends entirely on customer's data quality
- Claude API dependency — outages affect all customers simultaneously
- Etsy sellers are price-sensitive — $19/mo may feel like a stretch for hobbyists
- No annual plan (now fixed — see pricing section)
- API approval timelines (Etsy, Shopify) outside our control

### Opportunities
- Etsy seller communities — one viral post = hundreds of signups
- WooCommerce plugin directory — passive discovery by 4.5M store owners
- Agency tier — one agency = 10–20 client reports = $299/mo
- TikTok Shop (15M sellers) — first mover when API opens
- Annual pricing — dramatically lowers churn, improves cash flow
- Affiliate program — sellers recommend to sellers, zero CAC
- Report history as switching cost — 6 months of data = customer stays
- Excluding EU simplifies compliance; US + CA + AU + UK = large enough market
- Expansion to adjacent verticals: POD, creator economy, indie wholesale

### Threats
- Etsy or Shopify builds better native analytics (closes the gap)
- VC-funded competitor enters with marketing budget
- Claude API price increase or deprecation
- Platform API terms change — data access cut off overnight
- Stripe account freeze (new businesses flagged occasionally)
- Economic downturn — small sellers cancel subscriptions first
- Large acquirer bundles competitor tool for free
- Anthropic outage on Sunday night — all reports fail (now mitigated)
- Google changes Sheets export format — breaks GA4 bridge

---

## Geographic Scope

### In Scope at Launch
| Market | Privacy Law | Complexity | Status |
|---|---|---|---|
| 🇺🇸 United States | CCPA (California only) | Low | ✅ Primary |
| 🇨🇦 Canada | PIPEDA | Low-Medium | ✅ Included |
| 🇦🇺 Australia | Privacy Act 1988 | Low-Medium | ✅ Included |
| 🇬🇧 United Kingdom | UK GDPR (post-Brexit) | Medium | ✅ Included |

### Out of Scope at Launch
| Market | Reason |
|---|---|
| 🇪🇺 EU27 | Full GDPR — DPO requirement, data residency, SCCs, too complex at launch |
| All others | Default exclude until deliberately expanded |

### Technical Enforcement
- **Vercel Edge Middleware** — IP geolocation block at signup (5 lines of code)
- **Country selector at signup** — EU country selected → "Not available in your region yet — join the waitlist"
- **Stripe billing address check** — reject EU billing addresses
- **Landing page footer** — "Available in US, Canada, Australia and UK. EU coming soon."
- **Waitlist capture** — EU visitors added to a waitlist email list for future expansion

---

## Environmental Scan Summary

### Platform Landscape

| Platform | Active Sellers | Analytics Gap | Our Opportunity |
|---|---|---|---|
| **Etsy** | 8.13M | Massive — views/revenue only, zero reporting tools | ⭐⭐⭐⭐⭐ |
| **WooCommerce** | 4.5M+ | Massive — 15-50% revenue underreporting, no LTV | ⭐⭐⭐⭐⭐ |
| **Shopify** | 5.5M | Medium — tools exist but $149+/mo | ⭐⭐⭐⭐ |
| **TikTok Shop** | 15M+ | Massive — API gated in 2026 | ⭐⭐⭐⭐ (wait) |
| **Gumroad** | 100k+ | Medium — basic sales only | ⭐⭐⭐ |
| **eBay** | 17M | Moderate | ⭐⭐⭐ |
| **Redbubble/Society6/Zazzle** | Unknown | N/A — sellers have zero data access | ❌ |

### Competitive Landscape

| Tool | Price | Gap We Exploit |
|---|---|---|
| **Triple Whale** | $149–$2,500+/mo | Too expensive, Shopify-only, no narrative |
| **Northbeam** | $1,000+/mo | Enterprise only |
| **Metorik** | $20–$100/mo | WooCommerce-only, no AI narrative |
| **Marmalead/eRank** | $10–20/mo | Etsy SEO only — zero reporting |
| **Polar Analytics** | $300+/mo | Too expensive, too complex |
| **Putler** | $20–50/mo | Single platform, no AI narrative |

**The gap in one line:** Nothing under $149/mo writes plain-English
cross-platform weekly reports for multi-channel small sellers. We own that.

---

## Target Customer (ICP)

**Primary:** Multi-channel small seller, US/CA/AU/UK

- Sells on 2+ platforms simultaneously (Etsy + Shopify, or WooCommerce + Etsy)
- $3k–$50k/mo combined revenue across all channels
- Spends 2–4 hours/week manually pulling and comparing data across dashboards
- Has tried each platform's native analytics, given up on GA4
- Active in seller communities (Reddit, Facebook groups)
- Would pay $49–99/mo to reclaim those hours and make smarter decisions

**Secondary:** Marketing agencies and VAs managing ecommerce clients ($299/mo Agency tier)

**Segmentation by channel:**

| Segment | Primary Channel | Message |
|---|---|---|
| Etsy-only sellers | r/Etsy, Etsy Facebook groups | "Stop logging into Etsy analytics manually" |
| WooCommerce stores | r/woocommerce, WP forums | "Your WooCommerce reports, automated and explained" |
| Multi-channel sellers | r/Entrepreneur, podcasts | "One report for every platform you sell on" |
| Agencies/VAs | LinkedIn, agency directories | "White-label AI reports for your ecommerce clients" |

Each segment gets its own landing page variant and community-targeted messaging.

---

## Platform & Integration Strategy

### Why We Dropped Google Analytics & Meta Direct APIs

Both require platform approval processes with high rejection rates for new
companies, 4–8 week timelines, and ongoing revocation risk. Replaced with
4-path model — zero gatekeeper dependency.

### Four Data Ingestion Paths

**Path 1 — Direct API**
Etsy (submit Day 1), WooCommerce (WordPress plugin — no approval),
Stripe (easy approval), Gumroad (Month 2)

**Path 2 — Google Sheets Bridge**
GA4 official Sheets add-on → customer shares sheet → we read via Sheets API
(lower sensitivity scope, easier approval). Customer sets up once, auto-refreshes weekly.

**Path 3 — CSV Upload**
Universal fallback. Auto-detects format for top 10 platforms. Column mapping
UI for unrecognised formats. Remembered for next upload.

**Path 4 — Make Templates**
Pre-configured Make scenarios for Meta Ads, TikTok, and 1,500+ others.
Customer authenticates through Make (already approved). Data flows to our webhook.

### Platform Rollout

```
TIER 1 — LAUNCH (Month 1)
├── Etsy API (submit Day 1)
├── WooCommerce WordPress plugin (no approval)
├── Stripe API (easy, launch day)
├── CSV Upload (zero dependency)
└── Google Sheets bridge (GA4 data)

TIER 2 — EXPAND (Month 2–3)
├── Shopify Partner (submit Day 1, ~4–8 weeks approval)
├── Gumroad API
├── Make templates (Meta + TikTok)
└── eBay API

TIER 3 — WATCH (Month 4+)
├── TikTok Shop (API gated — revisit)
└── Patreon, Pinterest

NEVER
├── Redbubble / Society6 / Zazzle (sellers have no data)
├── Google Analytics direct (use Sheets bridge)
└── Meta Ads direct (use Make templates)
```

---

## Pricing

### Monthly Tiers

| Tier | Price | Platforms | Reports | Best For |
|---|---|---|---|---|
| **Starter** | $19/mo | 1 | Weekly | Etsy-only or WooCommerce-only sellers |
| **Pro** | $49/mo | 3 | Weekly | Sellers on 2–3 platforms |
| **Multi** | $99/mo | Unlimited | Weekly + monthly summary | Serious multi-channel sellers |
| **Agency** | $299/mo | 10 client accounts | White-label, weekly per client | Agencies, VAs |

### Annual Tiers (20% discount — 2 months free)

| Tier | Annual Price | Monthly Equivalent | Savings |
|---|---|---|---|
| **Starter Annual** | $182/yr | $15.17/mo | $46/yr |
| **Pro Annual** | $470/yr | $39.17/mo | $118/yr |
| **Multi Annual** | $950/yr | $79.17/mo | $238/yr |
| **Agency Annual** | $2,870/yr | $239.17/mo | $718/yr |

Annual customers churn at 3–5x lower rates than monthly.
Present annual as default on pricing page — monthly as secondary option.

### Unit Economics

| Tier | Monthly Price | Claude API cost | Gross Margin |
|---|---|---|---|
| Starter | $19 | ~$0.50 | 97% |
| Pro | $49 | ~$1.50 | 97% |
| Multi | $99 | ~$3.50 | 96% |
| Agency | $299 | ~$15.00 | 95% |

### Free Trial
**14-day free trial, credit card required.**
Card-required trials convert at 3–5x the rate of no-card trials.
14 days = two Monday reports = enough value to decide.
No charge until Day 15. Cancel anytime during trial with no charge.

---

## Legal & Tax Structure

### GR3NB LLC — Oregon LLC

**Decision (2026-05-28):** Oregon LLC chosen over Wyoming Series LLC after thorough analysis.
Wyoming would require Oregon Foreign LLC registration on top of Wyoming fees (you operate from Oregon),
netting zero tax savings, ~$250+/year in extra cost, and legally unsettled Series LLC liability
protection in Oregon courts. Oregon is simpler, cheaper, and fully adequate for this stage.

| Requirement | Detail |
|---|---|
| Filing fee | $100 one-time (sos.oregon.gov) |
| Annual renewal | $100/year |
| Oregon income tax | Pass-through — taxed on personal return (Schedule C → S-Corp at $60k ARR) |
| Sales tax | None — Oregon has no state sales tax |
| Registered Agent | Not required — Ryan acts as own RA |
| DBA (Assumed Business Name) | $50 per ABN, valid 2 years ($50 renewal) |

### Entity Structure

**Phase 1 (now):** One Oregon LLC + two DBAs

```
GR3NB LLC (Oregon LLC)
├── DBA: "Welra"          ← SaaS product ($50 ABN)
└── DBA: "Rust & Rainbow" ← POD/Etsy business ($50 ABN)
```
One annual report. One tax return. One bank account. Total cost: ~$200 to set up.

**Phase 2 (when Welra has paying customers):** Spin Welra into its own Oregon child LLC,
owned 100% by GR3NB LLC. Each LLC is a separate legal entity with independent liability.
Cost: $100 to form, $100/year — worth it once real contracts and customers exist.

**Phase 3+ (if 4+ ventures):** Revisit Wyoming Series LLC with an Oregon business attorney
at that time, with current case law in hand. Not needed now.

### Why Not Wyoming Series LLC

- You operate from Oregon → Oregon "doing business" test applies regardless of formation state
- Wyoming LLC requires Oregon Foreign LLC registration ($275 initial + $100/yr) on top of Wyoming fees ($60/yr + $39/yr RA)
- Net extra cost vs Oregon LLC: ~$274/year with **zero** Oregon income tax savings
- Oregon doesn't recognize Series LLCs — liability separation between series in Oregon court is legally unsettled
- For two businesses, two Oregon LLCs costs less than one Wyoming Series LLC + Oregon foreign registration
- Wyoming Series LLC makes sense at 5+ ventures; premature at 2

### Steps (In Order)

1. Register gr3nb.com on Namecheap (~$15)
2. File GR3NB LLC in Oregon at sos.oregon.gov ($100 — act as own registered agent)
3. File Assumed Business Names: "Welra" + "Rust & Rainbow" at Oregon SOS (~$50 each = $100)
4. Apply for EIN at IRS.gov (free, 15 min)
5. Create Operating Agreement (Rocket Lawyer free template)
6. Open Mercury Bank account
7. Create Stripe account + enable Stripe Tax
8. Generate Privacy Policy + ToS + DPA via Termly ($30/mo, cancel after)

### Liability Disclaimer

Add to Terms of Service and footer of every report:

> *"Reports are generated from data provided by your connected platforms.
> GR3NB LLC does not guarantee the accuracy of underlying platform data
> and accepts no liability for business decisions made based on report
> content. Always verify key figures against your platform dashboards.
> Data freshness is shown at the top of every report."*

Every report includes a data freshness stamp:
`Data pulled Sun 11:43pm PST · Etsy ✅ · WooCommerce ✅ · GA4 (Sheets) ✅`

### Data Retention & Portability Policy

- Report history retained for **12 months** after account cancellation
- Customers can export all reports as ZIP at any time (one button, dashboard)
- Raw API/platform data deleted after report generation — never stored long-term
- Automated Supabase cleanup job deletes expired data on schedule
- Stated clearly in Privacy Policy and on cancellation confirmation screen

### Tax Treatment

**At launch:** Single-member LLC — income flows to Schedule C.
Pay self-employment tax (15.3%). File quarterly estimated taxes via IRS Direct Pay.

**At ~$60k ARR:** File IRS Form 2553 → S-Corp election.
Pay yourself reasonable salary (~$40k). Remaining profit = distributions (no SE tax).
Saves $6,000–15,000/year above that threshold.

**Stripe Tax** handles US sales tax automatically across all states.
Hire a CPA for Year 1 (~$400). Worth it.

### Annual Compliance Costs

| Item | Cost |
|---|---|
| Oregon LLC annual renewal | $100/year |
| Registered Agent | $0 (self) |
| DBA renewals (2 ABNs, every 2 years) | ~$50/year average |
| Mercury Bank | $0 |
| Wave accounting | $0 |
| CPA (Year 1 only) | ~$400 |
| **Total Year 1** | **~$550** |
| **Total Year 2+** | **~$150/year** |

---

## Technology Stack

| Component | Tool | Cost | Notes |
|---|---|---|---|
| Backend + cron | Railway (Node.js/TypeScript) | $5–20/mo | Built-in scheduler |
| Database | Supabase (Postgres) | $0–25/mo | Auth + DB + real-time |
| Job queue | BullMQ (Redis) | $0–10/mo | Concurrency control, retries |
| AI reports | Claude API (claude-haiku-4-5) | Usage-based | Modular prompt architecture |
| Email delivery | Resend | $0–20/mo | HTML + PDF delivery |
| PDF rendering | Puppeteer (self-hosted) | $0 | HTML → PDF |
| Payments (primary) | Stripe | 2.9% + $0.30 | Billing, dunning, tax, portal |
| Payments (backup) | Lemon Squeezy | 5% + $0.50 | Standby if Stripe freezes |
| Frontend | Next.js 14 on Vercel | $0/mo | Edge Middleware for geo-block |
| Auth | Supabase Auth | $0 | Built-in, email + Google OAuth |
| Token monitor | Custom daily cron | $0 | Proactive expiry alerts |
| Error monitoring | Sentry (free tier) | $0 | Silent failure detection |
| Uptime monitoring | Uptime Robot | $0 | Cron job alerts |
| Geo-blocking | Vercel Edge Middleware | $0 | EU IP block at signup |
| **iOS App (Phase 7)** | React Native + Expo | $0 | Shares backend — JS/TS monorepo |
| **IAP management** | RevenueCat | Free <$2.5k MRR | Apple IAP + Google Play abstraction |
| **Push notifications** | Expo Notifications | $0 | Monday report + anomaly alerts |
| **App Store** | Apple Developer Program | $99/yr | Required for iOS distribution |

**Total monthly infrastructure at launch: ~$50–100**
**Monorepo structure:** `apps/web` + `apps/api` + `apps/mobile` — shared types and utils

---

## How It Runs Itself (Complete Automation Map)

### Acquisition
```
SEO / Reddit / ProductHunt / Affiliate → Landing Page
    → EU IP detected: waitlist capture, not signup
    → US/CA/AU/UK: Stripe Checkout (14-day trial, card required)
```

### Onboarding
```
Stripe webhook: checkout.session.completed
    → Supabase: create customer row
    → Resend: trigger 5-email onboarding sequence (see below)
    → Customer directed to Connections Hub dashboard
    → Connects platforms via guided wizards
    → New connection: data confirmation step fires
      "We found X orders — does this look right? [Yes] [No]"
```

### Onboarding Email Sequence (Automated via Resend)
```
Day 0:  Welcome + "Connect your first platform" CTA
Day 2:  "Your first report arrives in X days" + sample report preview
Day 5:  "Report generates tonight — make sure you're connected" reminder
Day 7:  First report delivered (Monday 6am local time)
Day 8:  "How was your first report?" → NPS prompt + feedback link
```

### Weekly Report Generation (Sunday, Per Customer Timezone)
```
BullMQ job queue triggers per customer (max 10 concurrent)
    → Pull data from connected sources (APIs / Sheets / CSVs)
    → Pre-flight sanity checks:
        - Revenue = $0 and last week > $0? → anomaly alert, halt
        - Any metric >300% deviation? → anomaly alert, halt
        - All sources returning data? → partial fallback if not
    → Structure data payload per source
    → Claude API Pass 1: per-source mini-analysis
        (Etsy analysis, WooCommerce analysis, GA4 analysis — separately)
    → Claude API Pass 2: synthesise into unified narrative
    → Add data freshness stamp + liability disclaimer footer
    → Render:
        A) Mobile-optimised HTML (email body — primary reading experience)
        B) Full PDF (attachment — desktop/archive)
    → Resend delivers both by 6am customer local time
    → Log delivery + metrics to Supabase
    → Append 👍 / 👎 feedback links to email footer
```

### Claude API Fallback (New)
```
If Claude API call fails:
    → Retry at +2 hours, +4 hours
    → If still failing by 5am local time:
        → Send automated delay email:
          "Your report is delayed due to a temporary service issue.
           It will arrive by Tuesday morning. No action needed."
    → Retry once more Tuesday 11pm
    → Log all retry attempts in Supabase
```

### Feedback Loop
```
Customer clicks 👍 or 👎 in report email
    → Tracked link → Supabase logs sentiment + customer + report date
    → 👍: no action (log only)
    → 👎 twice in a row:
        → Trigger automated "personal" email from ryan@gr3nb.com:
          "Hi [Name] — I noticed the last two reports didn't hit the mark.
           What could be better? I read every reply." (sent from ryan@gr3nb.com)
        → Flag customer in Supabase for manual review
```

### Token Health Monitor (Daily)
```
Daily cron (2am UTC):
    → Query Supabase: all OAuth tokens + expiry dates
    → 7 days before expiry: send re-auth email with one-click link
    → 3 days before: second re-auth email
    → Day of expiry: deliver partial report with explanation
    → Token expired: flag in dashboard, prompt re-auth on next login
```

### Billing (Stripe)
```
Day 14: Trial ends → Stripe charges card
    → Success: subscription active
    → Failure: 3 dunning emails over 7 days
        → Card updated: billing resumes
        → No update: cancel, revoke access, update Supabase
Monthly: auto-charge on renewal date
Annual: auto-charge on anniversary date
All: customer self-serves upgrades/downgrades/cancellations via Stripe Portal
```

### Data Export (Customer Self-Serve)
```
Customer clicks "Export My Data" in dashboard settings
    → Supabase query: all reports for this customer (up to 12 months)
    → Generate ZIP: one PDF per report + CSV of all metrics
    → Resend delivers download link (expires 48 hours)
    → Log export event in Supabase
```

### Post-Cancellation
```
Customer cancels via Stripe Portal
    → Stripe webhook → Supabase: mark inactive, log cancellation date
    → Resend: cancellation confirmation + export reminder
      "Your reports and data are available for 12 months.
       Download your archive anytime before [date]."
    → Schedule Supabase deletion job for 12 months out
    → No reports generated after cancellation date
```

**Human time required weekly: ~15 minutes**
Sentry error check · Uptime Robot · Stripe MRR dashboard · Support inbox

---

## Connections Hub — Report Power Feature

### Design Principles
1. Value before effort — show what they unlock before asking them to connect
2. Branch on their situation — screen complexity before showing OAuth
3. Never dead-end — always offer an alternative path (CSV upload)
4. Confirm data immediately — show real numbers after connecting
5. Read-only always — state explicitly on every card

### Report Power Score
```
████████░░░░░░░░░░  40% — Basic Coverage
"Connect 2 more sources to unlock full clarity."
```

### In-Report Gap Callouts (Not Blurred Previews)
Instead of hiding content behind a blur, reports include contextual gap callouts:
> *"We can see 847 orders this week but not where those customers came from.
> Connect Google Analytics (via Sheets) to add Traffic Source to next week's report →"*

Helpful, not manipulative. Shows the gap without withholding paid-for content.

### Guided Setup Wizards
Each integration has a branching wizard pre-screening setup complexity:
- **Etsy:** OAuth → 2 clicks → done
- **WooCommerce:** Plugin install → API key → done
- **GA4:** Install Sheets add-on → share link → Sheets OAuth → done
- **Meta:** "Do you use Business Manager?" branch → Make template → done
- **CSV:** Drag and drop → auto-detect → column confirm → done

---

## Data Quality & Safety Systems

| System | What It Does |
|---|---|
| Pre-report sanity check | Revenue = $0 and last week > $0 → anomaly alert, halt report |
| Spike detection | >300% week-over-week deviation → hold report, alert customer |
| New customer data confirmation | After connection: "We found X orders — correct?" |
| Modular prompt architecture | Each source analysed separately then synthesised |
| Explicit uncertainty instruction | Claude prompted: "If cause is unclear, say so. Do not speculate." |
| Timezone-aware scheduling | Cron fires per customer timezone, not a global blast |
| Job queue concurrency cap | Max 10 simultaneous — prevents API rate limit collisions |
| Partial report fallback | If one source fails, deliver available data + explanation |
| Claude API retry logic | Fail → retry +2hr, +4hr → delay email if still failing by 5am |
| Data freshness stamp | Every report shows which sources pulled and at what time |
| Liability disclaimer | In every report footer and in Terms of Service |

---

## Capital Requirements

| Item | Cost |
|---|---|
| gr3nb.com domain (1 year) | $15 |
| Oregon LLC filing (sos.oregon.gov) | $100 |
| DBA filings: Welra + Rust & Rainbow ($50 each) | $100 |
| Termly — Privacy Policy/ToS/DPA (1 month) | $30 |
| First month hosting (Railway + Supabase) | $30 |
| **Total to launch** | **~$275** |

Reserve **$500 total** for 3 months of runway.

---

## Revenue Projections

Conservative. Organic only. No paid ads. Mixed monthly/annual.

| Month | Customers | Avg Revenue | MRR Equiv | OpEx | Net |
|---|---|---|---|---|---|
| 1 | 0–5 | $19–49 | $0–150 | $100 | -$100 |
| 2 | 5–15 | $39 avg | $200–600 | $100 | $100–500 |
| 3 | 15–30 | $49 avg | $600–1,500 | $120 | $480–1,380 |
| 6 | 40–80 | $65 avg | $2,600–5,200 | $200 | $2,400–5,000 |
| 12 | 100–200 | $75 avg | $7,500–15,000 | $400 | $7,100–14,600 |

---

## Risk Register

| Risk | Severity | Status | Remediation |
|---|---|---|---|
| Etsy/Shopify API approval delays | 🔴 Critical | ✅ Mitigated | Submit Day 1. WooCommerce + CSV launch while waiting. |
| OAuth token expiry → silent failure | 🔴 Critical | ✅ Mitigated | Daily token monitor. Proactive re-auth emails. Partial fallback. |
| Dirty data → wrong report | 🔴 Critical | ✅ Mitigated | Sanity checks. Spike detection. Customer confirmation step. |
| Claude API outage Sunday night | 🔴 Critical | ✅ Mitigated | 2-hour retry logic. Automated delay email by 5am. Tuesday retry. |
| GDPR / EU data complexity | 🟠 High | ✅ Mitigated | Europe excluded at launch. IP block + Stripe address check. |
| GA4/Meta direct API rejection | 🟠 High | ✅ Mitigated | Sheets bridge + Make templates replace direct APIs entirely. |
| Report accuracy liability | 🟠 High | ✅ Mitigated | Disclaimer in ToS + every report footer. Data freshness stamp. |
| Stripe account freeze | 🟠 High | ✅ Mitigated | Lemon Squeezy as backup. 3-month cash reserve in Mercury. |
| Blurred upsell feels manipulative | 🟠 High | ✅ Mitigated | Replaced with in-report gap callouts (helpful, not manipulative). |
| No mobile report experience | 🟠 High | ✅ Mitigated | Mobile-optimised HTML email body is primary. PDF is secondary. |
| No customer feedback loop | 🟠 High | ✅ Mitigated | 👍/👎 in every report. Two 👎 in a row → personal follow-up email. |
| High churn from monthly-only pricing | 🟠 High | ✅ Mitigated | Annual tiers at 20% discount, presented as default on pricing page. |
| No data portability on cancellation | 🟠 High | ✅ Mitigated | Self-serve ZIP export. 12-month retention. Deletion job scheduled. |
| Cron pileup at scale | 🟡 Medium | ✅ Mitigated | BullMQ queue, max 10 concurrent, timezone-aware. |
| Prompt hallucination | 🟡 Medium | ✅ Mitigated | Modular prompts. Explicit uncertainty instructions. |
| Agency access dead end | 🟡 Medium | ✅ Mitigated | Agency invite flow (direct email invite to agency). |
| Platform concentration risk | 🟡 Medium | ⚠️ Ongoing | No single platform >40% of integrations. Monitor Etsy changelog monthly. |
| Claude API cost spike | 🟡 Medium | ✅ Mitigated | Per-customer cost cap in code. Alert at 2x expected. |
| No onboarding sequence | 🟡 Medium | ✅ Mitigated | 5-email automated sequence (Day 0, 2, 5, 7, 8). |
| No EU waitlist | 🟢 Low | ✅ Mitigated | EU visitors see waitlist capture, not hard rejection. |
| Copycat competitor | 🟢 Low | ⚠️ Ongoing | Moat = integrations + historical data + community trust. |

---

## Launch Milestones

### Phase 0 — Pre-Build (Before Writing Code)
- [x] Register gr3nb.com domain — registered ✅
- [ ] File GR3NB LLC in Oregon (sos.oregon.gov, $100 — act as own registered agent)
- [ ] File DBAs: "Welra" + "Rust & Rainbow" at Oregon SOS (~$50 each)
- [ ] Apply for EIN (IRS.gov, free, 15 min)
- [ ] Submit Etsy developer application (etsy.com/developers)
- [ ] Submit Shopify Partner application (partners.shopify.com)
- [ ] Open Mercury Bank account
- [ ] Generate Privacy Policy + ToS + DPA via Termly
- [ ] Create Operating Agreement (Rocket Lawyer free template)
- [x] Choose SaaS product brand name (DBA under GR3NB) — **Welra**, welra.io registered

### Phase 1 — Core Pipeline (Week 1–2)
- [ ] Supabase schema (customers, integrations, reports, jobs, token_health, feedback)
- [ ] Stripe Checkout + webhook handler (all events)
- [ ] Annual pricing tiers configured in Stripe
- [ ] BullMQ job queue on Railway (max 10 concurrent, timezone-aware)
- [ ] WooCommerce WordPress plugin
- [ ] CSV upload + format auto-detection
- [ ] Claude API modular prompt pipeline (per-source → synthesis)
- [ ] Mobile-optimised HTML email template (primary report format)
- [ ] Puppeteer PDF renderer (attachment/archive format)
- [ ] Resend email delivery (timezone-aware 6am Monday)
- [ ] Pre-report sanity check system
- [ ] Claude API retry logic (2hr, 4hr) + delay email fallback
- [ ] Token health monitor (daily cron + proactive expiry emails)
- [ ] Sentry + Uptime Robot
- [ ] Partial report fallback system
- [ ] Data freshness stamp in every report
- [ ] Liability disclaimer in report footer

### Phase 2 — Connections Hub (Week 3)
- [ ] Report Power score UI
- [ ] Integration cards (connected / locked states)
- [ ] In-report gap callouts (not blurred previews)
- [ ] Etsy OAuth wizard (or API key fallback if not yet approved)
- [ ] Google Sheets OAuth wizard (GA4 bridge)
- [ ] Make template wizard for Meta Ads
- [ ] CSV upload wizard
- [ ] New customer data confirmation step

### Phase 3 — Landing Page + Geo-Block (Week 4)
- [ ] Next.js landing page on Vercel
- [ ] Vercel Edge Middleware EU IP geo-block
- [ ] EU waitlist capture page (not hard rejection)
- [ ] Stripe billing address EU check
- [ ] "Available in US, CA, AU, UK" footer note
- [ ] Pricing page (annual as default, monthly as toggle)
- [ ] Sample report embedded (anonymised, mobile-optimised)
- [ ] Segment landing pages (Etsy / WooCommerce / Multi-channel / Agency)
- [ ] Privacy Policy + ToS + DPA pages
- [ ] FAQ (data security, read-only, supported platforms, geographic availability)
- [ ] Lemon Squeezy account created as payment backup

### Phase 4 — Automation & Retention (Week 4, parallel)
- [ ] 5-email onboarding sequence in Resend
- [ ] 👍/👎 feedback links in report email footer
- [ ] Feedback sentiment logging in Supabase
- [ ] Two consecutive 👎 → automated personal follow-up email
- [ ] Data export (ZIP) self-serve button in dashboard settings
- [ ] Cancellation confirmation email with export reminder
- [ ] 12-month data retention + scheduled deletion job
- [ ] Stripe Portal configured (upgrades, downgrades, cancellations)
- [ ] Annual → monthly downgrade flow
- [ ] Agency invite flow (direct email invite for third-party account access)

### Phase 5 — Validate (Week 5)
- [ ] Recruit 3 beta users (Etsy or WooCommerce sellers, US/CA/AU/UK only)
- [ ] Confirm reports accurate against their real data
- [ ] Confirm mobile HTML email renders correctly on iOS/Android
- [ ] Confirm PDF renders correctly
- [ ] Confirm 👍/👎 tracking works
- [ ] Confirm onboarding sequence fires correctly
- [ ] Iterate on report format and tone

### Phase 6 — Launch (Week 6)
- [ ] Enable paid signups
- [ ] Post in r/Etsy, r/woocommerce, r/Entrepreneur, r/smallbusiness
- [ ] Post in Etsy Seller Facebook groups
- [ ] ProductHunt launch
- [ ] SEO post: "Etsy weekly report automated"
- [ ] SEO post: "WooCommerce business intelligence small store"
- [ ] SEO post: "Multi-channel ecommerce analytics affordable"

### Month 2–3 — Expand
- [ ] Shopify integration (if Partner approval granted)
- [ ] Gumroad API integration
- [ ] Make templates (Meta Ads + TikTok CSV)
- [ ] Affiliate program (20% recurring via Rewardful)
- [ ] Submit to SaaSHub, G2, Capterra
- [ ] Transfer Stripe balance to Mercury weekly (Stripe concentration risk)
- [ ] File IRS Form 2553 when ARR hits $60k

### Phase 7 — Welra iOS App (Month 4–6)
*Trigger: web app has 10+ paying customers and proven retention.*
- [ ] Apple Developer Program enrollment ($99/yr)
- [ ] React Native + Expo project scaffolded (monorepo — shared backend)
- [ ] RevenueCat integration (Apple IAP abstraction layer)
- [ ] Mobile IAP pricing: Starter $24.99/mo, Pro $59.99/mo, Multi $119.99/mo
  (30% Apple premium to cover Apple's 30% cut — web subscribers log in free)
- [ ] Core screens: Dashboard · Weekly Report · Platforms · History · Settings
- [ ] Push notifications via Expo (Monday morning "Your report is ready")
- [ ] Anomaly push alerts ("Revenue down 40% vs last week")
- [ ] Token expiry push alerts ("Reconnect your Etsy in 3 days")
- [ ] Offline report caching (read last 4 reports without internet)
- [ ] App Store assets: screenshots, preview video, icon, description
- [ ] Beta via TestFlight (existing web customers first)
- [ ] App Store submission + review (1–7 days)
- [ ] App Store launch: notify all existing customers

### Phase 8 — Android + Growth (Month 7+)
- [ ] Android Play Store version (React Native — mostly free from iOS build)
- [ ] WooCommerce widget (WordPress admin sidebar mini-report)
- [ ] Welra Shopify App Store listing
- [ ] Welra Etsy App (if Etsy opens app ecosystem)
- [ ] Agency white-label mobile app (custom branding per agency)
- [ ] TikTok Shop integration (when API opens)

---

## Multi-Growth Strategy

Welra is designed as a **platform**, not a single product. Each growth lever compounds the others.

```
GROWTH VECTOR 1 — Web SaaS (Months 1–3)
  welra.io web app → $19–$299/mo subscriptions
  Foundation: backend, integrations, report engine, customer base

GROWTH VECTOR 2 — iOS App (Months 4–6)
  Native iPhone app → distribution + push notifications + App Store SEO
  Monetisation: Apple IAP at slight premium to cover 30% cut
  Web subscribers: log in free (no IAP required)
  New subscribers: IAP available in-app

GROWTH VECTOR 3 — Android App (Month 7+)
  Minimal marginal cost — React Native shares 95% of iOS code
  Doubles addressable market overnight

GROWTH VECTOR 4 — Platform Marketplace Listings (Month 6+)
  Shopify App Store listing → passive discovery
  WooCommerce plugin directory → passive discovery
  Each listing is permanent distribution with no ongoing cost

GROWTH VECTOR 5 — Affiliate + Community (Months 2+)
  20% recurring affiliate (Rewardful)
  Seller-to-seller referral in communities (r/Etsy, FB groups)
  Zero CAC — referrer gets paid, we acquire customer

GROWTH VECTOR 6 — Agency White-Label (Month 3+)
  $299/mo Agency tier → one customer = 10–20 client reports
  Custom branding per agency (logo, color scheme in report)
  Agency mobile app (Phase 8) — agencies love offering branded apps
```

### Why This Sequencing Works
1. **Web first** — validates product before investing in App Store approval process
2. **iOS before Android** — iOS users pay more, convert better, churn less
3. **Marketplace listings** — permanent passive distribution, compound over time
4. **Affiliate last** — only works once product is proven (you need happy customers to refer)

### Revenue Model at Scale (Month 12 Target)

| Channel | Customers | Avg Rev | MRR Contribution |
|---|---|---|---|
| Web (monthly) | 60 | $55 | $3,300 |
| Web (annual, MRR equiv) | 40 | $65 | $2,600 |
| iOS (new via App Store) | 20 | $35 (after Apple cut) | $700 |
| Agency tier | 5 | $299 | $1,495 |
| **Total** | **125** | | **~$8,095 MRR** |

---

## What You Build, What Runs Itself

**You build once (~6 weeks):**
WooCommerce plugin · Etsy connector · Claude modular pipeline ·
Stripe checkout + webhook · BullMQ queue · Connections hub ·
5-email onboarding sequence · Feedback loop · Mobile HTML report ·
PDF renderer · EU geo-block · Data export · Landing page

**Runs itself:**
Stripe — billing, dunning, tax, portal, annual renewals
Railway — job queue, cron, retries
Claude API — report generation, per-source analysis, synthesis
Resend — Monday delivery, onboarding sequence, token alerts, delay emails
Supabase — database, auth, deletion jobs
Uptime Robot + Sentry — monitoring and alerts

**You check in weekly (~15 min):**
Sentry errors · Uptime Robot · Stripe MRR · Support inbox · 👎 flags

---

## Future Business Lines Under GR3NB

| Cell | Concept | Trigger |
|---|---|---|
| GR3NB Agency Tools | White-label version for ecommerce agencies | When Agency tier has 10+ customers |
| GR3NB Maker Intelligence | Etsy/POD deep analytics (listing optimisation, seasonal forecasting) | When Etsy base is 200+ customers |
| GR3NB Wholesale | Faire/wholesale channel reporting for indie brands | Month 6+ evaluation |

---

## Next Steps (In Order)

1. ✅ Holding company name confirmed: **GR3NB LLC**
2. ✅ Name cleared across all channels
3. ✅ Environmental scan + competitive landscape complete
4. ✅ Integration strategy: 4-path model, no Google/Meta dependency
5. ✅ Risk register: 20 risks, all with remediations
6. ✅ SWOT analysis complete
7. ✅ All gaps identified and fixed in plan
8. ✅ Geographic scope: US, CA, AU, UK — EU excluded with waitlist
9. ✅ **gr3nb.com registered** — done
10. [ ] **File GR3NB LLC in Oregon** (sos.oregon.gov, $100 — self as RA) — Ryan
11. [ ] **File DBAs: Welra + Rust & Rainbow** (Oregon SOS, ~$50 each) — Ryan
12. [ ] **Apply for EIN** (IRS.gov, free, 15 min) — Ryan
13. [ ] **Submit Etsy developer app** — Ryan
14. [ ] **Submit Shopify Partner app** — Ryan
15. [ ] **Open Mercury Bank** — Ryan
16. ✅ **SaaS product brand name chosen: Welra** (welra.io registered)
17. [ ] **Build** — Claude Code

---

*Plan v4 — Oregon LLC structure · Claude Code · 2026-05-28*
*v3 incorporated: SWOT, geographic scope, annual pricing, mobile email,*
*Claude API fallback, 5-email onboarding, feedback loop, liability disclaimer,*
*data retention + portability, Stripe backup, customer segmentation,*
*platform concentration monitoring, EU geo-block + waitlist*
*v4: Wyoming Series LLC → Oregon LLC after legal structure analysis (see Legal section)*
*See [[Projects/AutoBiz/State]] · [[Projects/AutoBiz/Tasks]]*
