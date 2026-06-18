---
title: Welra Marketing Campaign — Beta Recruitment (June 2026)
project: Welra
type: plan
updated: 2026-06-11
tags: [welra, marketing, beta, growth]
---

# Welra Marketing Campaign — Beta + Launch Runway

**Budget: $0 now, ≤$150/mo after beta.** The product is pre-launch: the immediate marketing goal is not revenue — it's **3–5 beta sellers** giving weekly feedback, plus a waitlist warm for launch. Everything below is sequenced around that.

## Positioning (one line, use everywhere)

> **One clear report. Every platform. Every Monday.**
> Welra reads your Etsy / Shopify / WooCommerce numbers and emails you a clear weekly business report — what sold, what changed, what to do next. No dashboard to learn.
>
> ⚠️ Brand language rule (2026-06-10, after the Etsy API denial): **never lead with "AI" in marketing or platform-facing copy** — "clear" is the customer benefit; the AI is plumbing. Disclosure lives in the privacy policy. Canonical voice/style guide: [[Projects/Welra/Brand_Identity]]. See also [[Projects/Welra/Etsy_API_Approval_Strategy]].

Supporting hooks (rotate):
- "Stop spending Monday morning in 4 dashboards."
- "You already have the data. You're just missing the analyst."
- "$19/mo replaces the 2 hours you lose every Monday."

Target customer: sellers on 2–4 channels (Etsy + Shopify + Woo + Printify) doing $1k–$50k/mo, no analyst, no time.

## Phase 1 — Beta recruitment (now → ~July 1) · $0

The ask: *"I'll send you a free weekly report on your shop for 8 weeks. In exchange, 5 minutes of feedback per report."* (⚠️ dropped "AI" 2026-06-15 — violated the never-lead-with-AI brand rule; these communities have heavy AI-fatigue, "clear" lands better.) Onboarding today = CSV export upload (any platform, 2 min/week) or direct WooCommerce connect. Frame CSV as a feature: "no account connection needed — your data, your choice."

**Beta offer:** free Pro during beta → 50% off for 6 months at launch ("Founding Seller" pricing) + their feedback shapes the product. Ask Van Westendorp pricing questions in week 2 (already in [[Projects/Welra/Tasks]]).

### Channels, in priority order

1. **Reddit (highest ROI, strictest rules)** — r/EtsySellers (~200k), r/Etsy, r/woocommerce, r/ecommerce, r/shopify, r/smallbusiness.
   - **Do NOT cold-post a product link** — most of these subs ban self-promo and one removal can burn the account. Sequence: spend week 1 answering analytics/“how do I read my stats” questions genuinely (no links). Then post a "I built a thing, looking for 5 beta testers, brutal feedback wanted" in subs that explicitly allow it (r/EtsySellers has periodic promo threads; r/SideProject, r/indiebiz, r/alphaandbetausers, r/betatests are explicitly for this).
   - Post template (beta-tester subs): *"I built a tool that emails you one clear weekly report on your e-commerce shop (Etsy/Shopify/Woo). Looking for 5 sellers for a free 8-week beta — you upload a CSV or connect WooCommerce, I send you the report Monday morning, you tell me what's wrong with it. Not selling anything during beta."*
2. **Facebook groups** — "Etsy Sellers", "Handmade Sellers", "WooCommerce Help & Share" type groups (join 5–6, same give-first rule). Personal-voice post, no link until someone asks.
3. **Indie Hackers + X build-in-public** — Ryan's authentic lane as a solo founder. Weekly build-thread: what shipped, one real chart, one lesson. Slow burn; compounds toward launch. Post the beta ask once pinned to profile.
4. **Direct outreach (most reliable for 3–5 users)** — 20 personalized DMs/emails to sellers who *publicly complain about their stats* (search Reddit/X for "etsy stats confusing", "shopify analytics overwhelming"). Template: *"Saw your post about [specific thing]. I'm building exactly this — one weekly clear report. Want a free one based on your last month's CSV? Two minutes of your time, no signup needed."* — Note: a one-off sample report is a great hook AND a product demo we can generate manually.
5. **Etsy/Woo community forums** — Etsy Community forum + WooCommerce Slack/forums; same helpful-first approach.

### Weekly cadence (≤4 hrs/wk total)
- Mon: ship the beta users' reports; post 1 build-in-public update
- Tue–Thu: 30 min/day answering questions in 2 subreddits + 2 FB groups
- Fri: 5 direct outreach DMs; log responses below

### Metrics that matter (log weekly in this file)
| Week | Outreach sent | Replies | Beta signups | Reports delivered | 👍/👎 |
|---|---|---|---|---|---|
| 2026-06-15 | | | | | |

## Phase 2 — Launch runway (after beta validates report quality) · ≤$150/mo

1. **SEO content (the durable cheap channel)** — 2 posts/mo on welra.io, targeting long-tail queries the audience already types: "etsy stats explained", "shopify analytics for small sellers", "woocommerce revenue report", "etsy vs shopify sales tracking spreadsheet". Claude drafts, Ryan reviews. Each post ends with the sample-report CTA.
2. **Free tool as lead magnet** — "free weekly report from a CSV, no signup" single-use page. The product *is* the ad. (Build task for Claude, post-beta.)
3. **Product Hunt launch** — when Stripe goes live + 5 testimonials exist. Free, one shot, prep checklist 2 weeks ahead.
4. **Etsy-seller newsletter sponsorships** — small niche newsletters run $50–$150/slot; far cheaper per qualified reader than ads. Test ONE before any paid social.
5. **Paid social: not yet.** Meta/Reddit ads below ~$500/mo of spend rarely beat the above for a $19–129 SaaS. Revisit at 20+ paying customers.

## Phase 3 — Getting the word out (creative, ≤$150/mo) — added 2026-06-11

Ranked by expected ROI-per-dollar. The theme: **the product is the ad** — every play puts a real report (or a piece of one) in front of sellers.

1. **Free "Shop Radar Scan"** (build: 1 session) — public page: drop a CSV, get a one-off mini-report instantly, no signup. The single highest-leverage asset: it's a demo, a lead magnet, and the thing people link each other to in seller groups. Ends with "want this every Monday?" CTA. *Cost: $0 + ~$0.05/scan in tokens.*
2. **Shareable Week Cards** (build: small) — every report email ends with a brand-colored summary card ("▲ 12% week — Radar Score 78") the seller can post to their IG story/group chat. Opt-in, no sensitive numbers by default. Organic loop: sellers brag, peers ask what it is. *Cost: $0.*
3. **"Monday Radar" newsletter** — short weekly public email: one realistic shop's week analyzed in the report voice (anonymized/composite), one tactic, one trend. Doubles as the SEO content engine (each issue = a post on welra.io). Builds a list we own before launch. *Cost: $0 (Resend), Claude drafts.*
4. **Free Report Friday** — each week, one volunteer seller from Reddit/FB (public ask, their consent) gets a free report; publish the redacted analysis as content. Case study + community goodwill + recruiting in one. *Cost: $0.*
5. **Tool-comparison SEO pages** — "eRank vs Welra", "Metorik alternative", "Triple Whale for Etsy sellers" — competitor-brand searches are high-intent and cheap to rank for at this size. Honest comparisons (they do SEO/dashboards; we do the Monday narrative). *Cost: $0.*
6. **Niche creator partnerships** — 5–10 Etsy/ecommerce YouTubers & podcasters (10k–100k subs): free Growth account + 30% recurring affiliate. Micro-creators in this niche convert far better than ads. *Cost: rev share only.*
7. **"Dashboard Detox" challenge** — playful launch campaign: a week without opening your dashboards; Welra tells you if you missed anything. Hashtag + newsletter tie-in + PH launch hook. *Cost: $0.*
8. **Directory blitz** (launch week) — Product Hunt, BetaList, MicroLaunch, Uneed, SaaSHub, AlternativeTo (position against eRank/Metorik), IndieHackers launch post. One afternoon, compounding backlinks. *Cost: $0.*
9. **Radar Score as a public hook** (after G2 ships) — "What's your shop's Radar Score?" quiz-style entry point; score requires the free scan. *Cost: $0.*
10. **Beta-swag via R&R pipeline** — Ryan already has Printify: 20 "Monday person" mugs for founding sellers. Memorable, photographable, ~$8/unit. *Cost: ~$160 one-time, optional.*

Sequencing: #1 and #2 get built pre-launch (they need the credits + eval pass first — a bad free report is anti-marketing). #3–#5 start during beta. #6–#9 at launch. Measure everything in the weekly metrics table above.

## Phase 4 — Free press / earned media · $0 — added 2026-06-11

**The story we pitch (never "AI"):** the **anti-dashboard** angle. Sellers drown in four analytics dashboards; Welra is one clear email on Monday. Contrarian, timeless, and it sidesteps the AI-fatigue every journalist has. Backup angle: **founder-as-customer** — Ryan runs an actual Etsy/Printify shop (Rust & Rainbow) and built the report he wanted to receive. Authenticity beats novelty in seller media.

### Plays, ranked by effort-to-coverage

1. **Source-request services (start this week, 15 min × 2–3/wk).** HARO is dead — the working successors are **Qwoted**, **Featured.com**, **Help a B2B Writer**, and **SourceBottle**. Free profiles as "e-commerce seller & founder, Welra." Answer requests about small business, e-commerce trends, side hustles, Etsy/Shopify selling. Dual credibility (real seller + founder) makes answers land. Each pickup = a quote + backlink in small-biz press. Fold into the Friday cadence slot.
2. **Press kit page — welra.io/press (build: tiny, Claude).** One-paragraph clear boilerplate, founder bio + photo, logo/brand SVGs, sample-report screenshots, "what Welra is NOT" (not a dashboard). Journalists write what's frictionless. Prerequisite for every other play.
3. **Podcast guesting (1 pitch/wk — the highest-conversion press in this niche).** Target list: Etsy/handmade seller shows (Etsy Conversations, Brand Your Passion, How to Sell Your Stuff on Etsy), side-hustle shows (Side Hustle Nation), indie-SaaS shows (Indie Hackers pod, Software Social style). Pitch = founder-as-customer story + one concrete listener takeaway ("the 5 numbers that actually matter in your shop stats"). 10-show list, personalize each pitch, track in the metrics table.
4. **Original data stories (the strongest press magnet — compliance-checked).** ⚠️ Hard line: NEVER cross-shop customer data (Etsy compliance + our own privacy promises). Allowed sources: (a) **survey data** — run a "how many hours/week do you spend in seller dashboards?" survey via the same Reddit/FB groups + waitlist (n≥100 is pressable: *"Small sellers lose X hours a week to analytics dashboards"*), piggyback on the Van Westendorp questions already planned for beta week 2; (b) **own-shop experiments** — "I tracked 52 weeks of my own Etsy shop: what the stats actually predicted" using R&R's data; (c) public datasets. Each study = a welra.io post + direct pitches to **Practical Ecommerce, Handmade Seller Magazine, Craft Industry Alliance, eCommerceFuel, Modern Retail** + the survey communities themselves.
5. **BetaList now, launch-week press window later.** BetaList accepts pre-launch products (free tier) — do it during beta for early adopters + a backlink. At launch: Product Hunt (already Phase 3 #8) doubles as a press hook — niche newsletters trawl PH daily; the **free Shop Radar Scan** is the artifact reporters can try in 30 seconds, so the tool launch IS the press release.
6. **Local/regional business press at launch.** "Local founder launches service for online sellers" is an evergreen local-biz-journal story with near-zero competition. One email with the press kit. Also: any alumni/association newsletters Ryan belongs to.
7. **Newsjacking (opportunistic, 2–3×/yr).** When Etsy changes fees or Shopify earnings make news, publish a same-day clear "what this means for a $5k/mo shop" breakdown (Monday Radar issue) and offer expert comment via Qwoted on that topic. Reporters on deadline take the prepared source.

### Press rules (non-negotiable)
- **Never "AI-powered" in any pitch or quote** — clear/anti-dashboard is the story (and it's the better story).
- No Etsy affiliation implied; trademark disclaimer rules apply to any artwork journalists reuse.
- Customer data appears in stories ONLY with explicit written consent, redacted/composite otherwise.
- All press links point at welra.io/press or the free scan — never a signup wall.

### Sequencing
**Now (beta):** press kit page → Qwoted/Featured/SourceBottle profiles + 2 responses/wk → BetaList listing → podcast target list + 1 pitch/wk. **Pre-launch:** dashboard-hours survey runs alongside beta recruitment → data story drafted and held. **Launch week:** PH + Radar Scan pitch to the 5 niche pubs + local press + the data story drops the same week. **Ongoing:** newsjack windows as they come.

Time budget: ≤2 hrs/wk, folded into the existing Friday outreach slot. Track pickups in the metrics table (add a "press mentions" column at first pickup).

## What we will NOT do
- No paid ads in beta. No influencer payments. No cold mass-email (CAN-SPAM/deliverability risk on a domain that also sends product reports — protect welra.io sender reputation; outreach goes from a personal address).
- No EU targeting (geo-blocked by policy).

## Assets needed (tracked in Tasks.md)
- [x] Brand icon + color scheme → [[Projects/Welra/Brand_Identity]] (2026-06-10)
- [ ] One real sample report (PDF + web page) — **blocked on Anthropic credits**; this is also the single most important marketing asset
- [ ] Landing page: add "Founding Seller beta" banner + waitlist capture
- [ ] 4 social card images (Adobe/Canva, using brand colors)
- [x] welra.io/press page — LIVE 2026-06-11
- [x] Phase 4 scripts/steps for all of Ryan's deliverables → [[Projects/Welra/Press_Playbook]] (2026-06-11)
- [ ] Dashboard-hours survey Google Form (questions ready in the playbook; Ryan creates + distributes)
- [ ] Podcast targets verified-active + first pitch sent (list + script in the playbook)

## Ready-to-paste recruitment pack (session 19, 2026-06-15)

**Offer (use everywhere, identical):** Free Pro for an 8-week beta → 50% off 6 months at launch (Founding Seller). Onboarding = upload a CSV (~2 min/week) or connect WooCommerce. Ask in return: 5 minutes of honest feedback per weekly report. **Never say "AI"** — the benefit is a *clear* read on their shop. Lead with the founder-as-customer angle (Ryan runs a real Etsy/Printify shop).

### 0 — Where to find targets (the hunt recipe — added s20)
Reddit is blocked to Claude's crawler/extension, so this is a **manual 60-sec-per-target drill** you run logged in. Open these (each pre-sorted to *New* = this week's venting, not old threads):
1. `reddit.com/r/EtsySellers/search/?q=stats+views+no+sales&restrict_sr=1&sort=new`
2. `reddit.com/r/Etsy/search/?q=analytics+confusing&restrict_sr=1&sort=new`
3. `reddit.com/r/shopify/search/?q=analytics+overwhelming+numbers&restrict_sr=1&sort=new`
4. `reddit.com/r/woocommerce/search/?q=sales+report+track&restrict_sr=1&sort=new`

**Who to DM (filter):** posted in the last ~7 days · the OP is *venting or asking* (not answering) · the gripe is about *making sense of their numbers* (skip shipping/fees/bans) · they're not selling anything. Then paste template #3 below and change the one bracketed line to their specific frustration.

### 1 — Beta-tester sub / forum post (r/SideProject, r/alphaandbetausers, r/betatests, r/indiebiz)
**Title:** Looking for 5 e-commerce sellers to beta test a free weekly shop report

> I run a small Etsy/Printify shop and got tired of clicking through analytics tabs every week trying to work out what actually changed. So I built a tool that does it for me: every Monday it reads my shop's numbers and emails me one clear report — what sold, what changed vs last week, and what's worth doing next. No dashboard to learn.
>
> I'm looking for 5 sellers (Etsy, Shopify, or WooCommerce) to use it free for 8 weeks. You upload a CSV export once a week — about two minutes — or connect WooCommerce directly, and I send the report Monday morning. In return I'd love 5 minutes of brutal feedback per report: what's useful, what's wrong, what's missing.
>
> Not selling anything during the beta. If you stick with it you get 50% off for 6 months when I turn on paid plans. Comment or DM your platform and I'll set you up.

### 2 — Give-first comment (r/EtsySellers, r/shopify, FB groups — NO link, build rep for a week first)
When someone asks "how do I read my stats / which numbers matter":
> The five that actually move week to week: revenue vs last week, order count vs last week, your top 3 listings by sales, conversion rate (if your platform shows it), and repeat-customer count. The rest is mostly noise unless you're running a specific test. Write those five down every Monday — the trend matters far more than any single week.

Only mention Welra if someone directly asks what you use.

### 3 — Direct DM (highest yield — 5/week, to people who complained about their stats)
> Saw your post about [their specific frustration, e.g. "Etsy stats being all over the place"]. I'm building exactly this — a tool that emails you one clear weekly report on your shop instead of you digging through tabs. Want a free one based on your last month of sales? You export a CSV (2 min), I send back a real report, and you tell me if it's any good. No signup, not selling anything.

If yes → that one-off report is both the demo and the strongest recruiting tool. Generate it manually if needed (welra.io/scan or the report pipeline).

### 4 — Facebook group variant (personal voice, no link until asked)
> Quick one for the group — how much time do you lose each week trying to make sense of your shop's stats? I got fed up with it on my own shop and built something that emails me a clear weekly summary instead. Looking for a few sellers to try it free and tell me what's wrong with it — happy to share details if anyone's interested.

### This week's sprint (week of 2026-06-15, ≤4 hrs total)
- **Mon:** post #1 to r/SideProject + r/alphaandbetausers; one build-in-public note on X/IndieHackers if used.
- **Tue–Thu (30 min/day):** answer 2–3 stats questions in r/EtsySellers + 1 FB seller group with template #2. No links.
- **Fri:** send 5 DMs (template #3) to sellers complaining about stats; log replies in the metrics table above.
- **Target by next Mon:** 2–3 yeses → onboard the first seller end-to-end (then ping Claude to watch the first real report).

Related: [[Projects/Welra/State]] · [[Projects/Welra/Tasks]] · [[Projects/Welra/Etsy_Shopify_Developer_Applications]] · [[Projects/Welra/Strategy_Review_2026-06-09]]
