---
title: Selling-Platform Feasibility Matrix
project: Welra
type: analysis
updated: 2026-06-11
tags: [welra, integrations, feasibility, platforms]
---

# Selling-Platform Feasibility Matrix — 2026-06-11

Requested by Ryan (session 9): evaluate Printify, TikTok Shop, Instagram, Facebook, and other selling platforms; build what fits current boundaries. Boundaries applied: no app-review gauntlets during beta, token/OAuth flows shippable today, the no-AI-language rule for any platform-facing application (see [[Projects/Welra/Etsy_API_Approval_Strategy]]), privacy/compliance lines intact (policy updated BEFORE feature ships).

## Verdicts

| Platform | Verdict | Auth | Why / Notes |
|---|---|---|---|
| **Printify** | ✅ **BUILT 2026-06-11** | Personal access token (never expires) | No app review. Covers POD sales from every synced channel — incl. R&R's Etsy sales WITHOUT touching the Etsy API (it's the merchant's own data via their POD provider; Printify ToS, not Etsy's). Landing page already named it. |
| **Instagram** | ✅ **BUILT 2026-06-11** (engagement add-on) | Meta long-lived token (~60d) + IG business account ID | Instagram **Graph** API (Basic Display is dead since Dec 2024). Requires business/creator account linked to an FB page. R&R's NAS posting token qualifies. Reach/impressions need an extra scope and degrade to 0 gracefully. Token-health cron emails before the 60-day expiry. |
| **TikTok Shop** | ⏸ API deferred — **CSV works today** | Partner Center app + review | App registration + approval (weeks); approval-risk surface where the no-AI-language playbook applies; US TikTok regulatory situation adds churn. Order CSV exports parse via the existing generic detector now. Revisit post-beta; if pursued, write the application with [[Projects/Welra/Etsy_API_Approval_Strategy]] rules. |
| **Facebook (Shops/Marketplace)** | ❌ Not feasible as a sales API | — | Meta wound down Shops checkout + Commerce API access for ordinary apps; Marketplace has no seller API for individuals. Page-engagement metrics could later ride the same Meta token as Instagram (small lift, post-beta). |
| **Square** | 🔜 Strong next candidate | PAT (own account) / self-serve OAuth app | Orders API is clean; no review gauntlet for basic scopes. Good for craft-fair sellers (in-person payments). Build when a beta user asks. |
| **Gumroad** | 🔜 Easy next candidate | Personal token | Already in our DB platform CHECK. Simple sales API. Digital sellers niche. |
| **eBay / Amazon Handmade / Walmart** | ⏸ Application-gated | Developer programs w/ review | Multi-week approvals, compliance overhead. CSV in the interim. Revisit at G2+. |
| **Squarespace / Wix / Big Cartel** | ⏸ CSV for now | APIs exist but thin/niche | Order exports ride the generic CSV detector. Build native only on real beta demand. |

## What shipped (2026-06-11)

- **DB**: `printify`, `instagram` added to `integrations.platform` CHECK (migration applied to prod with Ryan's OK; schema.sql matches). Waitlist table found already live with RLS — task closed.
- **API**: `POST /integrations/{printify|instagram}/token` validates tokens against the platform before storing (Printify: resolves shop id/name/channel server-side from `shops.json`; Instagram: verifies account+token, defaults `token_expires_at` to +60d). Printify fetcher hardened: early-exit pagination (newest-first), cancelled/payment-not-received orders excluded — verified by fixture test (`apps/api/scripts/test-printify-fixture.ts`).
- **Web**: Printify + Instagram connect cards on `/dashboard/integrations`; CSV card now names TikTok Shop/Square; privacy page platform list + token wording updated.
- **Fix found by arch-review**: token-expiry emails linked to a never-built `/reconnect` route on the cert-less apex domain — now `WEB_URL/dashboard/integrations`. (Mattered now: Instagram is the first integration with real expiry.)

## Verify-on-first-connect (open)

- Printify `total_price` semantics for channel-synced shops — check against R&R's real account at first connect.
- Instagram fields with R&R's actual token scopes (instagram_basic expected present).

## Related

[[Projects/Welra/Continuation_Playbook]] · [[Projects/Welra/Tasks]] · [[Projects/Welra/Etsy_API_Approval_Strategy]] · [[Projects/Welra/Growth_Plan_2026-06]]
