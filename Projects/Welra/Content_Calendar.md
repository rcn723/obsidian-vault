---
title: Welra Content Calendar
project: Welra
type: content-plan
updated: 2026-07-30
tags: [welra, blog, content, seo, marketing]
---

# Welra Content Calendar

A repeatable weekly blog engine for [[Projects/Welra/State|Welra]]. Audience: small,
multi-channel e-commerce sellers (Etsy, Shopify, WooCommerce, Printify) doing roughly
$1k–$50k/month. Voice: clear, first-person working seller — same as the launch
post. **Permanent rule: never lead with "AI"** in any title or copy. Pairs with the
press engine ([[Projects/Welra/Press_Playbook|Press Playbook]]); syndicate each post to
LinkedIn + Medium with a canonical link back to `welra.io/blog/…`.

Published so far:
- ✅ `market-analysis-small-business-advantage` — "The numbers were always there…" (launch post, 2026-06-14)
- ✅ `how-to-read-your-etsy-stats` — "How to actually read your Etsy Stats page" (Pillar E #15, 2026-06-14)
- ✅ `weekly-shop-review-monday-habit` — "The 15-minute Monday review every seller should do" (Pillar C #8, 2026-06-23)
- ✅ `my-shops-first-welra-report` — "I ran Welra on my own $0 week..." (Pillar F founder/trust, 2026-07-01)
- ✅ `etsy-woocommerce-one-click` — "Etsy and WooCommerce are now one click..." (product milestone, 2026-07-03)
- ✅ `revenue-vs-profit-bestseller` — "Your bestseller might be lying to you: revenue vs. profit" (Pillar A #3, LIVE 2026-07-18)
- ✅ `printify-profit-margin-math` — "Print-on-demand math: what Printify's dashboard won't tell you" (Pillar B #6, LIVE 2026-07-24 — Ryan said "ship it" same day)
- ✅ `pricing-in-a-downturn` — "Raise, hold, or discount? What sellers are actually doing right now" (Pillar D #11, **STAGED not live**, weekly `welra-weekly-blog` task run 2026-07-30 — awaiting Ryan approval + deploy)

⚠️ **Gap found 2026-07-17:** this list had gone stale since 2026-06-14 — 3 real posts had shipped without ever being logged here, and the cadence itself had silently slipped to a 14-day gap (2026-07-03 → 2026-07-17) despite being planned as weekly. No scheduled task was actually enforcing "weekly." See the new `welra-weekly-blog` scheduled task (created 2026-07-17) — this file is now its source of truth for "what's next," so keep it current every time a post ships.

Reconciled 2026-07-24: cross-checked this list against the actual `posts` array in `posts.tsx` — the two agreed (6 posts, no drift) before this run added the 7th.

Reconciled 2026-07-30: cross-checked again before drafting — the 7 live posts matched `posts.tsx` exactly, no drift. This run added the 8th (`pricing-in-a-downturn`) as an uncommitted working-tree change only — not yet in `posts.tsx` on any committed branch until Ryan deploys.

## How to run it (cadence)

Rotate the six pillars so the blog never feels one-note. A good monthly mix:
1. one **Platform guide** (Pillar E) — these pull the most search traffic
2. one **Tough-economy tactic** (Pillar D) — most shareable
3. one **Read-your-numbers / habit** piece (Pillar A/B/C) — core positioning
4. one **Founder/trust** piece every ~4 weeks (Pillar F)

Each post: ~900–1,300 words, ≥2 cited stats where claims are made, one clear CTA to the
free report, internal-link to 1–2 prior posts.

---

## Pillar A — Read your own numbers (analytics for non-analysts)

| # | Working title | Angle / hook | Search intent |
|---|---|---|---|
| 1 | What actually matters in your weekly numbers (and what's just noise) | The 4–5 metrics a seller should watch; ignore the rest | ecommerce metrics that matter for small business |
| 2 | Conversion rate, explained without the jargon | What it is, what's "normal," how to nudge it | what is a good conversion rate etsy / shopify |
| 3 | ✅ Your bestseller might be lying to you: revenue vs. profit (published 2026-07-17, slug `revenue-vs-profit-bestseller`) | Why top-line sales hide thin margins | revenue vs profit ecommerce |
| 4 | Three numbers that warn you a product is dying | Early-decline signals before it's too late | signs a product is declining in sales |

## Pillar B — Multi-channel selling

| # | Working title | Angle / hook | Search intent |
|---|---|---|---|
| 5 | Selling on Etsy and Shopify at once: what to track on each | Each channel's job; don't read them the same way | selling on etsy and shopify at the same time |
| 6 | ✅ Print-on-demand math: what Printify's dashboard won't tell you (LIVE 2026-07-24, slug `printify-profit-margin-math`) | Calculating true POD margin after fees | printify profit margin tracking |
| 7 | When to add a new sales channel — and when it's a trap | A simple test before you spread yourself thin | should i sell on multiple platforms |

## Pillar C — The weekly operating habit

| # | Working title | Angle / hook | Search intent |
|---|---|---|---|
| 8 | The 15-minute Monday review every seller should do | A repeatable ritual, step by step | weekly business review for small business |
| 9 | Why you stopped checking your stats — and how to start again | The overwhelm problem, and a low-effort fix | ecommerce dashboard overwhelm |
| 10 | How to tell a good week from a lucky week | Trend vs. noise, in plain terms | how to tell if sales growth is real |

## Pillar D — Tough-economy tactics

| # | Working title | Angle / hook | Search intent |
|---|---|---|---|
| 11 | ✅ Pricing in a downturn: raise, hold, or discount? (STAGED 2026-07-30, slug `pricing-in-a-downturn`) | A decision framework, not a rule | ecommerce pricing strategy in a recession |
| 12 | Where your money quietly leaks: fees, shipping, ads | A 20-minute cost audit | hidden ecommerce costs eating profit |
| 13 | Repeat buyers are your recession insurance | Retention beats acquisition when budgets tighten | how to increase repeat customers small shop |
| 14 | Cash flow for sellers: reading the rhythm of your shop | Timing, not just totals | ecommerce cash flow management small business |

## Pillar E — Platform guides (search magnets)

| # | Working title | Angle / hook | Search intent |
|---|---|---|---|
| 15 | How to actually read your Etsy Stats page | Clear walkthrough of every tab | how to read etsy stats |
| 16 | Shopify Analytics: the 6 reports worth your time | Skip the 40 reports, use these | shopify analytics for beginners |
| 17 | WooCommerce reports without the headache | What to look at, where it lives | woocommerce sales reports guide |

## Pillar F — Founder / trust (monthly)

| # | Working title | Angle / hook |
|---|---|---|
| 18 | What I learned reading my own shop's numbers for a year | Honest story, lessons, a few mistakes |
| 19 | Why I built a report instead of another dashboard | The POV/manifesto behind Welra |

---

## Backlog ideas (unscheduled)

- "Seasonality without the spreadsheet: how to plan for your busy months"
- "Your reviews are data too — what 1-star and 5-star patterns tell you"
- "The one-product trap: when concentration is risk"
- "Ad spend sanity check: is that boost actually paying back?"
- "Returns and refunds: the metric most sellers never track"

See [[Projects/Welra/Tasks|Welra Tasks]] for what's queued. When a topic is drafted,
move it to "Published so far" with its slug + date.
