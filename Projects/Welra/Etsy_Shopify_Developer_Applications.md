---
title: Etsy + Shopify Developer Applications — Step-by-Step
project: Welra
type: guide
updated: 2026-06-10
tags: [welra, etsy, shopify, integrations, applications]
---

# Etsy + Shopify Developer Applications — Step-by-Step

> ⚠️ **2026-06-10 UPDATE: the Etsy application using this doc's copy-paste pack was DENIED.** The pack's "AI-written… multi-channel" description trips Etsy's prohibited-use pattern matching. For Etsy, this doc is superseded by [[Projects/Welra/Etsy_API_Approval_Strategy]] — use that application copy instead. The Shopify section below remains valid (Shopify approved).

Both are free. Submit both **today** — approval reviews are the long pole (weeks), and nothing else on the critical path can shorten them. Each takes ~15–20 minutes.

Verified against current docs 2026-06-10: [Etsy Open API v3](https://developers.etsy.com/documentation/), [Etsy quick start](https://developers.etsy.com/documentation/tutorials/quickstart/), [Shopify protected customer data](https://shopify.dev/docs/apps/launch/protected-customer-data), [Shopify access scopes](https://shopify.dev/docs/api/usage/access-scopes).

## Copy-paste pack (used by both forms)

| Field | Value |
|---|---|
| App / company name | Welra (GR3NB LLC) |
| Website | https://www.welra.io |
| Support / contact email | ryan@welra.io |
| Privacy policy | https://www.welra.io/privacy |
| Terms of service | https://www.welra.io/terms |
| App description | "Welra sends multi-channel e-commerce sellers one AI-written weekly business report. We read shop order and listing data (read-only), aggregate it into weekly revenue, order, and product-level summaries, and email the seller a plain-English report every Monday. We never write to the shop, never store raw order data long-term, and never access buyer personal information — only aggregated totals." |
| Data we need | Orders (totals, dates, line items), listings/products, shop profile — **read-only** |
| Data we do NOT need | Buyer names, emails, addresses, payment details |

---

## 1. Etsy (etsy.com/developers) — ~15 min

**The good news (changes our plan):** new Etsy apps get **personal access immediately** — real production API access for **up to 5 shops** granted via OAuth. That is exactly beta size. We do NOT have to wait for commercial-access review to start the beta; we only need it to onboard shop #6+.

### Steps
1. Sign in to Etsy with the account you want to own the app (use ryan@welra.io; create an Etsy account on it if needed).
2. **Enable two-factor authentication** on the Etsy account first — registration requires it (Account Settings → Security).
3. Go to **https://www.etsy.com/developers/register** and create a new app.
4. Fill the form with the copy-paste pack above. For "What will your app do?", use the app description verbatim.
5. If asked for a callback/redirect URL, enter: `https://www.welra.io/dashboard/integrations/etsy/callback` (we can change it later — don't let this field block submission).
6. Submit. You immediately receive an **API keystring + shared secret** under "Your Apps".
7. **Send the keystring + shared secret to Claude** (paste in chat or drop in `apps/api/.env` as `ETSY_API_KEY` / `ETSY_SHARED_SECRET`). Claude builds the OAuth 2.0 + PKCE flow against the real key.
8. Same day, request **commercial access** from the app's page (needed for shop #6+; reviews take weeks, so start the clock now). Note: we will NOT request the `buyer_email` field — Welra doesn't use buyer PII, and saying so explicitly speeds review.

### Scopes we'll request in OAuth (read-only)
`transactions_r` (orders/receipts), `listings_r` (listings + stats), `shops_r` (shop profile).

---

## 2. Shopify (partners.shopify.com) — ~20 min

### Steps
1. Go to **https://partners.shopify.com** → "Join now" → create a Partner account.
   - Business name: **GR3NB LLC**, DBA Welra · Business email: ryan@welra.io · Website: welra.io
   - Pick "Build apps" as the primary activity.
2. In the Partner Dashboard: **Apps → Create app**. If offered a choice, choose "Create app manually" (we're not using Shopify CLI templates — our backend is Fastify on Railway).
   - App name: **Welra**
   - App URL: `https://www.welra.io`
   - Allowed redirection URL: `https://welra-production.up.railway.app/integrations/shopify/callback`
3. This immediately gives us a **Client ID + Client secret** — send both to Claude (chat or `.env` as `SHOPIFY_CLIENT_ID` / `SHOPIFY_CLIENT_SECRET`).
4. **Protected customer data access (the actual review gate):** In the app's sidebar → **API access requests** (a.k.a. "API access"):
   - Request access to **Protected customer data**. Select ONLY what we need; for every customer PII field (name, email, address, phone) select **"not required"** — Welra aggregates order totals and products only. Minimal requests are approved much faster.
   - In the justification box, paste the app description from the pack, plus: "We only read order totals, dates, and line items from the last 14 days to compute weekly aggregates. We do not read, store, or display any customer personal fields."
   - We do **not** need the separate "Read all orders" (>60 days history) approval — weekly reports only look back 14 days, inside the default 60-day window. Skip it; it's the slowest review.
5. Distribution: leave the app **unlisted / custom distribution** for beta (no App Store review needed to install on beta shops). App Store listing review is a post-beta decision.

### Scopes we'll request in OAuth (read-only)
`read_orders`, `read_products`.

⚠️ Compliance note (new Partner terms effective 2026-02-27): merchant/customer data may not be used to train AI models. Welra sends per-customer data to the Claude API to *generate that customer's own report* (inference, not training — Anthropic API data isn't used for training), and our DPA already reflects this. Keep this wording handy if the review asks.

---

## After both are submitted

| What | Who | When |
|---|---|---|
| Paste Etsy keystring + secret, Shopify client ID + secret to Claude | Ryan | same day |
| Build Etsy OAuth flow + real fetcher (personal access, 5 beta shops) | Claude | as soon as keys arrive |
| Build Shopify OAuth flow + real fetcher | Claude | as soon as keys arrive |
| Etsy commercial access approval (shop #6+) | Etsy | ~4–8 weeks |
| Shopify protected-data approval | Shopify | days–weeks (minimal request) |

Until keys arrive, beta users onboard via [[Projects/Welra/State|CSV upload or WooCommerce]] — both live as of 2026-06-10.

Related: [[Projects/Welra/Tasks]] · [[Projects/Welra/Privacy_Audit_2026-06-10]] · [[Projects/Welra/Marketing_Campaign_2026-06]]
