---
title: Brand & Comms Strategy — July 2026 refresh (Welra + Rust & Rainbow flywheel)
project: Welra
type: strategy
updated: 2026-07-06 (adversarially validated — 8 claims checked; 3 refutations incorporated. THEN revised per Ryan's redirect: Move 0 changed from Instagram-token connect to an Etsy favorites/view-delta fetcher enhancement, after live-testing proved R&R's IGAA token needs graph.instagram.com support Welra doesn't have, while Etsy is already connected with the right scope)
tags: [welra, rust-and-rainbow, brand, comms, growth, strategy]
---

# Brand & Comms Strategy — July 2026 refresh

> Requested by Ryan 2026-07-06 ("re-look at branding and comms, be creative/inventive, capture customers for Welra AND Rust & Rainbow"). Grounded against [[Projects/Welra/Growth_Pipeline]] (43 ideas, 3 killed — nothing below repeats a graveyard item) and **adversarially validated**: every load-bearing claim below was checked against the actual code, vault, and live site; refuted parts were corrected, and the build costs stated are the real ones.

## The strategic read

The pipeline has exhaustively mined *channels* (43 ideas). What it structurally can't produce — because it optimizes one idea per run — is a **brand-level move** and the **R&R↔Welra flywheel**. The core insight:

**Welra's weakness is proof. R&R's weakness is reach. Each is the other's fix.**
R&R has a real shop, real (currently $0) numbers, and an automated 3-platform posting pipeline. Welra has a shareable branded artifact (the Week Card — verified: generated unconditionally for every report, public durable URL at `api.welra.io/reports/:id/card.png`, public page at `welra.io/card/:id`) and an honest-numbers brand that *needs a living example*. Connect them and both problems shrink weekly, mostly automatically.

**Premise check (Ryan, confirm):** task 1's three warm-DM boxes are ticked in `_RYAN_TODO.md`, but no vault artifact records the sends. **If you actually sent them, say so** — Move 4's reply protocol activates on your confirmation, and it gets logged properly. If you ticked them ahead of sending, task 1 quietly reopens, no judgment.

---

## Move 0 — PREREQUISITE: surface Etsy favorites + view-deltas in the report (Ryan's call, 2026-07-06 — and it's the right one)

**The flywheel needs an honest rising metric.** With only revenue ($0) and orders (0) available, a weekly diary reduces to "$0 again" — no cliffhanger, and the temptation to invent a metric (the first draft's fabricated "63 views" line). Ryan's redirect fixes this at the source: **use Etsy, not Instagram, as the signal** — because Instagram's whole job is to drive people TO the Etsy shop, so Etsy favorites + listing views are the leading indicator of whether that funnel is working, with orders as the lagging one.

**Why this is the better Move 0 (all verified in code 2026-07-06):**
- **No token surgery.** R&R's Instagram token is an `IGAA…` Instagram-Login token that only answers on `graph.instagram.com`; Welra's IG fetcher/validation/refresh all use `graph.facebook.com` — so the "just paste it" plan was refuted, it's real fetcher work. Etsy avoids all of that: R&R's Etsy is ALREADY connected to Welra via Welra's own approved `welra-shop-report` app (unaffected by R&R's separately-banned developer app).
- **The scope is already granted.** Welra's Etsy fetcher (`integrations/etsy.ts`) already holds `listings_r`. The per-listing `/listings/active` endpoint returns cumulative `views` + `num_favorers` — R&R's own `agent.py` `get_etsy_listing_stats()` reads exactly these today. Welra's fetcher just doesn't request them yet.
- **The honest-metric caveat is solvable.** `etsy.ts`'s comment ("Etsy v3 has no weekly views/visits endpoint") is true for *shop-level weekly visits* but not for *per-listing cumulative views/favorites* — a week-over-week DELTA of those cumulative counts is a real, honest weekly signal (the exact technique agent.py already uses). Store cumulative counts, diff against last week, never zero-fill a missing week.

**The build (bounded, product-improving):** extend `etsy.ts` to page `/listings/active`, capture per-listing `views` + `num_favorers`, persist cumulative, and add `favoritesDelta` + `topListingViewDeltas` to `EtsyWeekData` + the report. This ships a real feature to **every** Etsy seller on Welra (favorites-and-views trend is a genuinely useful weekly line), with R&R as the first beneficiary. Claude-executable; arch-review + deploy-gate before ship.

**One thing to confirm (can't verify without live access):** that R&R's Etsy→Welra connection is currently returning data (token valid, refresh rotating). The integration row exists, but a row existing ≠ last report pulled data — verify via a fresh report or the Railway log, per the standing "delivered ≠ sent" discipline.

**Instagram stays a deferred alternative,** not dead: if R&R later wants engagement numbers too, Welra's fetcher can gain `graph.instagram.com` (Instagram-Login) support as a second host — a real change, correctly sequenced AFTER the Etsy signal is live and only if the diary proves it wants it.

## Move 1 — THE FLYWHEEL: "$0 to first sale, in public" (R&R Shop Diary)

**What:** Every Monday, R&R publicly posts its own real Welra Week Card with a short honest caption built ONLY from values present in that week's report (Etsy favorites, listing view-deltas, orders, revenue) and ending at the Etsy shop:
> *Shop diary, week 4: still $0 in sales — but 4 new people favorited a design this week and my Rainbow Vizsla listing picked up +18 views. Slow is still forward. Shop's in bio 🐾 #shopdiary #smallbusinesscheck #etsyseller*

### The caption engine (rotating templates — pick by what the week's real numbers did)
Every line uses ONLY values in that week's report; if a referenced metric is absent, the template that needs it is skipped (never invent one). All end pointing at the Etsy shop.
- **Views/favorites up, no sale (the common early episode):** *"Shop diary, week [N]: still $0 in sales — but +[favs] new favorites and +[views] views on my listings this week. People are looking. Shop in bio 🐾"*
- **Flat week (honest, not padded):** *"Shop diary, week [N]: quiet one. No sales, no new favorites. So this week I'm rewriting my three oldest listing titles to see if it moves views. Back next Monday with the numbers either way."*
- **Views up, favorites flat (a real insight):** *"Shop diary, week [N]: +[views] views but 0 new favorites — people are looking, not saving. This week's fix: a stronger first photo on my most-viewed listing. Shop in bio."*
- **First favorite on a new design (micro-milestone):** *"Shop diary, week [N]: someone favorited [design] for the first time. Tiny signal, but it's the first sign it's landing. Still no sale — we keep going."*
- **First sale (the ignition post — both brands run it):** *"Shop diary, week [N]: FIRST. SALE. [item] 🎉 I've posted these numbers at $0 every Monday for [N] weeks — this is the one where it moved. Thank you if you've been following along. Shop in bio."*
- **Reach/audience note (only if IG is ever connected — deferred):** left out until Move 0's deferred IG alternative ships; do not use follower counts until the data source is live.

**Why it's the highest-leverage move available:**
- **Transparency/shop-diary content is the strongest genre a tiny account can post** — algorithmic reach doesn't require followers the way product-art reach does, and "will this shop get its first sale?" is a serialized story with a real weekly episode.
- **Every episode is a Welra demo delivered as content, not a pitch** — the card carries Welra's brand; the caption credits welra.io naturally.
- **Fully compliant:** own shop, own data — the stated opposite of killed idea #40 (cross-shop teaser).
- **Graveyard lesson #20 engaged, not dodged:** "#20 X/Twitter build-in-public" was killed for founder-audience ≠ ICP-audience. The diary differs on both axes: the audience is *shop owners and small-biz transparency followers on IG/TikTok/Pinterest* (where the ICP actually is, unlike X), and the move's **primary payoff is R&R reach** — Welra acquisition is the passenger, not the driver. If it only ever grows R&R, it still paid for itself.
- **First-sale milestone, honestly framed:** when it happens, both brands post *the real report that recorded it* — an outcome celebration ("week 19: first sale. Here's the actual report."), never a predictive claim. (First draft said "the report saw it coming — views were climbing"; validation proved that's both a voice violation and literally impossible for R&R's data. Cut.)

**Build spec (verified 2026-07-06 — the pieces are now pinned down; sequenced AFTER the Etsy signal has ~1 week of data + Ryan's caption approval, because it can't be tested before then and it posts to a real account):**
- ✅ **The whole poster — BUILT + tested + staged 2026-07-07 (live post gated):** caption engine (`diary_caption.py`), the Welra `GET /diary/latest` endpoint + `metrics` column + per-report snapshot, and `run_diary.py` (pulls the endpoint, PNG→JPEG via Pillow, honest caption, `--dry-run` DEFAULT — never posts). arch-review 0 code blockers. Two pre-live-post items flagged (both in Welra Tasks): apply the `metrics` migration to prod BEFORE the API deploy (else reports break), and fix `weekN` (counts all delivered reports, would overstate the "$0 for N weeks" streak). Remaining for the live post: deploy the endpoint (migration first), set DIARY_SECRET/DIARY_CUSTOMER_ID, decide the public-JPEG host, one dry-run preview → Ryan approves → first post.
- **Posting path:** R&R's `META_ACCESS_TOKEN` is an `IGAA…` token that works on the existing `post_to_instagram` container/publish flow (R&R posts M/W/F with it today), but that function builds its own dog-art caption — write a thin `post_diary(image_url, caption)` reusing the container/publish steps with the diary caption. (Pinterest needs a design dict; TikTok has a 90-char title → short hook + description split. IG first.)
- **PNG→JPEG:** the Week Card is PNG; Instagram's publish API is officially JPEG-only — add a transcode step (Pillow, already implied by the image pipeline) + host the JPEG at a public URL.
- **Cross-service data pull (the real new integration):** R&R's `agent.py` doesn't talk to Welra today. The diary needs R&R's latest card URL + that report's numbers. Cleanest: a small authed Welra endpoint returning `{cardPngUrl, weekRevenue, weekOrders, weekFavorites, weekViews, weekN}` for R&R's own account (service-role or a shared secret) — build it on the Welra side where the data lives, R&R fetches it.
- **Schedule:** one new Monday slot in `rr-supervisor.py` JOBS (report/suggest already fire Mondays) — added ONLY after a manual test post is eyeballed.
- **Scope fence (Continuation_Playbook: don't let R&R eat sessions):** one bounded session for the endpoint + `post_diary` + transcode + a manual test post; supervisor wiring last; first live post only after Ryan approves the caption set.

**Guardrails:** captions ONLY from real report values; the "this week I'm…" line comes from a Ryan-pre-approved rotating list or is omitted; missing report → skip silently; revenue never appears on the card itself (existing privacy rule) — the $0 story lives in the caption, which is R&R's own choice to publish.

## Move 2 — BRAND: name the deliverable **"Your Monday Radar"** (feature copy only)

Welra's positioning today is a category ("weekly reports"); categories get compared on features. Name the deliverable and sell the habit:
- **Email subject: "Your Monday Radar — [Shop name]"** — the tagline "Your business radar" finally cashed in where it's allowed to live.
- **Cadence fence respected (session-18 decision, Brand_Identity):** "Monday" stays OUT of the hero/tagline/mission — the first draft proposed a Monday hero line and validation correctly flagged it. Hero stays evergreen; "Monday Radar" appears in email subject, feature sections, blog CTAs, and the sample page's report header only.
- **Enemy framing for content/comms:** "Don't spend another dollar on ads before you can read your own numbers." The enemy is wasted spend and dashboard confusion — never a competitor, never led by "AI."

Claude-executable: subject line + feature-copy touches, one staged deploy.

## Move 3 — CONVERSION: **welra.io/founding** — one destination, reconciled with the live offer

The site **already runs a "Founding Seller beta — free Pro plan while we build" banner** (validation caught this — a second, differently-termed "founding" offer would fork the promise). So: don't invent a new offer, **give the existing one a home**:
- `/founding` becomes the page the existing banner links to: the Founding Seller offer spelled out — free Pro during beta, founder pricing locked at launch, white-glove 10-minute setup call, **5 named founding spots** (first name + shop, only with permission) shown filled/open.
- Every DM, diary caption, comment, and signature now points at ONE destination with visible scarcity, and the terms match everywhere.
- Turns the ask from "do me a favor" into "claim a spot."

Claude builds it; spot counter is manual (it's 5 spots).

## Move 4 — COMMS: reply protocol for the warm DMs (activates on Ryan's confirmation)

1. **Reply within the hour** when a response lands (tell Claude — same-day report is the promise).
2. **48–72h silence → exactly one bump**, softest possible: *"No worries either way — here's what yours would look like: welra.io/sample?name=X&shop=Y"* (verified live in prod, personalization working). Then stop — a warm contact ghosting twice is an answer.
3. **On any yes:** 10-minute call first (already in templates) → same-day report → after they see value, one referral question: *"know one other seller who'd want this?"* One hop of warmth per user is the whole growth model until Stripe goes live.

## Move 5 — R&R's own capture loop
- Monday = diary (Move 1); W/F stay pillar art. At ~10 followers the shop *is* the content.
- **Pinterest is R&R's only follower-independent reach channel** — diary pins + art pins both continue there.
- Every diary post's caption/comment path ends at the Etsy shop (38 live listings): the diary sells the story, the shop converts it.

## What we deliberately do NOT do (graveyard + rules respected)
No cold outbound (#12) · no X/Twitter (#20) · no cross-shop data ever (#40) · no new outreach channels while warm DMs await replies · no paid ads before first organic sale (either brand) · no cadence words in hero/tagline · no claims the data can't show.

## Sequence & ownership

| When | What | Owner |
|---|---|---|
| Now | Confirm DMs sent → Move 4 protocol live | Ryan (one word) |
| This week | Move 0: Etsy favorites/view-delta enhancement to `etsy.ts` (one bounded build + deploy; ships to all Etsy sellers) | Claude |
| This week | Move 3 `/founding` + Move 2 Monday Radar copy (one staged deploy) | Claude |
| Next | Move 1 diary job build (bounded session, staged; first post after caption-set approval) | Claude |
| Ongoing | Diary runs Mondays automatically; first sale = milestone content for both brands | Automated |

**Success metrics:** replies/yes from the warm DMs (days) · Vercel Analytics on `/sample` + `/founding` (now measurable) · R&R Monday-diary reach vs. art-post reach after 4 episodes · R&R Etsy favorites + view-delta trend in the reports themselves (the honest rising metric, Etsy-sourced per Ryan's redirect) · first R&R sale = flywheel ignition.

## Validation record (2026-07-06)
Adversarial pass confirmed: Week Card unconditional generation + public routes; R&R qualifies for weekly reports (integrations live, founder comped, dry-run off); `/sample?name=` personalization live in prod (curl-verified); Monday-review blog post live; queue at 4 non-optional items. Refuted & fixed: posting-function caption path (new code required), "saw it coming" copy (impossible + voice violation), Monday-in-hero (cadence fence). Collateral adopted: episode-thinness → Move 0; /founding collision → reconciled into existing offer; stale "non-expiring FB token" comment in rr-supervisor.py → fixed in repo; durable card URL + report-id discovery → in build spec.
