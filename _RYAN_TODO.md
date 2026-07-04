---
title: RYAN'S TODO — the only document Ryan works from
project: cross-project (Welra, Rust & Rainbow, Hubitat, Stock Agent, Dropship Pipeline, AutoBiz/GR3NB)
type: tasks
updated: 2026-07-04 (Shopify client secret rotated + old one revoked, verified live. Reddit/FB round 2 revised after live-checking both accounts — see 🔵 section. R&R: bg-removal bug fixed on 10 designs/34 listings; found META_ACCESS_TOKEN broken — new 🔴 item. New 🐕 Dropship Pipeline section added: Dog Cooling Mats business plan finalized at a <$100 cash cap, true dropship, no Etsy/R&R — Etsy policy bans reselling mass-produced items, confirmed this session)
tags: [ryan, todo, live]
---
	
# ⭐ RYAN'S TODO

> **How this works:** You work ONLY from this file. Claude maintains it — after every session or milestone, Claude updates it from all the plans/playbooks/logs, which stay Claude's tracking layer. If a task isn't in this file, it is not your problem. When you finish something, tick it or just tell Claude. Every task here has the exact steps and, where useful, paste-ready text.
>
> **This file now spans every active project**, not just Welra — consolidated 2026-07-03 evening from all 6 project Tasks.md files. Welra stays first because it's the one with a revenue clock running.

**North star behind everything: land beta user #1 for Welra.** Task 1 in the Welra section is the one that does it. Everything else is support — except the item just below, which is real and currently broken, unrelated to that goal.

---

## ✅ RESOLVED TONIGHT — Meta/Facebook credentials

✅ **`META_FB_PAGE_TOKEN` — DONE (2026-07-03 evening).** You pasted the new long-lived Page token; Claude wrote it into both `.env` files (Mac: `~/Claude/Projects/side business/Rust & Rainbow/.env`; NAS: `/volume1/homes/admin/claude-agents/agents/rust-rainbow/.env`) and live-verified it on **both machines independently** against the real Graph API — `{"id": "1135312136329438", "name": "Rust and Rainbow"}` on each. Facebook Page photo posts should work again. (Handled the token itself carefully: piped it directly over the SSH channel into the file rather than ever writing it to a shell command or a shared temp location.)

✅ **`META_ACCESS_TOKEN` (Instagram) — DONE**, confirmed live on both Mac and NAS (10 followers, 31 posts). Welra has no Instagram integration connected, so nothing there was stale either.

✅ **ANTHROPIC_API_KEY on Rust & Rainbow — DONE**, confirmed live on both machines. The one remaining follow-up (run `--mode generate` once and eyeball the results) lives in the Rust & Rainbow section below — a nice-to-have check, not blocking.

**Nothing actively broken right now.**

---

## 🅦 WELRA — beta user #1 is the whole game

### 1. Send 3 warm DMs (~15 min) — THE task
- [x] a. Open your texts + Instagram DMs and scroll. Write down the first 3 people you see who **sell or make things** (Etsy, POD, craft fairs, side hustle — anything). Don't brainstorm, just scan. 3 sent beats 10 planned.
- [x] b. For each person, pick the right message below, paste it, and personalize ONLY the first sentence (mention their shop / their last post / something real).
- [x] c. Send all 3 before re-reading any of them.

**If they sell POD / Printify — paste this:**
> Hey [Name] — quick one. I've been building a tool for my own Printify shop that emails me a weekly summary of sales, what moved, and what to focus on. I want to try it on a few shops that aren't mine — yours would be perfect. You'd just share your Printify API token (read-only, revoke it right after), I run everything, and you get a real report same day. Zero setup on your end. Free, I just want your honest take.

**If they sell on Etsy or run WooCommerce — paste this (new: both are one-click as of today, no CSV needed):**
> Hey [Name] — quick one. I built a tool that emails you a weekly summary of your shop's numbers. For Etsy or WooCommerce it's genuinely one click — you sign up free, click Connect, log in on their site, done. No file to export, nothing to send me. First report same day. Free, I just want your honest take.

**If they sell anything else — paste this:**
> Hey [Name] — I built a tool that emails you one clear weekly summary of your shop's numbers. Totally free, the only setup is a quick CSV export (I'll walk you through the 2 steps). Want me to make you one from last month? Would love honest feedback.

**If they don't sell but might know someone — paste this:**
> Random ask — do you know anyone who sells stuff online (Etsy, Printify, their own site, side hustle, doesn't matter)? I built a free tool that emails shop owners a weekly summary of their numbers and I'm looking for a couple people to try it. Not selling anything, just want honest feedback. If you think of someone, I'd love an intro.

**Optional add-ons (use if they help you hit send):**
- Sample link, personalized: `welra.io/sample?name=Sarah&shop=Sarahs%20Candles` (greets them by name — live now)
- Proof-of-honesty link: `welra.io/blog/my-shops-first-welra-report` (the report on YOUR $0 week)
- Proof-it's-shipping link (once you push it above): `welra.io/blog/etsy-woocommerce-one-click` (this week's real milestone — good for Etsy/WooCommerce sellers specifically)
- Nudge line: *"First few people who try it and give me honest feedback — I'll send a $10 gift card, no strings."*
- White-glove line (use if they seem interested but busy/unsure how): *"Happy to just hop on a quick call and set it up live with you — 10 minutes, I'll walk you through it."* Costs you nothing extra to offer, removes the last bit of setup friction, and if they take you up on it you get to watch someone use Welra for the first time — which is worth more than any survey.

**When anyone says YES:** tell Claude immediately. Printify seller → they sign up at welra.io/signup and connect Printify (report fires automatically). Anyone else → Claude sends you the CSV steps for their platform, they export, Claude runs it, report back SAME DAY. **Whoever says yes first — offer them the 10-minute call above before you do anything else.** Watching them use it live surfaces confusion you'd never catch from a text thread, and it turns "beta tester" into a relationship, which is what actually produces a testimonial later. Then ask them: "Does this match what you saw in your dashboard? Worth getting every Monday?" — their answer is the real product backlog.

### 2. Indie Hackers — earn posting rights first (~10 min/day for a few days)
New accounts can't post: moderators grant privileges to people with "a pattern of contributing authentically" (or IH Plus unlocks instantly — skip paying; the comment path also warms your profile so the post lands better).
- [ ] a. Each day, open indiehackers.com and find 2 threads where you have REAL experience: POD/Printify, Etsy selling, building a first product, getting a first customer, platform app rejections (you have war stories now).
- [ ] b. On each, leave a 3–6 sentence comment that shares a specific experience or number from your own journey. No links. Never mention Welra unless someone asks what you're building.
- [ ] c. Comment template if stuck: what you tried → what actually happened → what you'd do differently. Specific beats clever.
- [ ] d. Every couple of days, check if "Submit a Post" works. The moment it does → paste the ready draft from [[Projects/Welra/IH_Post_Draft]] (title: **My analytics tool had to report on my own shop's $0 week**), then reply to every comment for 48h.
This doubles as the 🔵 daily-rhythm habit below — IH counts as one of your two daily comments.

### 3. Send the Resend broadcast (~5 min)
These people already asked for a sample report — warmest non-personal channel you have.
- [ ] a. Say to Claude: **"give me the broadcast copy"** (Claude pulls the drafted subject + body).
- [ ] b. resend.com → log in → Broadcasts → New Broadcast.
- [ ] c. From: `ryan@welra.io` · paste subject + body → Audience: **Welra Leads**.
- [ ] d. If the contact count is ≥1 → Send. If 0 → save draft, done for now.
- [ ] e. Watch ryannortham3@gmail.com for replies; forward any to Claude.

### 4. TikTok demo video (30–45 min with Claude, whenever you have the block)
The whole application is done and saved — this is the ONLY item left before submitting.
- [ ] a. Say to Claude: **"let's do the video."** Claude sets up the TikTok sandbox, points the API at it, un-gates the connect button, and runs the screen recording.
- [ ] b. Your two moments: type your TikTok login on the authorize screen, and drag the finished .mov into the Upload box.
- [ ] c. Click **Submit for review**. Then it's TikTok's clock (days–weeks).

### 5. Shopify Partners — redirect URL fixed everywhere; one optional step left
The "Welra" app already existed (created June 10, Client ID `10367a52216a770cff408d3bcf7399ad`, scopes `read_orders,read_products` — matches the code exactly).
- [x] **Fixed in Shopify itself:** registered redirect URL was stale (old Railway subdomain), corrected to the live `api.welra.io` domain, released as version `welra-4`.
- [x] **Fixed in Railway:** `SHOPIFY_REDIRECT_URI` had the same stale value — you said "I authorize it," Claude made that one specific change and redeployed. New container booted clean, health checks green.
- [ ] **Optional, not urgent:** `SHOPIFY_CLIENT_SECRET` in Railway hasn't been rotated since June 10, so it's almost certainly still correct — but if you want it double-confirmed, say specifically "refresh SHOPIFY_CLIENT_SECRET in Railway from Shopify" (this exact sub-action needs naming too — "I authorize it" covered the redirect URL fix but not this one, by design).
- [ ] Once you're comfortable, the Shopify OAuth connect button just needs its readiness flag flipped from `beta`/`coming` to `live` (check `INTEGRATION_READINESS.shopify` in the code) and a smoke test against a free Partners dev store before real customers touch it.

**Two things noticed along the way, unrelated to Shopify:**
- Railway shows **"3 days or $4.02 left"** on the account/billing banner — worth a look before it threatens uptime.
- There's an unrelated, already-staged-but-undeployed change sitting in Railway (`SENTRY_DSN` value update) that Claude left untouched since it wasn't part of this task — mention it if you want Claude to look into what it is.

### 6. BetaList listing (~20 min, pure form-fill)
- [ ] a. betalist.com → Submit a startup.
- [ ] b. Open [[Projects/Welra/Press_Drafts]] §4 in another tab → copy each field verbatim → submit. (Goes live 1–2 weeks after their review.)

### 7. Add a one-line Welra mention to your email signature (~2 min, fully optional)
Passive, zero-ask — doesn't compete with anything above.
- [ ] Gmail → Settings → General → Signature → add under your name: *"P.S. — I'm building Welra, a weekly numbers report for small online shops. welra.io/sample"*
- [ ] Skip entirely if it doesn't feel like you.

### ✅ 8. Web analytics — DEPLOYED 2026-07-03 evening
Growth pipeline added Vercel Web Analytics — closes a real blind spot (up to now the only way to know if a shared link ever got clicked was a seller replying). Cookieless, no privacy-policy change needed. You said "deploy the welra analytics," Claude pushed (`3d71eda`) and ran `vercel deploy --prod`, then verified two ways: the live script endpoint (`welra.io/_vercel/insights/script.js` → 200) and an actual browser load of welra.io showing the analytics script firing. It's tracking now.

**Optional — daily nudge experiment:** if the 3-DM ask (task 1) keeps not happening even with the sharpened copy, say the word and Claude will set up a one-time-approved daily push notification pointing straight at task 1, instead of relying on you remembering to open this file. Not set up yet — needs your yes first.

### GR3NB LLC paperwork — one 30-minute sitting, sometime this month
- [x] Sign + date the Operating Agreement → `~/Documents/GR3NB/Legal/Operating_Agreement_GR3NB_LLC_2026.md`
- [ ] Fill the Home Office Worksheet → `~/Documents/GR3NB/Home_Office/Home_Office_Worksheet_2026.md` + take one photo of the workspace into that folder
- [ ] Add 3 calendar reminders: quarterly IRS estimated taxes (Apr 15 / Jun 16 / Sep 15 / Jan 15) · Oregon LLC renewal ~May 2027 ($100) · monthly 10-min expense log on the 1st
- [ ] Decide on the WELRA trademark (~$350 — optional; tmsearch.uspto.gov to confirm clear, file at USPTO Trademark Center). Fine to defer until revenue exists.

---

## 🐾 RUST & RAINBOW — quick items (the two big ones are up top in 🔴)

- [x] **`META_ACCESS_TOKEN` (Instagram) fixed — 2026-07-04.** You logged into Instagram and approved the permissions; Claude generated the token via the App Dashboard, copied it straight from the clipboard into `.env` (never typed/shown), and confirmed it live on both Mac and NAS (`rustandrainbowco`, 10 followers, 31 posts, both machines). Turned out the "cannot parse" error was likely just Claude testing against the wrong API host, not real corruption — either way it's confirmed working now. Unblocks fixing the 4 Instagram posts below.
- [x] **Background-removal bug found and fixed today (2026-07-04)** — rembg was leaving some black text semi-transparent (looked "weird" on shirts, per your report). Root cause confirmed pixel-by-pixel; Adobe's background removal tool doesn't have the bug and costs $0 of your 250 Firefly credits (it's a non-generative feature). All 10 affected designs reprocessed and republished to Etsy — 34 live listings recreated with the fixed artwork, confirmed live. **Still pending your token fix above:** 4 of those designs also need their old Instagram posts deleted + replaced (Velcro Dog Line Art, Rainbow Vizsla Silhouette, Vizsla Puppy Sticker, Pride Flag Vizsla). Their old TikTok videos can't be deleted at all (confirmed — TikTok doesn't allow deleting published posts via API even directly), so those will just stay up; new corrected TikTok posts can still be added once IG is fixed.
- [x] **Delete the duplicate "Gay Dog Dad Retro" listing in Printify** (~2 min) — May 11 product (ID `6a025e0754291b828c064667`) is the stale one; May 14 (`6a0654c3e556c763050faeed`) is the keeper with the stable mockup. Deleting in Printify auto-unpublishes the Etsy listing too.
- [x] **Verify the R&R Etsy shop is still in good standing** (~5 min) — the earlier ban was on the *API app*, not the shop, but the reason cited was AI-generated content on listings, which IS a shop-policy risk. Check the shop dashboard + any Trust & Safety emails.
- [ ] **Keep an eye on the TikTok developer app review** (~2 min/week) — 3rd submission, App ID `7638050043181959175`, check developers.tiktok.com. If it clears, worth evaluating a switch from Zernio to the direct API; if rejected again, just stay on Zernio for good.
- [ ] Once a few designs are selling, tell Claude to run the new tote/poster/ornament modes on the top sellers (ornament is Q4-only, skip until ~October) — confirm the blank costs Claude estimated are right first.
- [ ] Now that `ANTHROPIC_API_KEY` is confirmed live on both machines, tell Claude to run `python agent.py --mode generate` once and eyeball the first batch isn't all typographic before letting it run unattended — proves the style-variety logic, not just the key.

---

## 🏠 HUBITAT — home automation, no deadline, whenever you have a Hubitat-app evening

Do these roughly in this order — several are gated on a quick fix first:
1. Pause or change the fireplace watchdog (5min → 10min, or pause it) — it's spamming command-off right now.
2. Toggle presence detection off/on in the Hubitat mobile app for your phone (device 1) and Grace's phone WiFi (515) — broken, blocks the Away-mode rule.
3. Re-auth LG ThinQ (Washer 556 / Dryer 555 — stale since Aug 2024) — blocks the laundry-notification rule.
4. Disable the Ecobee native schedule — blocks the thermostat-setback rule.
5. Once those three are cleared, build the Rule Machine rules: Away mode, Fireplace 4hr auto-shutoff, Thermostat setback by mode, Laundry notifications, Kitchen night motion, Morning wake lights 7:15am.
6. Simple Automations (no dependencies): Outdoor lights sunset/11pm, ShutDown 11pm timer, Coffee weekend delay.
7. Mode Manager: build the Mode 0 daily schedule.
8. Small cleanup: delete unused Device 54, assign rooms to the 4 AirPlay speakers (572/573/575/577), build DD Stair motion lights (566/567 → 565).

---

## 📈 STOCK AGENT — one small item, no rush

- [ ] Tell Claude to run the one remaining forward-test-reporter deploy (`./deploy.sh stock`) whenever convenient — it's built and smoke-tested, just needs the NAS deploy so the go-live gate (30 paper trades) becomes visible in the logs without asking for a manual checkpoint. Purely observability, not a strategy change.

---

## 🔵 REDDIT + FACEBOOK — round 2 (revised 2026-07-04 after checking both accounts live)

Checked both accounts before writing this — neither had warmed up since the last attempt. Reddit is 2 weeks old with 1 karma (one comment posted, not removed, zero replies). Facebook's "Rust Rain" profile is in the *exact* zero-signal state that got auto-declined on 2026-06-20: no photo, no cover photo, 0 friends, no real posts. Going straight back into the same groups would likely repeat that decline. Fix the profile first — it's free and takes 10 minutes.

### Step 1 — Fix the Facebook profile (~10 min, do this before anything else below)
- [ ] Add a profile photo (a blank gray icon is the single biggest spam signal to group automod)
- [ ] Add a cover photo (anything)
- [ ] Accept/add 8–10 friends right now — Facebook is already suggesting some on your profile page ("People You May Know")
- [ ] Post one real, non-promotional update to your own timeline — a photo, a thought, anything unrelated to Welra

### Step 2 — Reddit (10–15 min/day, optional but keep it up)
- Keep commenting in **r/ecommerce** (proven — your comment there wasn't removed) and add **r/smallbusiness**, **r/EtsySellersAdvice** (lower-filter than their bigger siblings)
- Hold off on r/EtsySellers and r/shopify — strictest filters, 1 karma won't clear them yet
- New angle worth trying: **r/SideProject, r/alphaandbetausers, r/betatests, r/indiebiz** — post the beta-tester ask below; these subs exist for exactly this kind of post
- No links until karma is real. One comment per thread, no repeats.

**Reddit comment — "which stats matter":**
> The stats I actually check every Monday: revenue vs. last week, order count vs. last week, and which 1–2 products are doing the heavy lifting. Everything else is noise unless you're mid-experiment. I write these down by hand now — the week-over-week trend tells you more than any single day's dashboard ever will.

**Reddit comment — "sales dropped, panicking":**
> First thing I'd check before assuming it's you: did traffic drop, or did the same traffic just stop converting? Those point to totally different fixes — traffic is usually seasonality or search ranking, conversion is usually your photos or price. I've burned whole weekends fixing the wrong one because I didn't check which number actually moved first.

**Beta-tester post (r/SideProject, r/alphaandbetausers, r/betatests, r/indiebiz):**
> **Title:** Built a free weekly report tool for e-commerce sellers — need 5 beta testers
>
> I run a small Etsy/Printify shop and got tired of digging through separate dashboards every Monday to figure out what actually happened that week. So I built something that reads the numbers for me and emails one clear summary — what sold, what changed, what's worth doing next.
>
> Looking for 5 sellers (Etsy, Shopify, or WooCommerce — one-click connect for the first two, no CSV needed) to try it free for 8 weeks. In exchange, just 5 minutes of honest feedback per report — what's useful, what's wrong, what's missing.
>
> Not selling anything during the beta. Comment or DM your platform and I'll set you up same day.

### Step 3 — Facebook (only after Step 1 is done)
- Start with **Shopify Community for Store Owners** (46K members, ~20 posts/day — lower volume than the Etsy groups, comments stay visible longer, less aggressive filtering)
- Only once that lands cleanly, try the Tier-1 Etsy groups again ("Etsy Sellers Only", "Etsy Sellers and Beginners Community", "Etsy Sellers Group")
- No links, no pitch, one comment per group per visit

**FB membership question (Shopify for Store Owners):**
> Run a small multi-channel shop (Etsy + Printify) and I'm poking around Shopify to understand how it compares — here to learn from people actually running stores on it.

**FB give-first comment (views but no sales):**
> Same boat with my own shop — high views, flat sales usually traces back to one of three things: the thumbnail isn't stopping the scroll, price/shipping surprises people at checkout, or the traffic itself is low-intent (ad clicks, not buyers). Pull your top 3 listings and check conversion on each separately — it's almost always one listing dragging the average down, not the whole shop.

### Step 4 — Direct DMs (only after Step 1 — a 0-friend account DMing cold reads as bot-like)
> Saw your post about [their specific frustration]. I built exactly this — a tool that emails one clear weekly report on your shop instead of you digging through tabs. Etsy and WooCommerce are one-click now, no file exports. Want a free one? I'll set it up and send the first report same day, no strings.

---

## 🐕 DROPSHIP PIPELINE — Dog Cooling Mats (new venture, <$100 cash cap, true dropship)

Full plan: [[Projects/Dropship_Pipeline/Business_Plan_Dog_Cooling_Mats]] (this is the detailed reference; steps below are the actual actions, self-contained). **Not Etsy/Rust & Rainbow** — confirmed this session that Etsy bans reselling mass-produced items outside handmade/vintage/craft-supply categories, with tightened 2026 enforcement; listing this there risks the whole R&R shop, not just a rejected listing. This is its own storefront instead.

### 1. Confirm Welra's Vercel plan tier (~2 min)
- [ ] Log into vercel.com, check whether the account/team is on a paid Pro/Team plan or still Hobby. Tell Claude which — a paid plan means the new storefront hosts there for $0 extra; Hobby's terms restrict commercial use, so a free tier there would need its own account or an upgrade first.

### 2. Get real supplier pricing — check 3 channels, not just CJ (~20–30 min)
CJ alone came back too expensive — check in this order:
- [ ] a. **Alibaba's Dropshipping Center** — search for a dropship-tagged dog cooling mat supplier (single-unit orders, ships direct to your customer, no MOQ). Get per-unit price + US shipping cost + delivery time. Likely the cheapest of the three.
- [ ] b. **AliExpress** — search "dog cooling mat," note a comparable listing's price as a second data point.
- [ ] c. **CJdropshipping** — log in directly (confirmed they carry a matching SKU: "Dog Cooling Mat... Pressure-Activated... Non-Toxic Gel"), get their number too, as fallback only.
- [ ] d. Tell Claude all three numbers — Claude picks the cheapest that also clears the safety check below and recomputes the plan's margins (currently marked TBD).

### 3. Confirm non-toxic gel safety documentation (~10 min, same calls as step 2)
- [ ] Ask whichever supplier you're leaning toward for real safety documentation or a lab test certificate on the gel fill — not just a marketing claim. If they can't produce it, tell Claude so it switches you to the backup supplier. This is a hard pass/fail gate, flagged 3 times in the original research (a dog chewing through the mat and ingesting the gel is a real poisoning/chargeback risk).

### 4. Price a bundle upsell item too (~10 min)
- [ ] Find a cooling bandana or portable water bowl from a no-MOQ dropship supplier (same or a different channel) to pair as a post-purchase upsell. This is the plan's actual differentiator (the pipeline's "same-week delivery" edge is gone under true dropship) — it needs a real item and price, not just a claim.

### 5. Tell Claude to build the storefront (a session together, no new cost)
- [ ] Say **"let's build the cooling mat storefront."** Claude builds a single-product page on Vercel (reusing the Welra account per step 1) plus a **new, separate Stripe account** for checkout — not Welra's, which stays untouched — sets up Stripe Tax for sales tax, and writes the shipping-delay disclosure + FTC-required cancellation/refund email template.

### 6. Place one personal test order (~$15–25)
- [ ] Once the storefront is live, buy one mat + bundle item through it yourself, exactly like a customer would. When it arrives, check the non-toxic-gel claim and overall build quality.

### 7. Launch the seed ad round (~$60–75, roughly a week)
- [ ] Set up a TikTok Ads Manager account and pixel (Claude can walk you through this). Run $10–15/day for about 5–7 days. This is the only new-cash ad spend in the whole plan.

### 8. Read the result — stop or reinvest, no in-between
- [ ] **Zero sales, or CAC way above ~$22:** stop. Take down the storefront, no more cash spent, nothing to unwind (no inventory was ever bought).
- [ ] **Shows promise:** tell Claude — it reinvests that round's revenue into the next ad round automatically, per the plan's ramp rules. No new cash needed from you from this point on.

**Total new cash needed, steps 6–7: ~$75–100. Everything past that point runs on sales revenue, not your wallet.**

---

## ⚪ WAITING / PARKED — zero action from you
- **TikTok review (Welra)** — after you submit (#4 above); Claude watches for the decision.
- **Etsy (Welra)** — ✅ DONE. Approved, live, proven with a real multi-source report.
- **WooCommerce (Welra)** — ✅ DONE. One-click proven live today.
- **Meta / Instagram one-click (Welra)** — parked until after beta user #1 (verify as GR3NB LLC when the time comes).
- **Stripe live mode (Welra)** — gated until a validated beta user says they'd pay.
- **Qwoted / press requests** — only act on a match email the SAME MORNING it arrives; older than a day = skip, they fill in hours.
- **welra.io SPF record, Lemon Squeezy standby, competitive-positioning copy** — Claude's queue, not yours.
- **Dropship pipeline entity/compliance checklist** (LLC placement, bank subaccount, resale certificate, real domain) — now has a specific candidate (Dog Cooling Mats) and a full plan, but this checklist is still Phase 5 — only matters after the ad ramp (🐕 section above) reaches a confident CAC read and passes. Nothing to do here yet.
- **Dropship pipeline CLI login** — ✅ resolved; today's run (2026-07-03) completed clean with real API calls, no more 401s. It's running itself every morning now.
- **Dropship pipeline supplier order-sync automation** — deferred on purpose until Phase 5 (after the ad ramp passes); the plan uses manual order forwarding during testing so no standing supplier contract exists before there's a validated reason for one.
