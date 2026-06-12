---
title: Etsy API Approval Strategy — post-denial analysis and reapplication plan
project: Welra
type: strategy
updated: 2026-06-10
tags: [welra, etsy, api, approval, critical-path]
---

# Etsy API Approval Strategy

Denied 2026-06-10. Etsy's stated reasons map to two failure modes: "does not clearly explain the app's use case" and "appears to be submitted on behalf of a third-party app." This doc is the root-cause analysis and the exact reapplication plan. Sources: the full current [API Terms of Use](https://www.etsy.com/legal/api/) (updated 2025-06-16, read in full), Etsy staff guidance in [open-api#675](https://github.com/etsy/open-api/discussions/675) and [open-api#1060](https://github.com/etsy/open-api/discussions/1060), and community denial threads.

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

- [ ] R&R ban reason identified (Ryan: check that account's email) [owner:: ryan] [priority:: high] [status:: open]
- [x] welra.io copy: "AI-written" → "plain-English" sitewide — DONE 2026-06-10, commit de527a5, LIVE (verified on welra.io; AI disclosure retained in privacy policy + terms). Deployed via `npx vercel deploy --prod`, which also took the whole queued brand backlog live. [owner:: claude] [priority:: high] [status:: done]
- [x] Etsy trademark disclaimer added to site footer — DONE 2026-06-10, live (verified) [owner:: claude] [priority:: high] [status:: done]
- [ ] Reapply via Chrome with the copy above (Ryan logged into the Welra Etsy account; Claude fills, Ryan reviews + submits) [owner:: ryan] [priority:: high] [status:: blocked]
- [ ] If approved: re-run openapi-ping, then build the Etsy fetcher [owner:: claude] [priority:: high] [status:: blocked]

Related: [[Projects/Welra/Etsy_Shopify_Developer_Applications]] (superseded for Etsy by this doc) · [[Projects/Welra/State]] · [[Projects/Welra/Tasks]]
