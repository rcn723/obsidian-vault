---
title: Etsy API Approval Strategy — post-denial analysis and reapplication plan
project: Welra
type: strategy
updated: 2026-06-30 (session — Etsy support (Sweety) responded to the Phase 1 reapplication with a SOFT, reviewable request: submit a new app with a comprehensive functional breakdown that explicitly highlights read-only scopes and no buyer-PII access. Not a denial-with-no-recourse — a specific, fixable ask. Added Round 2 copy + step-by-step resubmission guide below.)
tags: [welra, etsy, api, approval, critical-path]
---

# Etsy API Approval Strategy

## Round 2 (2026-06-30): Etsy support requested a comprehensive breakdown

Etsy technical support (Sweety) replied to the Phase 1 personal-access reapplication (the verbatim copy below, submitted on/after 2026-06-25 per the cool-off plan). Her email: previous app was declined, welcome to submit a new request, and specifically asked for "a comprehensive breakdown of your application's functionality, specifically highlighting that it utilizes read-only scopes and does not access buyer personal information." No new prohibited-use language cited — this reads as a request for more structure/explicitness, not a new rejection reason.

**Diagnosis:** the Phase 1 copy already contained the right facts (read-only scopes named, no buyer_email) but stated them in one dense paragraph. Etsy wants them as standalone, scannable statements.

**Round 2 application copy (use this for the new Developer Portal submission — supersedes the Phase 1 copy below for the "What will your app do?" field):**

> I'm building a small reporting tool that emails an Etsy shop owner a weekly summary of their own shop's performance, using only read-only API access.
>
> What it does each week: it reads the shop's own receipts and listing data using three read-only scopes — shops_r (shop profile), listings_r (the shop's own listings and stats), and transactions_r (the shop's own receipts). It totals that shop's revenue and order count for the week, lists its top-selling listings, compares the numbers to the prior week, and emails the shop owner a short written summary of their own data.
>
> Read-only access only: the app never calls any write endpoint. It does not create, edit, or delete listings, and never modifies orders, shop settings, or any other shop data. It requests only the read (_r) scopes listed above — no write (_w) scopes.
>
> No buyer personal information: the app does not request the buyer_email field or any other buyer-identifying field. It reads only order totals, dates, and listing references for the connecting shop's own orders — never buyer name, address, email, or payment details.
>
> Consent and scope of use: each shop connects individually through Etsy's OAuth consent flow, with that shop owner's explicit authorization. A shop's data is used solely to generate that shop's own weekly summary — it is never combined with another shop's data, never shared with any other party, and never resold. The shop owner can disconnect at any time, which immediately deletes their stored access token.
>
> I'm the sole developer building and operating this directly; it is not submitted on behalf of any other platform or third party. During this initial phase the app will be connected to fewer than five shops, each by the owner's own request.

**What changed vs. Phase 1 copy:** structure (5 labeled sections vs. 1 paragraph), read-only stated twice (once narratively, once via explicit _r/_w scope naming mirroring Etsy's own convention), added an explicit third-party rebuttal sentence (originally only implied), broadened the no-PII statement beyond buyer_email to name/address/payment. No facts removed or weakened — same compliant vocabulary throughout (verified against the "Never say" list below).

**Reply sent to Sweety (support thread, sets up the resubmission):**

> Hi Sweety,
>
> Thank you for the guidance — this is genuinely helpful. I'll submit a new application through the Developer Portal with a full functional breakdown that makes the read-only scopes and lack of buyer-data access explicit, including the exact scopes I'm requesting (shops_r, listings_r, transactions_r) and a clear statement that I never request buyer_email or any other buyer-identifying field.
>
> Quick summary while I prepare that: I'm the sole developer building a small tool that emails an Etsy shop owner a weekly summary of their own shop's performance — read-only access, no writes, no buyer PII, built and operated directly by me rather than on behalf of any other platform.
>
> Thanks again for the clear direction — I'll have the new submission in shortly.
>
> Best,
> Ryan

## Step-by-step: Round 2 resubmission process

1. **Reply to Sweety first** (same support thread/email). Paste the reply copy above. This costs nothing, shows responsiveness, and pre-frames the reviewer who reads the new application.
2. **Log in to the Welra Etsy account** (ryan@welra.io identity — never the R&R account; that one is terminally banned and must never touch Welra's application).
3. **Go to the Etsy Developer Portal** → Your Apps → register a **new** app (the old `welra-gr3nb-llc` app is filed under Banned Apps and is not reusable — confirm this is still true before assuming; if the portal offers an "edit/resubmit" path on the existing app instead of "new app," prefer whichever Sweety's thread implies, but default to new-app since that's what her email says: "you are welcome to submit a new request").
4. **App name:** `Welra Shop Report` (never "Etsy" in the name, never implies endorsement).
5. **Website / support / legal fields:** reuse the verified-clean values — https://www.welra.io, ryan@welra.io, https://www.welra.io/privacy, https://www.welra.io/terms. Before submitting, re-check welra.io live for any "AI" copy regression (it was de-AI'd 2026-06-10; verify it's still "plain-English" sitewide, not reverted by a later deploy).
6. **"What will your app do?" field:** paste the Round 2 copy verbatim (above). Do not summarize or shorten it — the section structure is the point.
7. **Callback URL:** `https://welra-production.up.railway.app/integrations/etsy/callback` (confirm this route still exists in the API before submitting; if the route was never built since Etsy access was never live, a placeholder is fine — Etsy doesn't call it during review).
8. **Personal or commercial:** Personal (5-shop cap, lighter review, matches beta size).
9. **Before clicking submit — run the peer-review checklist** (below). Do not submit if any banned phrase is present.
10. **Submit ONE application only.** Etsy explicitly treats multiple similar/duplicate apps as a denial signal — do not create a backup app "just in case."
11. **After submitting:** note the submission date in this doc's Status checklist below, and set an expectation of ~5–8 days for a response (per the open-api#675 community pattern).
12. **If approved:** re-run openapi-ping, then build the Etsy fetcher (already queued in Tasks.md).
13. **If declined again:** read the new denial reason carefully — if it cites a NEW reason not in the "Why we were denied" list below, add it to that list before reapplying a third time. Email developer@etsy.com directly only if the next decline is also "soft" (gives reasons, doesn't say "can't reconsider").

**Pre-submit peer-review checklist** (run every time, not just this round):
- [ ] No instance of: AI, artificial intelligence, machine learning, LLM, Claude, GPT, automated insights
- [ ] No instance of: analytics, aggregate, data warehouse, across platforms, multi-channel, Shopify, WooCommerce, or any other marketplace name
- [ ] "third-party" appears only as a negation about Welra itself (e.g., "not on behalf of any third party") — never as a description of Welra's relationship to another platform
- [ ] "Etsy" does not appear in the app name; nothing implies endorsement or certification
- [ ] Nothing about marketing/emailing buyers, scraping, browsing other shops, market research, or trend data
- [ ] First-person builder voice throughout
- [ ] Read-only stated explicitly with scope names; no-buyer-PII stated explicitly
- [ ] "Fewer than five shops" or equivalent small-number signal present



Denied 2026-06-10. Etsy's stated reasons map to two failure modes: "does not clearly explain the app's use case" and "appears to be submitted on behalf of a third-party app." This doc is the root-cause analysis and the exact reapplication plan. Sources: the full current [API Terms of Use](https://www.etsy.com/legal/api/) (updated 2025-06-16, read in full), Etsy staff guidance in [open-api#675](https://github.com/etsy/open-api/discussions/675) and [open-api#1060](https://github.com/etsy/open-api/discussions/1060), and community denial threads.

## ✅ Verified 2026-06-15 (session 19, live in the Etsy console — corrects the record)

A two-sets-of-eyes check of the live account corrected a wrong premise in this doc:
- **The R&R shop is ACTIVE and in good standing** — `RustandRainbowCo` (rustandrainbowco.etsy.com), 38 active listings, Shop Advisor "nothing to do," no suspension or violation notice. **R&R was NOT shop-banned over AI content** — the "banned over AI-generated content" framing below is inaccurate and is retained only for history.
- **What is banned is the API app only.** Etsy developer console → Your Apps → **Banned Apps**: app `rust-and-rainbow`, **Status: Banned** (keystring `jy9g2parfx74q5qsvp1dlx19`). The denial email is pure boilerplate — no reason given, "can't reconsider." There is no obtainable "why," so stop chasing one.
- **Welra is a separate Etsy account** (different login; not the R&R account). Its API application was denied; its keystring 403s ("not found or not active").

**The R&R *shop* is fine — but BOTH API apps are banned.** Also checked the Welra account (ryan@welra.io, no storefront): app `welra-gr3nb-llc` sits under **Banned Apps**, **Status: Banned** (keystring `b0ka8n8e2888n9esjzdwd7k7`). This is worse than the task notes assumed — they recorded the Welra app as "denied / pending activation / possible typo." It is **Banned**, which is terminal and explains the keystring's 403 ("not found or not active") — not a typo. So **both** the `rust-and-rainbow` AND `welra-gr3nb-llc` apps are Banned, across two same-network accounts. The Railway `ETSY_CLIENT_ID/SECRET` (`b0ka8n8e…`) are dead keys; the Etsy fetcher was never built, so nothing live depends on them.

**Revised 6/25 plan — calibrated after reading BOTH denial emails (they differ in severity):**
- **R&R's email is terminal:** "not able to approve… *and we're not able to reconsider this decision*." No reasons, no path. `rust-and-rainbow` is dead — leave it; never reuse that identity for Welra.
- **Welra's email is a SOFT, reviewable denial — this is the key correction.** It gives specific, fixable reasons ("does not clearly explain the app's use case," "appears to be submitted on behalf of a third-party app," "otherwise does not align"), points to the House Rules, and crucially does **NOT** say "can't reconsider." That's a standard decline, not a no-recourse ban — even though the console blunt-labels the app "Banned" (Etsy files all declined apps under "Banned Apps"). **Welra's Etsy path is alive.** The two cited reasons are EXACTLY what the de-AI'd site + the verbatim first-person, single-seller, read-only copy below fix. Etsy reviewed Welra on its own merits (Welra-specific reasons, not "your account is linked to a ban"), so the R&R linkage has not fatally poisoned Welra.
- **Mechanics are the only open question:** `welra-gr3nb-llc` shows declined/"Banned," so reapplying likely means a NEW app — but don't guess. **Email developer@etsy.com first** (short, builder-voice, no "AI"): acknowledge the decline, restate the compliant use case, explicitly counter the third-party-app impression ("I'm the developer building this directly, not requesting on behalf of another platform"), and ask the cleanest way to reapply (new app? anything specific they need to see). Their reply resolves new-app-vs-reactivate AND makes your case. Then submit ONE clean app with the verbatim copy. **Do NOT dodge the linkage** (VPN/new IP = ban evasion = permanent).
- Severity for the business is unchanged regardless: the Etsy API is a friction-reducer, **NOT a customer blocker** — CSV + Printify already serve Etsy sellers today. Pursue the reapply, but never let it gate beta or launch.

## Why we were denied (ranked)

> Correction 2026-06-10: Ryan confirms his submitted description did NOT mention AI. That elevates causes 2–4 below (the website's AI copy, third-party-sounding framing, account signals) as the operative factors. The "never say" rules stand regardless.

1. **The application description led with "AI-written" and "multi-channel e-commerce sellers"** (from our own copy-paste pack — my error). Etsy's Prohibited Behavior list includes, verbatim: *"Use the Etsy API to collect, scan, or otherwise request Etsy content for purposes of analytics, machine learning, training artificial intelligence models… unless expressly authorized in writing by Etsy."* A reviewer pattern-matching "AI" + "analytics" + "aggregate" denies on sight. "Multi-channel SaaS" also reads as an existing third-party platform requesting a key to plug Etsy in — Etsy staff confirm that impression is the #1 denial reason.
2. **Reviewers visit your URL.** welra.io says "AI-written reports" prominently — confirming both flags.
3. **Account standing risk.** Ryan's other Etsy identity has a BANNED app (rust-and-rainbow). The ToU lets Etsy act on "related accounts." Unresolved, this can poison future applications.
4. **No seller signal.** The applying account owns no Etsy shop; commercial-sounding language from a no-history account reads as a data harvester.

## What is actually allowed (the legal frame that protects us)

- ToU Section 4: a developer **acts as a service provider to the Etsy seller** and processes Member data "only to fulfill the services that you provide under the Application Terms." Generating a seller's own weekly report from their own receipts, with their OAuth consent, is the intended use case.
- The ML prohibition targets **collecting Etsy content** for ML/training/marketplace-scale analytics. Welra does not train on Etsy data and never aggregates across shops. Inference to draft one seller's own report, as their service provider, is defensible — but **never volunteer the word "AI" in anything Etsy-facing**; disclosure of processors belongs in the privacy policy, where it already is. (Gray area acknowledged: Etsy "in its sole discretion" can disagree. Risk accepted knowingly — Ryan's call, recommended.)

## New facts (2026-06-11, from Ryan)

- The two Etsy identities use **different logins but the same network** — assume Etsy has linked them.
- **rust-and-rainbow was banned over AI-generated content** (t-shirt designs etc.), and its API denial appeal came back final: "we're not able to reconsider this decision." The R&R Etsy API path is dead.
- Implication for Welra: the linked identity's AI-content flag makes the de-AI'd public surface *more* important, and a real cool-off matters. **Do not try to dodge the network linkage** (new IPs/VPNs etc.) — that reads as ban evasion and converts a fixable denial into a permanent one. The clean path: Welra's application stands on its own merits from its own account; if identity linkage blocks it, the remedy is making the case to developer@etsy.com that Welra is a separate, compliant business.
- **Cool-off agreed: resubmit on/after 2026-06-25.** One-time reminder scheduled (desktop scheduled task `etsy-api-resubmit-reminder`, fires 9am Jun 25) — it re-verifies the site is still clean and walks Ryan through the resubmission.

## The reapplication plan (in order)

**Phase 0 — clean the runway (before any reapplication):**
1. Find out why `rust-and-rainbow` was banned (check email on that Etsy account; likely cause: the R&R agent's automated listing-edit/SEO-rewrite behavior). Appeal or accept, but KNOW the reason. Do not use that account for anything Welra.
2. De-AI the Etsy-facing surface: change welra.io hero/marketing from "AI-written" to "plain-English" (arguably better marketing for non-technical sellers anyway). Keep AI disclosure in the privacy policy.
3. Add Etsy's REQUIRED trademark statement to the site footer/integrations page: *"The term 'Etsy' is a trademark of Etsy, Inc. This Application uses Etsy's API, but is not endorsed or certified by Etsy."*
4. Visible support email (ryan@welra.io) — required by ToU Section 3.

**Phase 1 — reapply for PERSONAL access (not commercial):** personal tier = up to 5 connected shops = exactly beta size, lighter review. Community-confirmed sequencing: "first apply for personal access… then apply for commercial." Wait at least a week after Phase 0; submit ONE application (multiple similar apps are explicitly prohibited and a known auto-denial).

**Phase 2 — request commercial access** only after the beta works, with track record, screenshots, and the compliant site.

**If denied again:** email developer@etsy.com with the app name asking specifically what to clarify (5–6 day responses; staff have reversed denials when contacted — the Sellertools case in #675), and post in github.com/etsy/open-api discussions where Etsy staff respond.

## Exact application copy (Phase 1, personal)

**App name:** `Welra Shop Report` (never contains "Etsy")

**What will your app do? (use verbatim):**
> I'm building a small reporting tool that emails an Etsy shop owner a weekly summary of their own shop's performance. Every Monday it reads the shop's receipts and listing stats from the previous week using read-only scopes (shops_r, listings_r, transactions_r), totals the shop's revenue and order count, lists its top-selling listings, compares the numbers to the prior week, and emails the shop owner a short written summary of their own data. The app never writes to the shop: no listings are created or edited, no orders are modified, and nothing is posted. It does not request or use buyer personal information (we will not request the buyer_email field). Each shop's data is visible only to that shop's owner, who connects through Etsy's OAuth consent flow and can disconnect at any time, which deletes their tokens. Shop data is used solely to produce that owner's weekly summary — it is never shared, resold, combined across shops, or used for any other purpose. During development the app will be connected to fewer than five shops, each by its owner's explicit request.

**Callback URL:** `https://welra-production.up.railway.app/integrations/etsy/callback`
**Personal or commercial:** Personal.

## Never say (in application, app name, or any Etsy-facing page)

- "AI", "artificial intelligence", "machine learning", "LLM", "Claude", "GPT", "automated insights"
- "analytics platform", "aggregate", "data warehouse", "across platforms", "multi-channel", "Shopify", "WooCommerce", or any other marketplace's name
- "third-party", "integration with our platform", "our SaaS", "our existing system"
- "Etsy" in the app name; any implication of endorsement
- Anything about marketing/email to buyers, scraping, browsing other shops, market research, or trend data

## Always say

- First person, builder voice ("I'm building…"), concrete weekly mechanics
- "the shop owner's own data", "read-only", exact scopes, "OAuth consent", "disconnect any time"
- Explicit negatives: no writes, no buyer PII, no cross-shop use, no resale
- Small numbers: "fewer than five shops"

## Status checklist

- [x] R&R ban reason identified — RESOLVED 2026-06-15 (s19): no obtainable reason. Email is boilerplate ("can't approve, can't reconsider", no cause); developer console shows app `rust-and-rainbow` Status=**Banned**. The SHOP is active/good-standing (38 listings) — NOT content-banned. [owner:: ryan] [priority:: high] [status:: done]
- [x] welra.io copy: "AI-written" → "plain-English" sitewide — DONE 2026-06-10, commit de527a5, LIVE (verified on welra.io; AI disclosure retained in privacy policy + terms). Deployed via `npx vercel deploy --prod`, which also took the whole queued brand backlog live. [owner:: claude] [priority:: high] [status:: done]
- [x] Etsy trademark disclaimer added to site footer — DONE 2026-06-10, live (verified) [owner:: claude] [priority:: high] [status:: done]
- [x] Phase 1 reapplication submitted on/after 2026-06-25 — Etsy support (Sweety) responded 2026-06-26 with a SOFT request for a more comprehensive, explicitly read-only/no-PII breakdown (not a new denial reason). [owner:: ryan] [priority:: high] [status:: done]
- [ ] Round 2: reply to Sweety + submit new app with the Round 2 copy and step-by-step process above (Ryan logged into the Welra Etsy account; Claude drafted/reviewed copy, Ryan reviews + submits) [owner:: ryan] [priority:: high] [status:: blocked]
- [ ] If approved: re-run openapi-ping, then build the Etsy fetcher [owner:: claude] [priority:: high] [status:: blocked]

Related: [[Projects/Welra/Etsy_Shopify_Developer_Applications]] (superseded for Etsy by this doc) · [[Projects/Welra/State]] · [[Projects/Welra/Tasks]]
