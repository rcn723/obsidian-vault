---
title: Integration Roadmap — every connection option, evaluated
project: Welra
type: reference
updated: 2026-07-02
tags: [welra, integrations, api-approvals, roadmap]
---

# Integration Roadmap — every connection option, evaluated

Full review run 2026-07-02 after Etsy went live end-to-end. Companion docs: [[Knowledge_Base/Platform_App_Review_Runbook]] (the traps), [[Projects/Welra/Etsy_API_Approval_Strategy]] (the application playbook that won), [[Projects/Welra/Meta_App_Review_Plan]].

## Where every platform stands today

| Platform | Code | Connect UX today | One-click gate | Verdict |
|---|---|---|---|---|
| **Etsy** | ✅ live | One-click OAuth, proven | — | **DONE 2026-07-02** |
| **Printify** | ✅ live | Guided token paste | Printify has NO OAuth (personal tokens only) | Already at ceiling — paste IS the flow |
| **CSV** | ✅ live | Upload | Manual by design | Done |
| **WooCommerce** | ✅ built | Manual keys (works) + one-click wc-auth behind `NEXT_PUBLIC_WOO_ONECLICK` | Our own smoke-test rule — NO external approval | **Fastest win.** Flip when first Woo store appears (beta user or throwaway test store) |
| **Shopify** | ✅ built | OAuth built, not offerable | Shopify Partner app + protected-customer-data approval | Submit pack below when a Shopify prospect exists (or front-load) |
| **Instagram** | ✅ built | Manual token (works, beta) | Meta App Review for the 4 read scopes | Heaviest review — [[Projects/Welra/Meta_App_Review_Plan]] is current; queue last |
| **TikTok** | ✅ built | Nothing offerable | Fresh app approval | **Pack below — fresh Welra-identity app.** R&R-linked app declined again 2026-07-02 (strike 2-of-3 territory; runbook 3-strike rule applies) |
| **Stripe** | ❌ stub | — | Engineering (fetcher + Stripe Connect OAuth) | Defer until a customer asks |
| **Gumroad** | ❌ none | — | Engineering (simple OAuth + sales API) | Backlog |
| **Google Sheets** | ❌ none | — | Engineering + Google OAuth verification (weeks) | Backlog — CSV covers the need |
| **Make webhook** | ❌ none | — | Engineering | Backlog |

## Gap analysis — platforms we DON'T list yet

Evaluated against the target seller (small multi-channel maker: Etsy/POD/social + maybe own site + in-person):

| Candidate | Why it matters | API reality | Verdict |
|---|---|---|---|
| **Square** | Huge among makers who sell at markets/fairs — the in-person leg nothing else covers | Clean OAuth, Orders/Payments read, no heavy review | **Top new-platform candidate.** Build when an in-person seller shows up |
| **Squarespace Commerce** | Common "own site" for makers | API-KEY PASTE (like Printify) — Commerce Orders read with a key the seller copies | **Cheapest possible add** (no review at all). Second candidate |
| **eBay** | Big secondary channel for vintage/resellers | OAuth, moderate review | Backlog — add if 2+ prospects ask |
| **Amazon Handmade** | Some overlap | SP-API vetting is HEAVY (business verification, months) | Skip for now — not worth it pre-revenue |
| **Wix eCommerce** | Own-site alternative | OAuth app review | Backlog behind Squarespace |
| **Big Cartel** | Indie artists | Tiny API, basic | Backlog — niche |
| **Pinterest** | Marketing signal like IG/TikTok | OAuth + review | Backlog — social slot is full with IG+TikTok |
| **PayPal / Ko-fi / Faire** | Payments/tips/wholesale edges | Various | Not core to the weekly-report story yet |

**Conclusion: we are not missing anything urgent.** The current lineup covers the beta target. Square and Squarespace are the only two worth adding this quarter, and only when a matching prospect appears — every speculative build steals time from landing beta user #1.

## TikTok application pack — fresh app, Welra identity (READY TO EXECUTE)

**Decision (2026-07-02): YES to Ryan's question** — do NOT resubmit anything connected to R&R. Fresh TikTok developer account under the Welra identity (ryan@welra.io), fresh app. This is the runbook's 3-strike rule AND the exact play that won Etsy round 2 (fresh Welra-identity app after R&R-linked failures). The R&R dev account now has 2+ declines; touching it again risks the manual-review flag.

**Ryan does (Claude can't create accounts):**
1. Create a TikTok account with **ryan@welra.io** (if none exists) — do this on a normal browser session, no VPN games (runbook: dodging linkage reads as ban evasion; Welra stands on its own merits).
2. Register at **developers.tiktok.com** with that login.
3. Create app with the fields below, submit, then tell Claude — I'll set the Railway env vars the moment you have client key + secret.

**App fields (verbatim):**
- **App name:** `Welra`
- **App icon:** the welra.io logo — SAME image as the site favicon/header (runbook: reviewers check icon-vs-website match; welra.io already passes)
- **Category:** Business / Analytics
- **Website URL:** `https://welra.io` (the SaaS with a real login entry point — welra.io/login — NOT any brand page)
- **Terms & Privacy:** `https://welra.io/terms`, `https://welra.io/privacy`
- **Products:** **Login Kit ONLY.** No Content Posting API. No Display API.
- **Scopes:** `user.info.basic`, `user.info.profile`, `user.info.stats`
- **Redirect URI:** `https://api.welra.io/integrations/tiktok/callback` (route is live; add the Railway host `https://welra-production.up.railway.app/integrations/tiktok/callback` as a second URI if the form allows — Etsy lesson: register every host you might send)

**Apply-reason text (adapt freely, keep every claim true):**
> Welra (welra.io) is a weekly business-report service for small e-commerce sellers. Sellers sign in at welra.io/login and connect the platforms they sell and market on (Etsy, Shopify, WooCommerce, Instagram). Many of our sellers use TikTok to market their products, so we request Login Kit with read-only scopes (user.info.basic, user.info.profile, user.info.stats) so each seller can authorize their OWN TikTok account and see their follower, like, and video counts inside their own weekly report, alongside their shop data. Data is shown only to the account owner, is never published, shared, or displayed to anyone else, and we do not post, upload, or manage content — we request no posting or content scopes. Test login for review: [Ryan adds a working welra.io test account + steps].

**Pre-submission checklist (all from real rejections):**
- [ ] welra.io/login works logged-out (login entry point — 2026-06-24 rejection reason)
- [ ] App icon = site favicon = site header logo (2026-06-19 rejection reason)
- [ ] Zero "AI" language anywhere reviewer-visible (Etsy lesson; welra.io is already de-AI'd)
- [ ] Working test login included in apply reason
- [ ] Nothing references R&R, rustandrainbow, or content posting

## Shopify Partner pack (ready when a Shopify prospect appears)

1. Ryan creates a Shopify Partners account (partners.shopify.com) as Welra / GR3NB LLC, ryan@welra.io.
2. Create app: name `Welra`, App URL `https://welra.io`, redirect `https://api.welra.io/integrations/shopify/callback` (+ Railway host as second).
3. Request scopes `read_orders`, `read_products` — matches SHOPIFY_SCOPES in code exactly (least privilege).
4. Protected customer data form (required for read_orders): purpose = "weekly order/revenue summaries shown only to the store owner"; we store order totals/timestamps/line items, NO customer names/emails/addresses (true: the fetcher aggregates); data encrypted at rest (true: token encryption + Supabase); no sharing/selling.
5. Claude sets SHOPIFY_CLIENT_ID/SECRET/REDIRECT_URI in Railway, smoke-tests against the dev store Partners gives us, THEN flips readiness — the dev store means we can prove this one BEFORE a customer touches it.

## Priority order (what actually happens next)

1. **[Ryan, ~30 min] TikTok pack above** — his call to front-load; everything is ready.
2. **[both] WooCommerce** — first Woo prospect (or Ryan says "build a test store" and Claude does it) → smoke → flag on → live.
3. **[Ryan+Claude] Shopify Partner app** — can front-load since Partners gives a free dev store to test against.
4. **[queue] Meta App Review** — per [[Projects/Welra/Meta_App_Review_Plan]]; heaviest, manual-token path already works meanwhile.
5. **[watchlist] Square, Squarespace** — build on first matching prospect, not before.

**The rule that keeps this honest: no speculative approvals-chasing while beta user #1 is unlanded.** Approvals are cheap to prep (done — this doc) and expensive to iterate; spend the iteration loops only where a real prospect is waiting.
