---
title: To Antigravity
type: inbox
updated: 2026-06-17
tags: [handoff, welra, recruitment, session-21]
---

# To Antigravity — 2026-06-17 (session 21)

**Session 21 — live beta recruitment. No code changed, no deploys.** All work was outreach tooling + verified docs. Scoreboard unchanged: 0 beta users, 0 revenue, Stripe TEST. 4 DMs sent, no bites (statistically expected — not a signal).

- **Reddit query fix** ([[Projects/Welra/Tasks]] §A): Reddit's `t=` window only works with `sort=relevance`/`sort=top`, NOT `sort=new`; single-word queries beat phrases. §A rewritten + `/new`-browse approach + wider sub pool.
- **WooCommerce decision:** if ever built, use the built-in `/wc-auth/v1/authorize` redirect flow, NEVER a published plugin. Logged low-pri/deferred (not a customer gate).
- **Competitor CROtrustify = complementary, not a competitor** (Shopify-only storefront/CRO audit vs. Welra's real weekly sales report). Added §E DM objection-handler to Tasks; deferred a low-pri task to bake differentiation into the site + start `Competitive_Landscape.md`. Net: market validation.
- **NEW doc [[Projects/Welra/CSV_Export_Guide]]** — per-platform export steps verified against official docs (Etsy / Shopify / WooCommerce / generic). Linked from Tasks §D yes-path. Shopify gotcha: 51+/date-range exports are EMAILED, not downloaded.
- **New-account tax → channel pivot:** brand-new Reddit account is karma/age-gated (AutoMod removals + DM rate limit; forcing it = shadowban risk). Field note in [[Projects/Welra/Marketing_Campaign_2026-06]]; Focus Sheet restructured so **Reddit = warming-only 1–2 wks, Facebook groups + Indie Hackers = primary channels now.**
- **Facebook group shortlist (vetted live via Chrome):** Tier 1 Etsy — ⭐ Etsy Sellers Only (80K, private), Etsy Sellers and Beginners Community (77K), Etsy Sellers Group (173K); Tier 2 — Shopify for Beginners. Skip Buyers/Promotion/Marketplace/Dropshipping groups. Membership answers + 3 FB-voiced give-first comments saved to the Marketing doc.

**Open / next:** Ryan to (1) run the incognito shadowban check, (2) click Join on the 3 Etsy groups + Shopify for Beginners and answer membership Qs as a real seller, (3) comment give-first before posting anything, (4) start Meta Business Verification in parallel. The instant a seller bites → take their CSV (CSV_Export_Guide) → run the real pipeline → return a report same-day. Still undeployed from s20: Instagram demote + Graph v22 fix (working tree, build-clean). Do-not-touch: Meta submission, Etsy before 6/25, Stripe live mode.
