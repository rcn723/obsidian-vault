---
title: Welra Tasks
project: Welra
type: tasks
updated: 2026-06-23 (growth pipeline — Priority Queue rewritten with step-by-step instructions; blog post staged)
tags: [welra, tasks, launch]
---

# Welra Tasks — Product & Engineering

Source of truth for product/engineering work. Business/legal/tax tasks live in [[Projects/AutoBiz/Tasks]].
Priorities set by [[Projects/Welra/Strategy_Review_2026-06-09]].

---

## 🎯 Priority Queue — updated 2026-06-23

> **One goal: land beta user #1.** Everything below is ranked by how directly it moves that needle. Do them in order. Stop when you've run out of time, not when the list runs out.
>
> All outreach copy is in the **📋 Outreach copy** section below — §A = find targets, §B = give-first comments, §C = DMs, §E = objection handler. CSV export steps → [[Projects/Welra/CSV_Export_Guide]].

---

### 🔴 P0 — Do these first (blocks everything else)

- [ ] **Deploy the API report fix + new blog post** (~10 min, two commands) [owner:: ryan] [priority:: high] [status:: open]
  > **Why now:** The report-email markdown bug (raw `**bold**`/`---` in every report) has been fixed in the working tree since s22 but never deployed. Any beta user who gets a report before this ships sees broken formatting. This is a go-live blocker. Pair it with the blog post deploy so you only run the commands once.
  >
  > **Step 1 — deploy API fix:**
  > ```
  > cd ~/Claude/Projects/side\ business/Welra
  > railway up --service welra
  > ```
  > Wait for "Healthcheck succeeded" in the terminal output (takes ~60s). If it stalls, check Railway dashboard → welra service → Logs tab (not Deploy tab) for the boot lines.
  >
  > **Step 2 — deploy blog post:**
  > ```
  > npx vercel deploy --prod
  > ```
  > Run from the same repo root. Wait for "Production: https://welra.io" in output.
  >
  > **Verify:** Open `https://welra.io/blog/weekly-shop-review-monday-habit` — post should be live. Open `https://welra.io/blog` — should show 3 posts with the new one at top.

---

### 🟠 P1 — Highest-signal outreach (do today, takes <30 min total)

- [ ] **Send the Resend broadcast to Welra Leads** (~5 min) [owner:: ryan] [priority:: high] [status:: open]
  > **Why:** These are people who already signed up to receive a sample Welra report. They self-selected. This is the warmest non-personal-network channel available — warmer than any cold community. The email was drafted by the growth pipeline on 2026-06-21.
  >
  > **Steps:**
  > 1. Go to [resend.com](https://resend.com) → log in → Broadcasts → New Broadcast
  > 2. Name it something like "Welra beta invite — June 2026"
  > 3. From: `ryan@welra.io` · Subject: use the subject line from the June 21 pipeline notification
  > 4. Paste the email body from the June 21 pipeline notification
  > 5. Select audience: **Welra Leads** (id `879d0ab3-34b6-4ec7-9d76-2a427f8e8a6a`)
  > 6. Check the contact count shown. If ≥1, send. If 0, save as draft and check back when leads accumulate.
  >
  > **Success:** Email delivered. Watch ryannortham3@gmail.com (the Welra inbox) for replies.

- [ ] **Warm-intro outreach to sellers you personally know** (15–20 min) [owner:: ryan] [priority:: high] [status:: open]
  > **Why:** Highest-trust channel that exists. You know these people. No identity tax, no karma gate, no platform auto-decline. This is the documented path to user #1 and has been the #1 task for weeks. One "yes" here unlocks everything downstream (real report, testimonial, referral).
  >
  > **Steps:**
  > 1. Write down 5–10 names of sellers you know personally (any platform — Etsy, POD, Shopify, handmade, side hustle, doesn't matter).
  > 2. For each: reach out however is natural (text, DM, email, iMessage). One message per person, not a blast.
  > 3. The ask: "Hey — I built a tool that emails you one clear weekly summary of your shop's numbers. Totally free, no setup beyond a CSV export. Want me to send you one based on last month? Would love honest feedback." Adapt to your voice.
  > 4. Drop `welra.io/sample` if they want to see what they'd get.
  > 5. When someone says yes: send them [[Projects/Welra/CSV_Export_Guide]] for their platform → they export → you run it through the pipeline → report back same day.
  >
  > **Do NOT overthink the pitch.** You know these people. Keep it casual.

---

### 🟡 P2 — Quick wins (do today or tomorrow, <30 min each)

- [ ] **Post the Indie Hackers build-in-public draft** (~10 min) [owner:: ryan] [priority:: medium] [status:: open]
  > **Why:** No karma gate, no identity risk. IH has makers who often run side shops. The draft exists from the June 21 pipeline run — this is paste-and-post.
  >
  > **Steps:**
  > 1. Go to [indiehackers.com](https://indiehackers.com) → log in → New Post → select "Share an update" or "Share a project"
  > 2. Paste the draft from the June 21 pipeline notification
  > 3. Add the link to `welra.io/signup` if not already in the draft
  > 4. Post. Don't agonize over edits — ship it.
  >
  > **Success:** Post is live. Watch for comments/DMs over the next 48h.

- [ ] **Submit BetaList listing** (~20 min) [owner:: ryan] [priority:: medium] [status:: open]
  > **Why:** Free placement in a maker/early-adopter community. Copy is already written in [[Projects/Welra/Press_Drafts]] §4 — this is a form-fill, not a writing task.
  >
  > **Steps:**
  > 1. Go to [betalist.com](https://betalist.com) → Submit a startup
  > 2. Open [[Projects/Welra/Press_Drafts]] §4 in another tab — copy each field verbatim
  > 3. Submit. Takes 1–2 weeks to go live after their review.
  >
  > **Success:** Confirmation email received.

- [ ] **Etsy API resubmit** (~20 min, available 2026-06-25) [owner:: ryan] [priority:: high] [status:: open]
  > **Why:** Etsy is a friction-reducer for Etsy sellers (they currently join via CSV). Reapply on or after **June 25** — the reminder `etsy-api-resubmit-reminder` fires at 9am that day.
  >
  > **Steps (do not improvise — use verbatim copy):**
  > 1. Log into the **Welra Etsy developer account** (NOT the rust-and-rainbow account — that one is permanently banned)
  > 2. Open [[Projects/Welra/Etsy_API_Approval_Strategy]] — use the exact application copy in that doc, word for word
  > 3. Submit ONE clean application. Do not submit from the R&R account, do not network-evade.
  > 4. Watch ryan@welra.io (via ryannortham3@gmail.com POP import) for their reply.
  >
  > **Do NOT resubmit before June 25** — early/duplicate submits auto-deny.

- [ ] **Source of Sources signup** (~2 min) [owner:: ryan] [priority:: medium] [status:: open]
  > **Why:** Free press pipeline. Journalists post "looking for a source on X" — you respond as a seller/founder. Runs in the background; 2 minutes to set up.
  >
  > **Steps:**
  > 1. Go to [sourceofsources.com](https://sourceofsources.com) → sign up (name + email only)
  > 2. Once in: answer 2–3 requests per week that fit the "small business owner" or "e-commerce seller" angle
  > 3. Never mention Welra first — answer as a founder/seller, let them ask about your tools

---

### 🟢 P3 — Daily habit (takes 15–30 min/day, ongoing)

- [ ] **Facebook seller groups — give-first comments** (15 min/day) [owner:: ryan] [priority:: medium] [status:: open]
  > **Why:** Primary warm-up channel while Reddit account seasons. FB groups have active sellers venting about their numbers — the exact ICP. New FB identity is gated (comments can be auto-declined), so give-first genuinely before any mention of Welra.
  >
  > **Daily steps:**
  > 1. Open one of the Tier 1 groups (see [[Projects/Welra/Marketing_Campaign_2026-06]] for the group shortlist)
  > 2. Scan the last 24h of posts for sellers asking about stats, sales, "is this normal," or "what am I doing wrong"
  > 3. Pick 1–2 posts. Leave a genuine, specific reply using §B templates as a *starting point* — always reference what the OP actually said (identical copy = spam flag)
  > 4. **No link in comments.** No mention of Welra unless they directly ask "what do you use?"
  > 5. If they ask → drop `welra.io/sample` and offer the free report
  >
  > **The new blog post (`welra.io/blog/weekly-shop-review-monday-habit`) is now a legitimate give-first link** — if someone asks "how often should I check stats?" or "which metrics matter?" you can drop it. It's a resource, not a pitch.

- [ ] **Reddit — warming only** (10 min/day) [owner:: ryan] [priority:: low] [status:: open]
  > **Why:** Building account age and karma so DMs and links unlock. No signups expected for 1–2 weeks.
  >
  > **Daily steps:**
  > 1. Run the incognito shadowban check first (open your profile logged out — if comments are missing, you're shadowbanned; stop posting until cleared)
  > 2. Scan §A search links for sellers venting this week
  > 3. Leave 1 give-first comment in r/EtsySellersAdvice (lower filter than r/EtsySellers) — use §B, vary wording, reference the OP
  > 4. **No links. No DMs until account warms.** Obey rate limits immediately — "take a break" means stop for the day.

---

### ⚪ P4 — Background (one sitting, then it runs itself)

- [ ] **Start Meta Business Verification** (~30 min) [owner:: ryan] [priority:: low] [status:: open]
  > **Why:** Long lead-time paperwork (~1 week for Meta to process). Start now so it's done by the time beta validates. Not a customer blocker — Instagram connect via manual token works today.
  >
  > **Steps:** Full 5-step runbook in [[Projects/Welra/Meta_App_Review_Plan]] Step 1. Have ready: GR3NB LLC business documents, ryan@welra.io, welra.io live URL. Do not start the Meta App Review submission itself — just Business Verification.

---

### 🚫 Do NOT touch (rabbit holes)

| What | Why blocked |
|------|-------------|
| Stripe live mode | Gated on a validated beta user who says they'd pay |
| Etsy resubmit before June 25 | Cool-off period — early submit = auto-deny |
| Meta App Review submission / `NEXT_PUBLIC_INSTAGRAM_OAUTH=true` | After beta user #1 |
| Any Frozen/Archive task below | No user needs it yet |
| R&R TikTok API / FB cross-post | Off the beta-user-#1 path |

---

### ✅ When someone says yes

1. Send them [[Projects/Welra/Sample_Report_Demo.html]] — screenshot it and drop in the DM as "here's what you'd get"
2. Send the CSV export steps for their platform from [[Projects/Welra/CSV_Export_Guide]]
3. When their CSV arrives → hand to Claude → run through the full pipeline → real report same day
4. Sit with them on whether the report is good → that conversation is your real backlog

---

## 📋 Outreach copy — paste-ready (the only thing you need open to do ①)

**The offer (identical everywhere):** Free Pro for an 8-week beta → 50% off 6 months at launch (Founding Seller). Onboarding = upload a CSV (~2 min/week) or connect WooCommerce. Ask in return: 5 min of honest feedback per weekly report. **Never say "AI"** — the benefit is a *clear* read on their shop. Lead founder-as-customer (you run a real Etsy/Printify shop). Fuller context: [[Projects/Welra/Marketing_Campaign_2026-06]].

**Universal rules:** no link in comments · vary the wording every time (identical copy = spam flag, kills a new account) · 1–2 comments/day while warming · mention Welra ONLY if they directly ask what you use · reference what the OP actually said so it reads human.

### A) Find targets — hunt links (reading only, no DM privilege needed)

**⚠️ Reddit-search gotcha (s21):** the `t=` time window only works with `sort=relevance` or `sort=top` — with `sort=new` it's IGNORED, so old threads surface if few recent posts match. Two rules: (1) use **single emotional words** sellers actually type (`no sales`, `slow`, `views`, `dead`) not multi-word phrases — phrases match almost nothing recent; (2) to bound to this week use `sort=relevance&t=week`, NOT `sort=new`.

**Best daily search set (recent + active — paste these):**
- `reddit.com/r/EtsySellers/search/?q=no+sales&restrict_sr=1&sort=relevance&t=week`
- `reddit.com/r/EtsySellers/search/?q=views&restrict_sr=1&sort=relevance&t=week`
- `reddit.com/r/Etsy/search/?q=slow&restrict_sr=1&sort=relevance&t=week`
- `reddit.com/r/shopify/search/?q=no+sales&restrict_sr=1&sort=relevance&t=week`
- `reddit.com/r/ecommerce/search/?q=traffic+no+sales&restrict_sr=1&sort=relevance&t=week`

**Even better for the high-volume subs — skip search, just read /new and eyeball:**
- `reddit.com/r/EtsySellers/new/`
- `reddit.com/r/EtsySellersAdvice/new/`
- `reddit.com/r/Etsy/new/`
- Scan titles for: *"is this normal," "what am I doing wrong," "views but no sales," "should I give up," "slow month."*

**Subreddit pool (most shots on goal):** r/EtsySellers · r/EtsySellersAdvice · r/Etsy · r/shopify · r/ecommerce · r/smallbusiness (filter hard — lots off-topic) · r/Flipping. **Skip r/woocommerce** — too small to produce weekly venting, and Woo sellers aren't the friction-sensitive ICP.

**Filter:** posted last ~7 days · OP is *venting/asking* (not answering) · gripe is about *making sense of their numbers* (skip shipping/fees/bans) · not selling anything.

### B) Give-first COMMENTS (template #2 — warms the account, no link, no pitch)
Pick the one that fits the thread:

1. **"Views up but no sales / stats don't add up"**
   > Views without sales almost always comes down to one of three things: the photo isn't stopping the scroll, the price/shipping is scaring people at checkout, or the traffic is the wrong audience (often ad/off-site views that were never going to buy). I'd pull your top 3 viewed listings and check conversion on each separately — usually one is dragging the average down and it's fixable. The overall "views vs sales" number hides which listing is the actual problem.

2. **"Overwhelmed — which stats matter?"**
   > Honestly most of the dashboard is noise week to week. The five I actually track: revenue vs last week, order count vs last week, top 3 products by sales, conversion rate if the platform shows it, and repeat-customer count. That's it. I write them down every Monday — the *trend* over a few weeks tells you way more than any single day, and it stops you reacting to random spikes.

3. **"Is X views/sales good? Am I doing well?"**
   > Comparing to other shops' numbers is a trap — different price points, categories, and ad spend make them meaningless. The only benchmark that matters is *you last month*. Are revenue, orders, and conversion trending up vs your own last 4 weeks? A shop doing 5 sales/day at $80 is crushing one doing 20/day at $8.

4. **"Sales dropped this week, don't know why"**
   > Before assuming it's you, separate the two causes: did fewer people *show up* (traffic down) or did the same traffic *stop buying* (conversion down)? Totally different problems — traffic down is usually search ranking or seasonality, conversion down is usually price, photos, or a competitor undercutting you. Check which number actually moved first; most people panic and change the wrong thing.

5. **"How often should I check stats?"**
   > Daily checking will drive you insane — single days swing wildly and you'll act on noise. Once a week, same day, is plenty. I do Monday morning: week vs the week before, note anything that moved >~20%, ignore the rest. The discipline is the *trend*, not the daily wiggle.

### C) DIRECT DMs (template #3 — highest yield; send 5/wk once DMs unlock)
Match the variant to their complaint, change the bracketed line:

- **Generic:**
  > Saw your post about [their specific frustration]. I'm building exactly this — a tool that emails you one clear weekly report on your shop instead of you digging through tabs. Want a free one based on your last month of sales? You export a CSV (2 min), I send back a real report, and you tell me if it's any good. No signup, not selling anything.

- **"Views but no sales":**
  > Saw your post about views not turning into sales — that gap is exactly the thing I got fed up staring at on my own Etsy/Printify shop. So I built a tool that emails me one clear weekly read instead: what sold, what changed vs last week, what's worth doing next. Want a free one off your last month of sales? You export a CSV (2 min), I send back a real report, you tell me if it's any good. Not selling anything.

- **"Dashboard overwhelming":**
  > Saw your post about the analytics being a maze of clicks — same reason I built something for my own shop. It emails me one clear weekly summary so I never open the dashboard. Happy to make you a free one off a CSV of your last month and you tell me if it's useful — no signup, not selling anything.

### D) When they ask "what do you use to track this?"
That's the opening — and only then:
> I actually built a little tool for my own shop that emails me this weekly — happy to share if it'd be useful.

**📎 Demo asset (ready now):** [[Projects/Welra/Sample_Report_Demo.html]] — a true-to-product sample weekly report (synthetic Etsy shop, faithful to the real renderer + honest voice). Open in a browser → **screenshot it** to drop into a DM/comment when someone bites, framed as *"here's a sample of what you'd get."* Synthetic data, clearly labeled — never present it as a real customer.

**The yes-path:** a yes → the free CSV report IS the demo + onboarding. Send them the sample above to show the format, then generate their real one at welra.io/scan (instant, ephemeral) or hand their CSV to Claude to run through the full pipeline. **To tell them how to export their CSV → [[Projects/Welra/CSV_Export_Guide]]** (exact per-platform steps, verified against official docs — Etsy / Shopify / WooCommerce / generic; paraphrase it into the DM, don't paste the whole thing).

### E) If they compare you to another tool / ask "how's this different from [X]?"
Most "competitors" are **storefront/CRO audit tools** (e.g. CROtrustify) — they crawl your *public website* once and grade trust signals; they never see whether you actually sold anything. Welra is the opposite end: it reads your *real sales data every week*. Two lines that land:

- **Snapshot vs. movie:**
  > Those tools scan your storefront once and grade it. Welra's the opposite — it reads what *actually sold* and what moved, every week. A scan is a snapshot; this is the movie of your shop.

- **Reads real sales, not the window display:**
  > The audit tools only look at your public site — they can't tell if you made a single sale. Welra works off your actual orders, so it tells you what sold, what changed vs last week, and what's worth doing next.

- **Multi-channel (if they're not on Shopify):**
  > A lot of those are Shopify-only. Welra works off a CSV from any platform — Etsy, Printify, whatever you sell on — so you're not locked out.

**Note:** keep the no-leaderboard stance — *"the only benchmark that matters is you last month."* Some audit tools sell "compare to competitors"; Welra deliberately doesn't, and that's a trust point, not a gap.

---

## This Week (the live queue — ranked T0→T3)

> **This is the only list that matters.** Everything below the **Archive** line is cold storage — history + someday/maybe, not a queue. Don't read it to plan; read it to look something up.
> **Scoring rule:** does this task *get, keep, or unblock a paying customer?* — T0 = yes, do now · T1 = first-5-min path a real user hits · T2 = reliability/revenue switch for T0/T1 · T3 = **frozen until ≥3 active users**.
> **The honest bottleneck (session 19): 0 customers, 0 revenue, Stripe still in TEST mode after ~18 build sessions.** The loop's job this week is to change that — not to write more product code. Re-rank with this rule at the start of every session; promote at most 1–2 items in from the Archive.

### T0 — gets / unblocks a paying customer
- [ ] **Recruit the first 3–5 beta users** — via CSV / WooCommerce / Printify. **No Etsy API needed** (playbook: Printify covers Etsy POD sales; any seller joins by weekly CSV export). This is THE #1 task — every code task below is worthless until it's done. Use the give-first cadence + 20 DMs in [[Projects/Welra/Marketing_Campaign_2026-06]]. [owner:: ryan] [priority:: high] [status:: open]
- [ ] **Onboard beta user #1 end-to-end & sit with their first real report** — first time Welra runs on outside seller data. Judge it cold: accurate? honest? worth $19+/mo? This conversation generates your *real* backlog (which replaces most of the Archive). [owner:: ryan+claude] [priority:: high] [status:: open] — gated on the task above
- [ ] **[BUG s22, HIGH — go-live blocker for the report itself] Report emails rendered raw markdown — FIXED in working tree, needs API deploy.** Dogfooding R&R surfaced it: the synthesis model emits markdown (`**bold**`, `*italic*`, `#`/`##` headings, `-` bullets, `---` dividers), the synthesis system prompt never forbids it, and `reportRenderer.ts` inserted `${synthesis}` raw into a `white-space:pre-line` div with NO markdown→HTML conversion → every real report email would show literal asterisks/dashes. Zero users have seen it yet, so fix BEFORE beta user #1 gets a report. **FIXED (s22):** added `renderSynthesisHtml()` (bold/italic/headings/bullets/dividers) in `reportRenderer.ts` + switched the synthesis div to use it; also fixed an adjacent UTC date bug (`new Date(weekStartStr)` showed "Week of May 31" for a June 1 start → parse as local `T00:00:00`). API `tsc --noEmit` green; does NOT affect eval (eval scores raw text, not the renderer). **Undeployed** — needs `railway up --service welra` before any real report sends. [owner:: claude+ryan] [priority:: high] [status:: open — fixed, awaiting deploy]
- [ ] **[s22] Dogfood + sample-report assets shipped (web undeployed).** Built `apps/api/scripts/dogfood-report.ts` (runs the REAL prompts+renderer on any dataset, no DB) → generated two reports to vault: `Dogfood_Sample_Report.html` (realistic $4,200 Etsy week — the showable demo) and `Dogfood_RR_Real_Report.html` (R&R's real $0 week — proof the pipeline handles a quiet/first week). Added public demo `apps/web/public/sample-report.html` (in-report links neutralized) + a `welra.io/sample` page (`apps/web/src/app/sample/page.tsx`) embedding it with a beta CTA. Web `next build` green, `/sample` is a static route. **Undeployed** — needs `npx vercel deploy --prod`. NOTE: R&R itself has $0 sales / 0 orders / 3 IG followers (Etsy banned) so it can't be a *showable* dogfood — the demo uses sample data, labeled as such. [owner:: ryan] [priority:: medium] [status:: open — built+validated, awaiting web deploy]
- [ ] **[DEFERRED from arch-review s22] Commit the applied-but-uncommitted migrations + working tree.** The 2 migrations (`add_leads.sql`, `add_reports_email_sent_at.sql`) are ALREADY applied to prod Supabase (DB-verified s22) but uncommitted, alongside ~24 other uncommitted files from prior sessions. No clean git rollback point exists and migration history lives only in the DB. Commit the working tree (ideally before/right after the next deploy) so there's a recovery point and the schema files match version control. [owner:: claude] [priority:: high] [status:: open]
- [ ] **[DEFERRED from arch-review s22, LOW] `reportGenerator.ts` final reports UPDATE doesn't check its returned error** (~line 770). Harmless today (all columns exist, DB-verified), but the email sends BEFORE this update, so any future column drift would silently leave a report stuck `generating` with the email already out. Add a `const { error } = await supabase.from('reports').update(...)` check + log. [owner:: claude] [priority:: low] [status:: open]
- [ ] **Etsy approval — fix the REAL risk, not the wording.** The application is DONE and as good as it gets (verbatim copy + de-AI'd site + trademark disclaimer all shipped — see [[Projects/Welra/Etsy_API_Approval_Strategy]]); do NOT re-tinker it (negative EV). You also can't submit before **2026-06-25** (cool-off — early/duplicate submits auto-deny). ✅ Ban-reason dig DONE (s19, verified in the Etsy console): the R&R *shop* is active/good-standing (38 listings) — only the `rust-and-rainbow` *API app* is Banned, with no obtainable reason. 🚩 Both apps show "Banned" in the console, BUT the two denial emails differ in severity (verified s19): R&R's is terminal ("can't reconsider" — dead, leave it); **Welra's is a SOFT, reviewable denial** with specific fixable reasons (use-case clarity + third-party-app impression) and NO "can't reconsider." Welra's Etsy path is ALIVE, and the cited reasons are exactly what the de-AI'd site + verbatim copy fix. 📤 DONE 2026-06-15 (s19): emailed developer@etsy.com (builder-voice, no AI; phone 503-502-5360) to confirm reapply mechanics (new app vs reactivate) + make the compliant-business case — **awaiting reply (~5–6 biz days per prior threads; watch ryan@welra.io)**. Next, per their guidance: submit ONE clean app with the verbatim copy on/after 6/25. Don't dodge the linkage. Still NOT a customer blocker — CSV/Printify serve Etsy sellers today. Reminder `etsy-api-resubmit-reminder` fires 9am Jun 25. ⚠️ Etsy API is a friction-reducer, NOT a customer blocker. [owner:: ryan] [priority:: high] [status:: open]

### T1 — the first-5-minute path a real user walks
- [ ] **Verify the live onboarding path with a real CSV** — drop a real Etsy/Shopify export at welra.io/scan AND through the in-dashboard uploader; confirm the instant report fires, reads honest, and the email actually sends (`REPORT_DRY_RUN` is now false). This exact path has never been run with real outside data. [owner:: ryan+claude] [priority:: high] [status:: open]

### T2 — revenue switch (a gate, not yet)
- [ ] **Flip Stripe to live mode** — ONLY after beta user #1 is validated and says they'd pay. Recreate products/prices, swap sk_live/pk_live/price IDs in Railway+Vercel, create the live webhook via API, verify all 6 STRIPE_PRICE_* match live IDs. [owner:: ryan] [priority:: high] [status:: blocked — gated on a validated beta user]
- [ ] **[BUG s20, HIGH] Platform-connection caps are marketing copy only — NOT enforced.** Homepage sells Starter=1 platform / Pro=up to 3 / Growth=unlimited ([page.tsx:20-75]), but no API route gates connections by `plan`. The `plan` column exists (schema.sql) + Stripe webhook sets it + reportGenerator reads tier for *report depth*, yet `integrations.ts` / `oauth.ts` have ZERO limit logic — a $19 Starter user can connect all 6 platforms today. Harmless during free beta (uncapped by design), but a revenue leak the moment you charge. Fix at go-live: enforce a per-plan connection cap in the connect handlers (count active `integrations` rows for the user vs plan limit; reject with an upgrade prompt). Verify by connecting a 2nd platform as a Starter test user. [owner:: claude] [priority:: high] [status:: open — gated with Stripe go-live]
- [x] **[DECISION s20] Instagram is NOT mom-and-pop-friendly until Meta App Review clears.** The one-click "Log in with Facebook" button exists but is gated off (`NEXT_PUBLIC_INSTAGRAM_OAUTH=true`) pending Meta App Review + Business Verification; the only live path is the manual long-lived-token + IG-business-account-ID paste form (`ConnectInstagramForm`) — too technical for a casual seller. Positioning call: keep Instagram, but do NOT lead with it and keep it out of beta-user-#1 onboarding. Lead with CSV (zero auth), then Woo/Printify/Shopify. **DONE in UI (s20):** Instagram pulled out of the sales-platform grid in `integrations/page.tsx` into its own "Optional — add your Instagram engagement" section, framed as skippable; sales-grid heading now reads "Connect a sales platform … one is enough to get started." tsc + web build green. [owner:: ryan] [priority:: medium] [status:: done]
- [ ] **[FUTURE s20] Apply for Meta App Review + Business Verification** so the one-click "Log in with Facebook" Instagram connect can ship (then flip `NEXT_PUBLIC_INSTAGRAM_OAUTH=true`). Long lead-time paperwork, NOT a customer blocker — same class as the Etsy API (manual token + concierge path serves IG today). Pre-reqs: business verification for GR3NB LLC; submit the use-case for the exact scopes the fetcher uses (`instagram_basic`/`pages_show_list`/`instagram_manage_insights` — derive least-privilege from `oauth.ts`/the IG fetcher, do NOT request "all"); apply the no-"AI" platform-copy playbook ([[Knowledge_Base/feedback_platform_api_applications]]). Refresh `META_ACCESS_TOKEN` before 2026-06-25 regardless (separate, already noted). Do AFTER beta user #1 — friction-reducer, not a gate. **Full step-by-step plan: [[Projects/Welra/Meta_App_Review_Plan]]** (incl. must-fix Step 0: align Graph version — oauth.ts is v21, fetcher is v22). [owner:: ryan] [priority:: low] [status:: open]
- [ ] **[FUTURE s21] WooCommerce one-click connect via `/wc-auth/v1/authorize`** — replace the current manual REST-API-key paste (`access_token = "ck_…:cs_…"`, `shop_id = store URL`) with WooCommerce's built-in authorize-redirect flow: seller clicks Connect → bounced to their own WP admin → approves **read** access to orders & products → Woo auto-generates the keys and POSTs them back. ~1 day of work; NO published WordPress plugin (that path = wordpress.org marketplace review + PHP maintenance + per-theme support = a multi-week trap, explicitly rejected). NOT a customer gate — current key-paste flow works + is verified, the beta offer leads with CSV (zero auth), and Woo sellers are the *least* friction-sensitive segment (they already self-host WP and generate keys for other tools). Same class as Etsy API / Meta App Review: build only when a real Woo user needs it. [owner:: claude] [priority:: low] [status:: open]
- [ ] **[INFRA s20] Add root-domain SPF for welra.io** — do during the "send as ryan@welra.io" DNS work. welra.io's root has NO SPF, so PrivateEmail sends from ryan@welra.io get SPF=none and pass DMARC (`p=reject`) by DKIM alone — fragile. Fix: TXT on `@` = `v=spf1 include:spf.privateemail.com ~all` (leave send.welra.io alone). Found via Google DMARC aggregate report (s20) — reports are healthy, no spoofing. Detail in [[project-welra-email-monitoring]]. NOT a beta blocker. [owner:: ryan] [priority:: low] [status:: open]

- [ ] **[MARKETING s21] Bake the CRO-audit differentiation into the site + marketing + a competitive doc.** Adjacent tools like **CROtrustify** ($24.99 one-time / $11.99-mo, Shopify-only) crawl your *public storefront* once and grade trust signals (TrustScore) — they're CRO/audit tools, NOT a weekly sales-report competitor; they never see whether you sold anything. Three jobs, AFTER beta user #1 (positioning, not a customer gate): (1) **Site copy** — add a "snapshot vs. movie / we read your real sales, not your window display / multi-channel not Shopify-only" angle somewhere on the homepage or a comparison section (don't lead with it; keep the no-leaderboard stance — "the only benchmark that matters is you last month"). (2) **Marketing materials** — fold the same lines into blog/FAQ/outreach (DM objection-handler already live in [[Projects/Welra/Tasks]] §E). (3) **Competitive analysis doc** — start `Projects/Welra/Competitive_Landscape.md` cataloguing adjacent tools (CRO/audit, multi-channel dashboards, Etsy-stats tools), where each sits in the funnel, and Welra's defensible lane (real ongoing sales data + multi-channel + honesty/no-benchmark). Market-validation note: a stranger independently betting that overwhelmed sellers pay $12–25/mo for an automated no-fuss "make my numbers make sense" tool = the Welra thesis confirmed. [owner:: claude] [priority:: low] [status:: open]
### Frozen (T3 — do NOT build until ≥3 active users)
Referral friend-side coupon · referral retry cron · referral attribution race · resubscribe UI · Meta/Instagram OAuth app · Google Sheets bridge · Make webhook · OG/social images · dead `sendDay2Email` · Tailwind `slate` rename · Puppeteer consolidation · onboarding greeting capture · lazy-init Resend. *Every one serves customers you don't have yet. They live in the Archive below until a real user actually needs them.*

---

## Archive — full task history (cold storage; the ranked "This Week" above is the live queue)

### Now (historical — superseded by This Week)

- [x] **Cron schedule verified** — there is NO 6am job; the report scheduler is `0 23 * * 0` = **Sunday 23:00 UTC** (reportSchedulerCron.ts). Done 2026-06-14 (s15). A one-time scheduled task `welra-cron-check` is armed (fireAt 2026-06-14T23:30:00Z, app must be open) to pull welra-service logs ~30min after the cron and report pass/fail (knows R&R's 6/8 week is skipped + DRY RUN expected). [owner:: claude] [priority:: high] [status:: done]
- [ ] **Verify R&R report accuracy vs Printify** — UPDATE 2026-06-14 (s15): `$0/0` PROVEN CORRECT as a code matter (audited via railway run + decrypted token: right connection/shop 27483352, valid token, fetcher math/window/`connected`-filter all correct, **0 orders in the Printify account**). Remaining = confirm whether R&R actually had Etsy sales for wk 6/8 (Printify only shows POD orders IT fulfills, so 0 ≠ no sales). If real sales existed → it's an Etsy↔Printify sync gap on R&R's side (needs Etsy API, blocked till 6/25), NOT a Welra bug. Gates flipping dry-run. [owner:: ryan] [priority:: high] [status:: open]
- [x] **Redeploy API to activate synthesis_text persistence** — DONE 2026-06-14 (s15). Confirmed already live (same commit as the verified card-meta/unsubscribe/referral endpoints); regenerated R&R `bbf784df` → `synthesis_text` populated (3924 chars). API also re-deployed this session with the greeting field (`8776add8`, clean boot). [owner:: claude] [priority:: medium] [status:: done]
- [x] **Disconnect the redundant ryantest4 Printify connection** — DONE 2026-06-14 (s15) by Ryan (`DELETE /integrations/45b5234a` seen in logs). [owner:: ryan] [priority:: low] [status:: done]
- [x] **`api.welra.io` LIVE** — DONE 2026-06-14 (s17). Ryan added CNAME (`api`→`wqdv6trf.up.railway.app`) + the required `_railway-verify.api` TXT (Railway needs BOTH — CNAME routes, TXT verifies ownership or it 404s). Cert issued ~210s. Claude flipped `API_URL` (Railway) + `NEXT_PUBLIC_API_URL` (Vercel) → `https://api.welra.io`, redeployed web (build-time bake), verified health 200 + valid SSL + bundle has the new host; old railway domain still 200. [owner:: ryan+claude] [priority:: medium] [status:: done]
- [x] **Flip `REPORT_DRY_RUN=false`** — DONE 2026-06-14 (s17): set false in Railway, API redeployed, health 200. Gate satisfied (R&R's 6/08 report already generated clean: printify source, no anomaly, 3924-char synthesis). ⚠️ Tonight's cron SKIPS R&R (6/08-week row exists → UNIQUE insert fails); first REAL email = wk 6/15 → Mon 6/22. June-22 check scheduled (`welra-rr-first-report-delivery-check`). [owner:: ryan+claude] [priority:: medium] [status:: done]

## Greeting field (session 15) — follow-ups

- [x] **Dedicated greeting field SHIPPED + DEPLOYED 2026-06-14 (s15)** — fixed brand-name truncation (`name.split(' ')[0]` greeted "Rust and Rainbow" as "Rust"). Added nullable `customers.nickname` (single-word col, survives the `as Customer` cast; migration applied live), `Customer.nickname`, shared `lib/greeting.ts` `greetingName()` (nickname→name→"there") across all 9 sites (+1 dead var removed), `auth.ts` GET/PATCH `/me`, settings "What should we call you?" field. `→name` fallback fixes ALL existing customers immediately. tsc+build green, arch-review 0 blockers, compiled tests 10/10, committed `0f8d175`, deployed (railway `8776add8` + vercel). [owner:: claude] [priority:: medium] [status:: done]
- [ ] [greeting follow-up s15] Capture the greeting name at the **welcome/onboarding step**, not just Settings — there's no onboarding form component yet, so nickname is only settable post-signup in Settings. Add it to the welcome flow when one exists (falls back to `name` until then, so no breakage). [owner:: claude] [priority:: low] [status:: open]
- [ ] [greeting follow-up s15] Reconcile email copy "your first report arrives **this Monday at 6am**" (emailService welcome/day2) vs the actual scheduler **Sunday 23:00 UTC** — the "6am Monday" promise doesn't match the cron. Decide the real send time + fix the copy (or the schedule). [owner:: claude] [priority:: low] [status:: open]
- [ ] [arch-review RISK s15, low/latent] Root `npm run build` would fail on a **fresh clone** — workspaces order is `["apps/*","packages/*"]` so api compiles before packages/types, and api's tsconfig maps `@welra/types`→`dist` (gitignored). Deploys are SAFE (Dockerfile builds types→api in order; web resolves @welra/types from src). Fix if desired: reorder workspaces `packages/*` first, or point api tsconfig at `src` like web. [owner:: claude] [priority:: low] [status:: open]
- [ ] [cleanup s15] `emailService.sendDay2Email` has **no caller** anywhere — pre-existing dead code; remove or wire into the onboarding sequence. [owner:: claude] [priority:: low] [status:: open]

## Go-live + content (session 17)

- [x] **Reports unblocked** (`REPORT_DRY_RUN=false`) + **api.welra.io cutover** — DONE 2026-06-14 (s17). See "Now" entries above. [owner:: claude] [priority:: high] [status:: done]
- [x] **Blog + FAQ shipped** — DONE 2026-06-14 (s17): `/faq` (FAQPage JSON-LD, 9 Qs), `/blog` + `/blog/[slug]` (Article JSON-LD + OG), posts hand-authored in `apps/web/src/app/blog/posts.tsx`. Post 1 `market-analysis-small-business-advantage` (cited: BLS / Brynjolfsson 2011 / McKinsey / SMB Group / SBE Council; founder voice), post 2 `how-to-read-your-etsy-stats` (Etsy Help + eRank). Footer links Blog+FAQ. Committed `15b1a1d`+`e8e7506`, pushed, deployed, verified live + schema. [owner:: claude] [priority:: medium] [status:: done]
- [x] **Weekly content calendar created** → [[Projects/Welra/Content_Calendar]] (19 topics / 6 rotating pillars + cadence + published tracker). [owner:: claude] [priority:: low] [status:: done]
- [x] **June-22 first-real-report delivery check scheduled** — one-time task `welra-rr-first-report-delivery-check` (fireAt 2026-06-22T15:00Z); checks Supabase report row AND the Railway "Sending report email…" log (not status alone). [owner:: claude] [priority:: high] [status:: done]
- [ ] **[BUG s17, HIGH] reportGenerator marks `status='delivered'` + sets `delivered_at` REGARDLESS of actual email send** — dry-run AND unsubscribe paths both fall through to the same 'delivered' update (`reportGenerator.ts` ~L723-748). The DB row can't prove delivery; only the Railway "Sending report email…" log can. Fix: set 'delivered' only after a successful `sendReportEmail`; use a distinct status (e.g. 'generated'/'suppressed') for dry-run/unsubscribe so dashboards + the June-22 check can trust the row. [owner:: claude] [priority:: high] [status:: open]
- [ ] **Weekly blog cadence** — publish the next queued [[Projects/Welra/Content_Calendar]] topic each week (rotate pillars; lead each month with a Platform-guide for SEO). Optionally a Monday recurring reminder/cloud agent. Also: syndicate each post to LinkedIn + Medium with a canonical link back to welra.io/blog. [owner:: ryan+claude] [priority:: low] [status:: open]

## Critical Path (in order)

- [x] Referral MVP — plumbing SHIPPED 2026-06-13 (s14): `customers.referral_code` + `referrals` table (RLS-enabled), `GET /referral/me` + `POST /referral/attribute`, `ReferralTracker` (root layout: ?ref→30d first-touch cookie→attribute on signin), Week Card `/card/[id]` invite link `welra.io/?ref=CODE` + "give a month, get a month" CTA. Deployed + verified (R&R code YBE5H6). [owner:: claude] [priority:: high] [status:: done]
- [x] Referral REWARD wiring — SHARER side ("get a month") SHIPPED 2026-06-14 (s16): (b) `handlePaymentSucceeded` flips `referrals.status` pending→qualified on the friend's first *real* (amount_paid>0, non-trial) payment via `qualifyAndRewardReferral`; (c) sharer free-month credit AUTOMATED (not manual) — `creditReferrerOneMonth` writes a negative `customers.createBalanceTransaction` (one month of the referrer's live plan price, annual÷12) then flips qualified→rewarded. Idempotent under duplicate/renewal webhooks via conditional `UPDATE ... WHERE status='pending'`. tsc+build green, arch-review clean (0 blockers). [owner:: claude] [priority:: high] [status:: done]
- [ ] Referral REWARD wiring — FRIEND side ("give a month"): (a) first-month-free coupon auto-applied at checkout when referred. PENDING product decision: does it stack on the existing 14-day trial or replace it, and the coupon shape (100%-off-once). Needs a Stripe test-mode coupon created + `discounts:[{coupon}]` in checkout.sessions.create gated on a pending referral for the user. [owner:: claude] [priority:: high] [status:: open]
- [ ] [arch-review RISK s16] Referral reward: a `qualified`-but-not-`rewarded` row (referrer churned, or transient Stripe error during credit) has NO automatic retry — webhook returns 200 so the event never re-delivers and renewals are no-ops (status already moved off `pending`). Add an ops cron: select `referrals` where `status='qualified' AND rewarded_at IS NULL` older than ~1h, re-run `creditReferrerOneMonth`. [owner:: claude] [priority:: high] [status:: open]
- [ ] [arch-review RISK s14] Referral attribution can be lost on the signup-trigger race — ReferralTracker clears the cookie even when `/referral/attribute` returns a transient FK failure (customers row not yet created). Fix: only clear the cookie on a definitive outcome (attributed:true OR reason∈{self,already_attributed,unknown_code}); keep it on insert error. [owner:: claude] [priority:: medium] [status:: open]
- [ ] [arch-review DEFERRED s14] Referral fraud handling (self-referral via 2nd account, etc.) — mitigated for MVP by manual + payment-gated reward; revisit before scaling. [owner:: claude] [priority:: low] [status:: open]
- [ ] [DEFERRED from arch-review 2026-06-13 s14] Resubscribe UI — `/unsubscribed` tells users to reply to an email to re-enable; re-enabling currently needs a manual clear of `customers.unsubscribed_at`. Add a Settings toggle (email on/off) + an API route to set/clear `unsubscribed_at`. [owner:: claude] [priority:: high] [status:: open]
- [ ] Apply Supabase migration `ALTER TABLE customers ADD COLUMN unsubscribed_at TIMESTAMPTZ` BEFORE flipping `REPORT_DRY_RUN=false` — unsubscribe enforcement silently no-ops (graceful, no crash) until the column exists. [owner:: ryan+claude] [priority:: high] [status:: open]
- [x] Flip API host + REDEPLOY web — DONE 2026-06-14 (s17): `API_URL`/`NEXT_PUBLIC_API_URL` → `https://api.welra.io`, web redeployed, baked value confirmed in client bundle. [owner:: ryan+claude] [priority:: high] [status:: done]
- [ ] Regenerate the R&R report (or wait for the next run) so its stored `html_content` picks up the fixed links — existing reports keep the old dead api.welra.io / raw-PNG links because the HTML is frozen at generation time. [owner:: claude] [priority:: medium] [status:: open]

- [x] Submit Etsy developer application — DONE 2026-06-10 (session 8): keystring + shared secret received and stored in Railway (ETSY_CLIENT_ID/SECRET). ⚠️ Keystring fails the openapi-ping (403 "not found or not active") — app likely still pending activation on Etsy's side, or typo; owning account is NOT the Chrome-logged-in Etsy account (that one has only the BANNED rust-and-rainbow app). Verify once active. [owner:: ryan] [priority:: high] [status:: in-progress]
- [x] Submit Shopify Partner application — DONE 2026-06-10 (session 8): client ID + secret + 6-mo automation token (expires 2026-12-10) received; stored in Railway (SHOPIFY_CLIENT_ID/SECRET, SHOPIFY_CLI_PARTNERS_TOKEN). [owner:: ryan] [priority:: high] [status:: done]
- [ ] Ryan: confirm BOTH app settings list these exact redirect URLs — Etsy callback `https://welra-production.up.railway.app/integrations/etsy/callback`, Shopify allowed redirection URL `https://welra-production.up.railway.app/integrations/shopify/callback` (log into the owning accounts; Claude can verify via Chrome once logged in) [owner:: ryan] [priority:: high] [status:: open]
- [ ] Verify Etsy keystring activates (Claude: re-run openapi-ping) — re-checked 2026-06-11: still 403. Explained by the API application DENIAL (2026-06-10); the keystring won't activate until the 6/25 reapplication is approved. Re-ping after approval. [owner:: claude] [priority:: high] [status:: blocked]
- [x] Build CSV upload + format auto-detection — DONE 2026-06-10: POST /uploads/csv (JWT-authed), Etsy/Shopify/Woo/generic auto-detect, normalized orders in private storage, wired into report generation, deployed + smoke-tested. Parser verified against all 3 formats. **First working commerce ingestion path.** [owner:: claude] [priority:: high] [status:: done]
- [ ] Recruit 3–5 beta users on free accounts BEFORE Stripe live mode. ⚠️ CORRECTION (2026-06-10): etsy/shopify/woocommerce/stripe integration modules are 5-line STUBS returning null — **CSV upload (shipped tonight) is the ONLY working ingestion path**. Beta users from any platform can join via weekly CSV export. Ask Van Westendorp pricing questions. [owner:: ryan] [priority:: high] [status:: open]
- [x] Implement WooCommerce integration for real — DONE 2026-06-10: REST v3, week + prev-week order aggregation (completed/processing only), top products, unique customers, AOV. Connection contract: `access_token = "ck_…:cs_…"`, `shop_id = store URL`. Verified against mocked fixtures; subdirectory WP installs supported. ⚠️ Verify `status[]` array param against the first real beta store. [owner:: claude] [priority:: high] [status:: done]
- [x] Etsy + Shopify OAuth connect/callback flows — DONE 2026-06-10 (session 8): GET /integrations/{etsy|shopify}/connect (JWT) + /callback; PKCE + Redis state for Etsy, HMAC verify for Shopify; tokens encrypted; Etsy token_expires_at tracks the 90-day refresh horizon so token-health cron doesn't false-expire 1-hour access tokens [owner:: claude] [priority:: high] [status:: done]
- [ ] Implement real Etsy data fetcher (receipts/listings aggregation + access-token auto-refresh) — build once the keystring activates so it can be tested against the live API [owner:: claude] [priority:: high] [status:: blocked]
- [x] Implement real Shopify data fetcher — DONE 2026-06-11 (session 9): Admin REST 2025-01, week + prev-week paid-order aggregation (excludes cancelled/test/unpaid), top products, cart-abandonment from abandoned-checkout counts, Link-header pagination, store-local day bucketing via shop.json iana_timezone. Sessions deliberately absent (needs restricted analytics scope — ShopifyWeekData fields now optional). ⚠️ Verify date bucketing + endpoints against the first dev-store install. [owner:: claude] [priority:: high] [status:: done]
- [x] Shopify: "Protected customer data access" — DONE 2026-06-12 by Ryan, verified by Claude in-browser: protected data selected w/ reasons, all optional fields (name/email/phone/address) correctly UNselected, data-protection questionnaire 9/9. "Draft" badge = not submitted for App Store review, which is only needed for public distribution — dev-store access is active now. [owner:: ryan] [priority:: high] [status:: done]
- [x] **Shopify scope blocker FIXED + RELEASED 2026-06-12** (Ryan approved): version `welra-3` is Active with scopes `read_orders,read_products`, embedded=false, redirect URL intact — verified in the Dev Dashboard. Config now lives in `shopify.app.toml` (repo root); future changes deploy via `npx shopify app deploy --allow-updates` (CLI dropped `--force`). Shopify fetcher verification now only needs a dev-store install. [owner:: ryan+claude] [priority:: high] [status:: done]
- [x] Build plain-English "find your connection info" walkthroughs for every integration on /dashboard/integrations — DONE 2026-06-13 (session 13): reusable `Walkthrough.tsx` Server Component (native `<details>`/`<summary>`, zero client JS, accessible) renders an expandable "Show me step-by-step" numbered guide inside every platform card (Etsy, Shopify, WooCommerce, Printify, Instagram, CSV). Each menu path LIVE-VERIFIED against official docs via Chrome before deploy: Printify (corrected — official flow requires a developer-contact-email field first, choose access scopes, tokens last 1 yr), WooCommerce (exact path confirmed + added the permalinks≠"Plain" gotcha that breaks the REST API), Etsy CSV (Shop Manager→Settings→Options→Download Data→Orders confirmed). Instagram framed honestly (business-account+linked-Page prereq, then concierge "reply and we'll do the token with you" — didn't fabricate Meta Graph paths). Etsy revoke path softened to the in-app Disconnect button (couldn't verify exact Etsy menu). Screenshots deliberately SKIPPED — they'd go stale as platform UIs change; verified text paths age better. tsc+build green, deployed to www.welra.io, live route smoke-tested (307→/login). [owner:: claude] [priority:: high] [status:: done]
- [x] Dashboard UI: "Connect Etsy" / "Connect Shopify" buttons — DONE 2026-06-11 (session 9): /dashboard/integrations page with Etsy OAuth button, Shopify shop-domain form, WooCommerce key/secret form (bonus — it's the working beta path), disconnect buttons, OAuth result banners on /dashboard and /dashboard/integrations. Guards: no-customer-row users routed to activation (FK seam), Etsy card carries "finishing review" caption until the keystring activates. Deployed to welra.io. [owner:: claude] [priority:: high] [status:: done]
- [x] Web: /dashboard/reports and /dashboard/settings pages — DONE 2026-06-11 (session 9; this line was stale). Both shipped (list/detail + settings — see Marketing & Brand section), all dashboard header links resolve. [owner:: claude] [priority:: medium] [status:: done]
- [ ] Web cosmetic: disconnecting an integration shows a red "error" pill (DELETE sets status='error'; enum has no 'disconnected'). Consider a dedicated status or copy tweak. [owner:: claude] [priority:: low] [status:: open]
- [ ] Run first real-data report generation for a beta user; verify accuracy against their dashboard [owner:: claude] [priority:: high] [status:: open]
- [ ] Switch Stripe to live mode: recreate products/prices, swap sk_live/pk_live/price IDs in Railway + Vercel, create live webhook endpoint via API, VERIFY all 6 STRIPE_PRICE_* env vars match live price IDs [owner:: ryan] [priority:: high] [status:: blocked]
- [ ] Flip REPORT_DRY_RUN=false in Railway (env schema now validates strictly) + confirm a real report email sends [owner:: claude] [priority:: high] [status:: blocked]

## Pre-Live Hardening

- [x] **LAUNCH-CRITICAL FIX 2026-06-12: Resend welra.io domain was NEVER verified** (status "not_started" since 6/6 — the `send` MX record was missing; masked by dry-run, exposed by the first real send via Supabase SMTP: "550 domain not verified" in auth logs; every welcome/report email would have failed at launch). Fixed: Ryan added MX rows in Namecheap (Custom MX preserving privateemail inbox), Claude triggered verify via API → **verified**, real test send from auth@welra.io delivered. Pattern #35 logged: "records added" ≠ "verified" ≠ "can send". [owner:: ryan+claude] [priority:: high] [status:: done]
- [x] Supabase custom SMTP + branded auth email templates — DONE 2026-06-12 (Ryan): sends as "Welra <auth@welra.io>" via Resend; 5 templates rebranded (Claude corrected HTML in 4). /forgot-password + /reset-password pages built same day (login's link was a 404). [owner:: ryan+claude] [priority:: high] [status:: done]

- [x] GitHub Actions CI + PAT `workflow` scope — DONE 2026-06-12: Ryan fixed the PAT; Claude pushed all 17 queued commits (incl. ci.yml) to rcn723/welra. First run FAILED (`@welra/types` pointed "types" at gitignored dist — stale local artifacts masked it for months); fixed by resolving the type-only package from src, verified in a fresh-clone CI reproduction, **rerun GREEN (commit afb652f)**. Pattern #34 logged. Note: git push still does NOT deploy — Railway auto-deploy wiring is the next task. [owner:: ryan] [priority:: high] [status:: done]
- [x] Ryan: Supabase custom SMTP via Resend — DONE 2026-06-12 (duplicate of the completed item above): auth emails send as "Welra <auth@welra.io>", lifts the ~2/hr Supabase email limit. [owner:: ryan] [priority:: high] [status:: done]
- [x] Press kit: founder name removed from welra.io/press (anonymous founder-as-seller framing, GR3NB LLC + ryan@welra.io contact kept) — Ryan's request 2026-06-12; deployed + verified live. [owner:: claude] [priority:: medium] [status:: done]
- [ ] Wire Railway GitHub auto-deploy (Settings → Source) so git push triggers rebuild [owner:: claude] [priority:: medium] [status:: open]
- [x] Sentry wiring shipped 2026-06-10 (lazy, activates on SENTRY_DSN; boot log confirms). Remaining: Ryan creates Sentry account + sets SENTRY_DSN in Railway (tracked below in arch-review section). [owner:: claude] [priority:: high] [status:: done]
- [ ] Set up Uptime Robot on /health [owner:: claude] [priority:: medium] [status:: open]
- [x] EU billing-address check — DONE 2026-06-10: billing_address_collection required at checkout; webhook rejects EU27 billing countries and cancels the (untrialed-charge) subscription before any activation. [owner:: claude] [priority:: high] [status:: done]
- [x] Audit actual data handling vs published Privacy Policy claims — DONE 2026-06-10 → [[Projects/Welra/Privacy_Audit_2026-06-10]] (3 unimplemented promises found) [owner:: claude] [priority:: high] [status:: done]
- [x] Amend Privacy Policy wording: CSV-upload retention disclosed — DONE 2026-06-12 by Claude directly in the live policy (apps/web privacy page §4: per-platform fetch-and-discard, CSV order-record storage, cancellation deletion, 12-mo report retention, ZIP export). Termly account is CANCELED — the React page IS the policy now; ~/Documents/GR3NB/Legal HTML files are archive-only. Closes the last privacy-audit item. [owner:: claude] [priority:: high] [status:: done]
- [x] Build retention/deletion job — DONE 2026-06-10: daily 3am UTC BullMQ cron (retentionCron.ts). On cancellation: tokens nulled + CSV order data deleted from storage. 12mo post-cancellation: reports + PDFs deleted. Arch-review caught + fixed a blocker: `canceled_at` was never cleared on re-subscribe → stale timestamp could trigger premature irreversible deletion; webhooks now manage canceled_at on every status transition. [owner:: claude] [priority:: high] [status:: done]
- [x] Build ZIP export — DONE 2026-06-10: GET /reports/export streams all delivered reports as ZIP (PDF, HTML fallback). Privacy-audit promise #3 now TRUE — Termly edit only needs the CSV-retention wording now. [owner:: claude] [priority:: medium] [status:: done]
- [x] Remove dead 'agency' code path — DONE 2026-06-10 (PlanTier, TIER_CONFIG, synthesis prompts; site contact-sales path kept) [owner:: claude] [priority:: medium] [status:: done]
- [ ] Re-audit risk register: re-mark every "✅ Mitigated" whose mitigation is unbuilt/unverified as "Planned" (CSV, Sentry, retry ladder, token emails, onboarding sequence, feedback loop, export, cost cap) [owner:: claude] [priority:: medium] [status:: open]
- [x] Verify META_ACCESS_TOKEN task target — RESOLVED 2026-06-10: belongs to Rust & Rainbow (NAS Instagram agent), not Welra. Already tracked in [[Projects/Rust_and_Rainbow/Tasks]] with due 2026-06-25; `refresh_meta_token.py` exists in the R&R repo to do the refresh. Removed from Welra scope. [owner:: claude] [priority:: medium] [status:: done]

## Report Quality (the product)

- [x] Report-quality eval harness — BUILT 2026-06-10: `npm run eval` in apps/api; 3 golden datasets (Etsy strong week / Woo down week / multi-channel+CSV), production prompts, number/phrase/action checks + hallucination judge. **First full run blocked on API credits.** [owner:: claude] [priority:: high] [status:: done]
- [x] Run eval harness once credits added — DONE 2026-06-11 (session 9): credits purchased by Ryan, 8 eval iterations → **3/3 datasets passing, stable across 3 consecutive runs**. Changes: honesty-hardened prompts (causes only as checks, no absent metrics, no fabricated week-over-week, actions grounded in seller's own numbers — the old prompt's example literally taught external-benchmark citations); judge upgraded to sonnet with explicit rubric + pipeline-derived totals in its context + robust JSON parse; **synthesis switched to claude-sonnet-4-6 via REPORT_SYNTHESIS_MODEL in Railway** (haiku hallucinated mechanisms every run — "likely has stronger visual coverage", "no repeat purchases"; ~$0.02-0.05/report extra). Deployed green. [owner:: claude] [priority:: high] [status:: done]
- [x] Watch Sunday 2026-06-14 cron — clarified 2026-06-14 (s15): scheduler is Sunday **23:00 UTC** (not 6am); a `welra-cron-check` scheduled task is armed to verify the 23:00Z run. See the "Now" section. [owner:: claude] [priority:: medium] [status:: done]

## From arch-review 2026-06-10 (overnight session)

- [x] **ADD ANTHROPIC API CREDITS** — DONE 2026-06-11: Ryan purchased credits; eval verified working (3/3 passing). Report generation unblocked. [owner:: ryan] [priority:: high] [status:: done]
- [x] [DEFERRED from arch-review] Migration: add 'printify','instagram' to integrations.platform CHECK — DONE 2026-06-11 (session 9): Ryan approved, applied to prod via Supabase MCP; schema.sql updated to match. Full enablement shipped same session → [[Projects/Welra/Platform_Feasibility_2026-06]]. [owner:: ryan] [priority:: medium] [status:: done]
- [x] Printify integration end-to-end — DONE 2026-06-11: token route validates against shops.json (resolves shop server-side), fetcher hardened (early-exit pagination, cancelled excluded, fixture test passes), dashboard connect card live. ⚠️ Verify total_price semantics against R&R's real account at first connect. [owner:: claude] [priority:: high] [status:: done]
- [x] Instagram integration (engagement add-on) — DONE 2026-06-11: Graph API (business accounts), token route validates account+token + sets 60d expiry for the token-health cron, dashboard card live. Connect with R&R's posting token + IG business account ID to verify. [owner:: claude] [priority:: medium] [status:: done]
- [x] Ryan: connect R&R's Printify — DONE 2026-06-13 (session 14): clean account `rustandrainbow@gmail.com` (Starter, trialing) connected Printify (shop "Rust and Rainbow" 27483352). Instant-report-on-first-connect fired + **delivered** (report bbf784df, week 2026-06-08, source printify) — **first real Welra report from live seller data**. ⚠️ generated-and-logged only (REPORT_DRY_RUN on → no email). Instagram not connected (waits for Meta app). [owner:: ryan+claude] [priority:: high] [status:: done]
- [ ] Verify R&R's first report accuracy against the Printify dashboard for week of 2026-06-08 — `total_price` semantics. UPDATE 2026-06-14 (s15): code path PROVEN correct (audit: right shop, valid token, 0 orders in account); remaining is confirming real Etsy sales vs Printify-fulfilled coverage. See the "Now" section entry. [owner:: ryan+claude] [priority:: high] [status:: open]
- [x] Disconnect the redundant duplicate Printify connection on the old `ryantest4@northamfamily.org` account — DONE 2026-06-14 (s15) by Ryan. [owner:: claude] [priority:: medium] [status:: done]
- [x] **Instagram OAuth "now slice" BUILT 2026-06-13 (session 13)**: Facebook-Login connect/callback in oauth.ts (code→short→long 60d token via fb_exchange_token, discovers IG business account id from /me/accounts→instagram_business_account, upserts like Etsy/Shopify — zero fetcher change since it stays on graph.facebook.com); META_APP_ID/SECRET/REDIRECT_URI added to env (optional, inert-503 until set); tokenHealthCron now auto-refreshes Instagram tokens before expiry (fb_exchange_token re-exchange) so the 60-day expiry never reaches the user — only emails if Meta refuses; flag-gated `ConnectInstagramButton` (NEXT_PUBLIC_INSTAGRAM_OAUTH, default OFF → public unchanged, manual form + concierge stay). tsc+build green both apps, arch-review clean (0 blockers). **NOT yet deployed/tested — blocked on Ryan creating the Meta app (checklist provided).** [owner:: claude] [priority:: high] [status:: done]
- [ ] **Ryan: create the Meta app for Instagram OAuth** — at developers.facebook.com create a Business-type app under GR3NB, add the "Facebook Login" + "Instagram Graph API" products, set Valid OAuth Redirect URI to `https://welra-production.up.railway.app/integrations/instagram/callback`, add yourself as admin + R&R's IG as a test connection, and paste App ID + App Secret back to Claude. PREREQ: R&R's Instagram must be a business/creator account linked to a Facebook Page you admin (that's how /me/accounts finds it). [owner:: ryan] [priority:: high] [status:: open]
- [ ] After Meta app exists: Claude sets META_* in Railway, deploys API (`railway up`), flips NEXT_PUBLIC_INSTAGRAM_OAUTH=true on Vercel, one-click connects R&R, verifies the fetcher against R&R's real IG (followers/posts/likes), and confirms the cron auto-refresh path. [owner:: claude] [priority:: high] [status:: blocked]
- [ ] [DEFERRED from arch-review 2026-06-13] Meta App Review + Business Verification BEFORE flipping NEXT_PUBLIC_INSTAGRAM_OAUTH=true for the public — in Dev Mode the requested scopes (instagram_basic, pages_show_list, pages_read_engagement, instagram_manage_insights) only grant to app-role users (admin/dev/tester); public users hit "app not available". Same review-risk class as the Etsy denial — apply the no-AI application playbook to the Meta use-case description. [owner:: ryan] [priority:: medium] [status:: blocked]
- [ ] [DEFERRED from arch-review 2026-06-13] Add specific /dashboard banner copy for `error=instagram_no_account` ("link your Instagram to a Facebook Page you manage first") and `error=instagram_not_configured` — currently both fall through to the generic "that connection didn't go through" banner. [owner:: claude] [priority:: low] [status:: open]
- [x] **ONBOARDING PIVOT shipped 2026-06-13 (session 13, after /take-a-step-back)**: time-to-first-value was structurally ~7 days (reports only generated on the Sunday cron) and the universal no-token path (CSV) was routed through *email* while the free /scan tool had a slick drop-zone — backwards. Fixed both: (1) `enqueueInstantReport()` fires on every first connect (CSV upload, token route, all 3 OAuth callbacks) → generates last week's report immediately, idempotent (existing-report guard + UNIQUE + idempotent jobId = exactly 1/customer/week, no Claude-API spam); (2) new in-dashboard `CsvUpload.tsx` authed drag-and-drop → `/uploads/csv` (reuses the scan pattern); (3) integrations page restructured to LEAD with the uploader hero ("Get your first report") + platform cards moved under "Connect a platform for automatic weekly reports". tsc+build green both apps; arch-review clean (0 blockers; caught + fixed a 2nd camelCase domain-type trap on subscription_status). [owner:: claude] [priority:: high] [status:: done]
- [ ] **Copy↔flag dependency:** `CsvUpload.tsx` success message promises "your first report is generating now and will arrive by email shortly" — TRUE only once `REPORT_DRY_RUN=false`. While dry-run is on, the instant report generates-and-logs (no email). Flip dry-run (already a launch task) before any real beta user uploads, or the promise is false. [owner:: claude] [priority:: high] [status:: open]
- [ ] [DEFERRED from arch-review] tokenHealthCron passes raw rows via `as` casts to the expiry email (works today only because the fields read happen to match) — route through mapIntegrationRow/a customer mapper [owner:: claude] [priority:: low] [status:: open]
- [ ] [DEFERRED from arch-review] Rate-limit POST /integrations/:platform/token (validation calls fan out to Printify/Meta) [owner:: claude] [priority:: low] [status:: open]
- [ ] TikTok Shop: API deferred (Partner Center review; apply post-beta using the no-AI application playbook). CSV exports work today via generic detector. [owner:: claude] [priority:: low] [status:: blocked]
- [x] [DEFERRED from arch-review] Validate :platform param against allowlist in POST /integrations/:platform/token — DONE 2026-06-10 (ALLOWED_PLATFORMS mirrors schema CHECK; keep in sync if printify/instagram migration lands) [owner:: claude] [priority:: medium] [status:: done]
- [ ] [DEFERRED from arch-review] Lazy-init Resend in emailService.ts + feedback.ts per convention [owner:: claude] [priority:: low] [status:: open]
- [x] [DEFERRED from arch-review] Implement /auth/me and /reports routes — DONE 2026-06-10: profile endpoint, report list/detail (fresh 1-hr signed PDF URL), deployed + smoke-tested (401 unauthenticated) [owner:: claude] [priority:: medium] [status:: done]
- [x] Set SENTRY_DSN in Railway — DONE 2026-06-12: Ryan's dashboard attempt didn't land (variable never reached the service — Railway staged-changes gotcha); Claude set it via CLI + redeployed; boot log confirms "Sentry error monitoring enabled", health 200. [owner:: ryan+claude] [priority:: high] [status:: done]

## Marketing & Brand (added 2026-06-10)

- [x] Brand icon + color scheme — DONE 2026-06-10: radar-sweep mark + 6-color palette → [[Projects/Welra/Brand_Identity]]; favicon/logo SVGs + Tailwind tokens committed (commit 3516185) [owner:: claude] [priority:: high] [status:: done]
- [x] Cheap marketing campaign plan — DONE 2026-06-10 → [[Projects/Welra/Marketing_Campaign_2026-06]] ($0 beta phase, ≤$150/mo launch runway) [owner:: claude] [priority:: high] [status:: done]
- [x] Etsy + Shopify developer application walkthrough — DONE 2026-06-10 → [[Projects/Welra/Etsy_Shopify_Developer_Applications]] (key finding: Etsy personal access = 5 shops immediately — beta is NOT blocked on commercial review) [owner:: ryan] [priority:: high] [status:: done]
- [x] Apply brand palette to landing page (header, CTAs, pricing cards) + report email template — DONE 2026-06-10 (session 8, commit 595c01c): ink/radar/signal across nav, hero, pricing, footer, report email; email footer contact fixed to ryan@welra.io. Email side is LIVE (Railway); landing page goes live with the next web deploy (PAT push or `npx vercel deploy --prod`). [owner:: claude] [priority:: medium] [status:: done]
- [ ] Social/OG card images (1200×630 + square) in brand colors [owner:: claude] [priority:: low] [status:: open]
- [ ] Start beta recruitment cadence per campaign plan (Reddit/FB give-first week, then beta-tester posts + 20 DMs) [owner:: ryan] [priority:: high] [status:: open]
- [x] Free press: welra.io/press kit page — DONE 2026-06-11 (session 9): boilerplate, fast facts, founder bio (shop deliberately unnamed — Ryan's call per situation), what-Welra-is-NOT, brand asset downloads, footer link. Live + smoke-tested. [owner:: claude] [priority:: medium] [status:: done]
- [x] Free press: Ryan's full playbook (scripts/outlines/steps for every human deliverable) — DONE 2026-06-11 → [[Projects/Welra/Press_Playbook]] (source-profile setup + response template, 10-show podcast list + pitch script + appearance outline, BetaList paste-ready copy, survey questions verbatim, local-press email, newsjack play, pickup log). [owner:: claude] [priority:: medium] [status:: done]
- [x] Free press: Qwoted + SourceBottle profiles — DONE 2026-06-12 (Ryan). Featured.com is DEAD/unreachable (verified) — replaced in Press_Drafts §2 with Source of Sources (free HARO successor) + MentionMatch (Help a B2B Writer rebrand, launching soon). Ongoing: answer 2-3 requests/wk in the Friday slot. [owner:: ryan] [priority:: medium] [status:: done]
- [ ] Free press: sign up for Source of Sources (sourceofsources.com, ~2 min — name + email only, no profile) + MentionMatch when its registration opens — details in [[Projects/Welra/Press_Drafts]] §2 [owner:: ryan] [priority:: medium] [status:: open]
- [ ] Free press: submit BetaList listing — **full submission drafted in [[Projects/Welra/Press_Drafts]] §4** (~20 min) [owner:: ryan] [priority:: medium] [status:: open]
- [ ] Free press: create the dashboard-hours Google Form — **complete form (title, description, all 7 questions + options) + the no-link distribution post in [[Projects/Welra/Press_Drafts]] §5**; at n≥50 Claude drafts the data story. ⚠️ Survey + own-shop data only. [owner:: ryan] [priority:: medium] [status:: open]
- [ ] Free press: podcast pitching — **3 personalized pitch drafts (Lizzie Smiley / Side Hustle Show / eCommerce Badassery) + generic template + follow-up in [[Projects/Welra/Press_Drafts]] §6**; verify each show is active, 1 pitch/wk [owner:: ryan] [priority:: medium] [status:: open]
- [x] Web: /dashboard/settings page — DONE 2026-06-11 (session 9): account info, plan + status badge, Stripe billing portal (new POST /checkout/portal), ZIP export button (GET /reports/export), delete-account mailto, sign out. Header 404 fixed; privacy policy §6's "settings page" promise now true. [owner:: claude] [priority:: medium] [status:: done]
- [x] Web: brand lockup rollout — DONE 2026-06-11: Logo component (radar icon + "Welra") replaces text-only brand in all 11 prominent spots (auth pages, dashboard headers, press, privacy/terms, contact, eu-waitlist, homepage footer); welra-logo.svg wordmark fixed lowercase "welra" → "Welra". [owner:: claude] [priority:: medium] [status:: done]
- [x] Web: /dashboard/reports list + /dashboard/reports/[id] detail — DONE 2026-06-11 (session 9): RLS-scoped reads via row mapper, sandboxed-iframe report render, fresh 1-hr signed PDF link via API, anomaly banner, empty state. All dashboard nav links now resolve. [owner:: claude] [priority:: high] [status:: done]
- [x] Settings: editable name + timezone (PATCH /auth/me, IANA-validated; scheduler reads tz fresh each Sunday so changes apply next cycle) + email change via Supabase secure dual confirmation (links to BOTH old + new address) with customers.email reconciliation on next settings visit — DONE 2026-06-11. Payment-method changes confirmed covered by the Stripe billing portal. [owner:: claude] [priority:: medium] [status:: done]
- [x] Ryan: Supabase Auth URL Configuration fixes — DONE 2026-06-11: Site URL `http://localhost:3000` → `https://www.welra.io`, wildcard redirect URLs added (`https://www.welra.io/**`, `https://welra.io/**`). Auth email links no longer fall back to localhost. [owner:: ryan] [priority:: high] [status:: done]
- [x] After the Site URL fix: fresh e2e auth test — PASSED 2026-06-12 (Ryan): email change confirmed at both addresses, landed on /dashboard/settings. [owner:: ryan] [priority:: high] [status:: done]
- [x] Add "Founding Seller beta" banner + waitlist capture to landing page — DONE 2026-06-10 (session 8): banner (free Pro during beta → 50% off 6 mo, per campaign plan) + POST /waitlist API (5/min/IP rate limit); EU waitlist page now uses the same endpoint instead of the mailto hack. Goes live with next web deploy. [owner:: claude] [priority:: medium] [status:: done]
- [x] [DEFERRED from arch-review] Apply the `waitlist` table migration — RESOLVED 2026-06-11: table already exists in prod with correct shape + RLS enabled (discovered when applying with Ryan's OK; created at some earlier point without the task being closed). Banner signups write to the DB. [owner:: ryan] [priority:: high] [status:: done]
- [ ] [DEFERRED from arch-review] Tailwind `slate` brand token shadows the built-in slate-50..950 scale (theme.extend replaces the key) — rename to e.g. `slateink` or confirm no scale classes ever get used [owner:: claude] [priority:: low] [status:: open]

## Growth (post-beta) — see [[Projects/Welra/Growth_Plan_2026-06]]

- [x] Build free "Shop Radar Scan" page + shareable Week Cards (top 2 awareness assets) — DONE 2026-06-12 (session 10): public POST /scan (no auth, nothing stored, per-IP 4/hr + global 200/day Claude-call cap, stats-only degradation) + welra.io/scan page (drop zone, daily mini-chart, honesty-rule mini-analysis, signup CTA); Week Card 1080×1080 PNG (trend % + orders only, NO revenue) rendered via Puppeteer per report, embedded in the report email with download link, covered by retentionCron. Arch-review found + fixed: missing trustProxy on Railway (ALL per-IP rate limits were one global bucket) and card PNGs escaping the 12-mo deletion promise. [owner:: claude] [priority:: medium] [status:: done]
- [ ] [DEFERRED from arch-review] Report generation launches two Puppeteer browsers per report (PDF + Week Card sequentially) — consolidate into one shared launch when report volume grows [owner:: claude] [priority:: low] [status:: open]
- [ ] Verify the live /scan flow end-to-end in a real browser (drop a real Etsy/Shopify CSV at welra.io/scan, confirm analysis quality reads honest) — first marketing-asset QA [owner:: ryan] [priority:: medium] [status:: open]
- [ ] G3 design spike: orders_normalized schema + scoped-RPC query tools for Radar On-Demand [owner:: claude] [priority:: low] [status:: open]

## Carried Forward

- [x] Logo standalone tagline "Your business radar" — DONE 2026-06-13 (session 14, Ryan's call to drop "weekly" so it stays valid if an on-demand app ships): optional `tagline?` prop on Logo.tsx, auto-on for the large lockup (auth/brand screens), off on compact nav/footer; tsc+build green, deployed + verified live (signup/forgot-password show it, nav omits it). [owner:: claude] [priority:: low] [status:: done]
- [x] Sync git `main` with production — DONE 2026-06-13 (session 14): committed 4 chunks (Logo tagline; session-12 ssr cookie/auth fix; session-13 Instagram OAuth + instant-report API; session-13 CSV-uploader + walkthroughs web) that had been deployed-from-local but never committed. main now matches what's live (not pushed). [owner:: claude] [priority:: medium] [status:: done]

- [ ] **Fix apex `welra.io` (no-www) — broken SSL, brand-name path fails.** Diagnosed 2026-06-13 (session 14): `https://welra.io` throws `SSL: no alternative certificate subject name matches 'welra.io'` (cert only covers `www`); apex A records still serve the stale parking IP `162.255.119.212` alongside Vercel's `216.198.79.1`, so Vercel can't verify/provision the apex cert. Vercel side already correct (both `welra.io` + `www.welra.io` attached to `welra-web` — confirmed via `vercel domains inspect`). **FIX is Namecheap-only (Ryan):** delete BOTH apex `A @` records, add one `A @ → 76.76.21.21` (Vercel verifier's recommended record); cert auto-provisions + apex→www redirect activates within minutes. www.welra.io is unaffected and fully live throughout. **IN PROGRESS 2026-06-13 (session 14):** `A @ → 76.76.21.21` is now published, but the stale `A @ → 162.255.119.212` parking IP is STILL at the authoritative NS — must be deleted (if it won't delete or reappears, it's a URL Redirect / Parking record, not the plain A row). Cert won't provision until the apex resolves to ONLY the Vercel IP. **RESOLVED 2026-06-13 (session 14):** root cause was Namecheap's **Redirect Domain** + **Parking Page** both re-injecting the parking IP; removed both, set `A @ → 76.76.21.21` + `A www → 76.76.21.21`, and Namecheap support force-rebuilt a desynced zone (frozen/conflicting SOA serials). Verified: apex + www both 200 over HTTPS with valid cert, matching serial. iPhone warning gone. Full runbook → [[Knowledge_Base/DNS_Domain_Runbook]]. [owner:: ryan+claude] [priority:: high] [status:: done]
- [ ] Google Sheets bridge (GA4) — second unbuilt ingestion path [owner:: claude] [priority:: medium] [status:: open]
- [ ] Make webhook receiver — third unbuilt ingestion path [owner:: claude] [priority:: low] [status:: open]
- [ ] Weekly "Welra Monday review" scheduled task: Sunday cron logs, Stripe MRR, 👎 flags, Sentry [owner:: claude] [priority:: low] [status:: open]
- [x] Approve + apply the customers-trigger migration (repoint on_auth_user_created → handle_new_auth_user, drop stub, backfill name/plan) — DONE 2026-06-12 (session 11, Ryan approved): trigger repointed, stub dropped, names backfilled; also schema-qualified to public.customers + SET search_path=public to fix "Database error saving new user" (auth fires triggers with search_path=auth). Verified by a real API signup landing name + plan. [owner:: ryan] [priority:: high] [status:: done]
- [x] **AUTH FIX (session 12, 2026-06-13): password-reset link dead-ended "link expired" → ROOT CAUSE = @supabase/ssr pinned 0.3.0** while all 7 createServerClient sites use the getAll/setAll cookie API from 0.4.0. 0.3.0's get/set/remove are optional, so the unknown-named adapters silently no-op'd → server-side cookie WRITES never happened → verifyOtp returned 200 server-side (auth logs confirmed) but the browser got no session. Fixed: upgraded ssr → ^0.6.1 (peer dep already satisfied by supabase-js 2.107); rewrote auth/callback to write cookies onto the returned NextResponse.redirect (Next 14 route-handler correctness); wrapped all 5 dashboard Server-Component setAll calls in try/catch (0.6.1 invokes setAll on refresh and cookies().set throws in an RSC). tsc+build green, arch-review clean, deployed to www.welra.io, live callback redirects smoke-tested. Patterns #41/#42 logged. [owner:: claude] [priority:: high] [status:: done]
- [ ] Ryan RETEST (session 12 fix): from any device — (a) fresh signup → email link lands in dashboard, name + plan populated; (b) forgot-password → reset link lands on the "Choose a new password" FORM (not "expired") → set password → dashboard. If anything snags, Claude pulls Supabase auth logs immediately. [owner:: ryan] [priority:: high] [status:: open]
- [x] **[arch-review s18, HIGH] Scheduler emails unconnected trials a false "technical difficulty" notice.** RESOLVED 2026-06-15: scheduler now skips no-connected customers and sends a SETUP REMINDER email instead; misleading copy removed; catch-up cron added; deployed + verified live. reportSchedulerCron.scheduleWeeklyReports queues a report for every active/trialing customer with NO check for connected integrations → generateReport throws "No data sources" → worker retries 3x → sends sendDelayEmail('technical'), repeats weekly. Live now on ryantest* accounts (status=failed, retry_count=2). Fix: skip scheduling (or branch to a "connect a platform" nudge) when the customer has zero `connected` integrations. [owner:: claude] [priority:: high] [status:: open]
- [x] **[arch-review s18, MED] Delay emails ignore unsubscribed_at.** RESOLVED 2026-06-15: both delay-email paths now check unsubscribed_at. sendDelayEmail (anomaly path reportGenerator.ts:531, technical path worker.ts:96) doesn't check the opt-out that sendReportEmail honors → an unsubscribed seller still gets delay notices. Add the same unsubscribe guard to both delay-email call sites. [owner:: claude] [priority:: medium] [status:: open]
- [x] **[arch-review s18, LOW] worker.ts technical-delay email not gated by REPORT_DRY_RUN** RESOLVED 2026-06-15: now gated by dry-run + unsubscribe. (anomaly path at reportGenerator.ts:530 is). Moot while dry-run is off, but fire real emails during any future dry-run testing. Gate it. [owner:: claude] [priority:: low] [status:: open]
- [ ] **[arch-review s18, LOW] emailService.ts:6 `new Resend(env.RESEND_API_KEY)` at module level** violates lazy-SDK-init rule; safe only because env makes the key required. Wrap in a lazy getter for consistency. [owner:: claude] [priority:: low] [status:: open]
- [x] **[s18] Fix delivered-status honesty bug** — added reports.email_sent_at (migration applied to ozhekoiehpajeytwltrv); reportGenerator now writes email_sent_at + delivered_at ONLY on a real send (null on dry-run/unsubscribed); status='delivered' kept as "generated & viewable". types + web rows mapper updated; tsc + build green on api/web/types. June 22 check should read email_sent_at IS NOT NULL, not the log. [owner:: claude] [priority:: high] [status:: done]
- [x] **[s18] Report "didn't run" + self-heal + setup reminder** — Root cause: Sunday cron ran fine; every "failure" was a customer with 0 connected integrations (no data → "No data sources" → retries → misleading "arrives Tuesday" email). Built + DEPLOYED + verified live: (a) scheduler skips no-connected customers and sends a "connect a platform" SETUP REMINDER (options + link, unsubscribe/dry-run gated, 28-day cap); (b) hourly CATCH-UP cron re-delivers any overdue+undelivered report immediately (no waiting a week); (c) late reports get an apology banner + "(a little late)" subject; (d) honest delay copy. Boot log shows `[catchup] Repeatable cron registered: hourly at :15`. [owner:: claude] [priority:: high] [status:: done]
- [ ] **[s18] (optional) Clean up 8 stuck no-data test reports** (ryantest*/test22 week 2026-06-08, status failed/pending). Harmless (catch-up skips them, they age out of the 3-day window) but clutter the dashboard. Delete reports+report_jobs rows if a clean slate is wanted pre-launch. [owner:: ryan|claude] [priority:: low] [status:: open]
- [ ] **[s18] Tune setup-reminder cadence if desired** — currently weekly while unconnected, capped to first 28 days post-signup (SETUP_REMINDER_MAX_AGE_DAYS in reportSchedulerCron.ts). Adjust duration/frequency to taste. [owner:: ryan] [priority:: low] [status:: open]
- [x] **[s18] Marketing email capture — "free sample report" lead magnet** — Built + deployed + verified live. API: `leads` table (RLS on, no policies; migration applied), `POST /leads` (rate-limited, zod-validated), `sendSampleReportEmail` (realistic founder-voice sample report → inbox), optional Resend Audience sync (`addLeadToAudience`, gated on `RESEND_AUDIENCE_ID`), waitlist-style email fallback. Web: `<SampleReportCapture>` on /blog, /faq, and every blog post. E2E tested: POST valid→200+row+sample_sent_at, invalid→400, audience no-op (env unset). Apology threshold set to 2h per Ryan. [owner:: claude] [priority:: medium] [status:: done]
- [x] **[s18] Enable Resend Audience for the marketing list** — DONE 2026-06-15: created "Welra Leads" audience (id 879d0ab3-34b6-4ec7-9d76-2a427f8e8a6a) via the Railway-injected key, set `RESEND_AUDIENCE_ID` in Railway, redeployed. Verified end-to-end: test lead → resend_contact_id linked + contact appeared in the audience (then cleaned up). New sample-report leads now auto-sync as Resend contacts → ready for Broadcasts. [owner:: claude] [priority:: low] [status:: done]
- [x] **[s18] Add sample-report capture to homepage** — DONE 2026-06-15: `<SampleReportCapture source="homepage">` added to the #sample section (below the sample excerpt + signup CTA); deployed + verified live on www.welra.io.
- [ ] **[s18] Marketing next steps** — syndicate each blog post to LinkedIn/Medium w/ canonical link (needs Ryan's accounts — Claude can draft posts); send a periodic "seller tip" Broadcast to the Welra Leads audience now that it's wired. [owner:: ryan|claude] [priority:: low] [status:: open]
- [x] **[s18] Brand voice: "plain English" → "clear"** — DONE 2026-06-15: swapped across 13 user-facing files (homepage, FAQ, layout meta, press, blog, scan, sample email, capture form, privacy, integrations walkthrough) + the scan AI prompt; adapted per sentence ("a clear read", "clear weekly report", "written clearly"). Deployed web+API, verified live, zero "plain English" remaining (one internal code comment aside). Ryan picked "clear" over no-jargon/written-like-a-human/straight-talk.
- [x] **[s18] Small-business growth/success emphasis in copy** — DONE 2026-06-15: hero subhead ("built to help small shops grow…the next move to grow your business"), how-it-works H2 ("Less time in dashboards. More time growing your shop."), FAQ what-is ("worth doing next to keep growing"), press boilerplate ("Welra helps small e-commerce sellers grow…make confident decisions"), new footer mission ("On a mission to help small shops grow — one clear decision at a time" — cadence-free so it survives an on-demand app). Deployed + verified live.
- [x] **[s18] Follow-through / congratulations in the weekly report** — DONE 2026-06-15: synthesis prompt now revisits last week's priority actions and celebrates, BY THE NUMBERS, any whose targeted metric clearly improved — framed strictly as the observable OUTCOME, never "you did X / your change worked" (Welra sees numbers, not actions). Calibrated to clear, meaningful wins only (Ryan's "how warm" left unanswered → chose credible default). Pro+Growth tiers (they get prior-week context; Starter doesn't by design). Eval harness extended to feed a prior week + give the judge that prior report (so legit week-over-week credit isn't mis-flagged) + new golden `etsy-followthrough-week` that would catch false credit. Eval 4/4 honesty-clean (also caught + fixed a growth-tier trend-read hallucination — now guarded to omit multi-week trend language under 3 weeks). Deployed.
- [ ] **[s18] Follow-through precision upgrade (optional, future)** — store each week's priority actions in a structured field at generation time so next week's follow-through targets the exact metric/listing instead of parsing prior prose. Additive migration + extraction. [owner:: claude] [priority:: low] [status:: open]
- [ ] **[s18] Decide: follow-through on Starter tier?** — Starter currently gets NO prior-week context (cost/simplicity), so follow-through only runs on Pro/Growth. Enabling it for Starter means feeding previousWeekSynthesis to Starter (slightly more tokens). [owner:: ryan] [priority:: low] [status:: open]

## TikTok integration (built s24 2026-06-24 — read-only Login Kit data source; SUBMIT NOW)
POSTURE (Ryan s24): options-available-by-default. Welra's wedge is frictionless, one-click onboarding — every source should sit there as a real one-click option, NOT gated behind customer demand. So SUBMIT TikTok now (reversed the earlier hold); flip the flag the instant it's approved. The gate exists ONLY so a pre-approval click can't error (resistance) — it is the launch switch, not a demand gate.
Context: TikTok added as a Welra read-only analytics SOURCE (Login Kit: user.info.basic/profile/stats — follower/like/video counts). Built into welra.io (oauth.ts /tiktok/connect+callback, integrations/tiktok.ts fetcher w/ refresh-token rotation, types, reportGenerator dispatch, gated ConnectTikTokButton). Submitted as a FRESH app under Welra identity (NOT the twice-rejected R&R Content-Posting app — we're at 2 rejections, 3 flags the dev account). tsc green all 3 workspaces; arch-review clean (0 blockers). Strategy/why in [[Knowledge_Base/Platform_App_Review_Runbook]] + memory feedback_platform_api_applications.
- [ ] **[arch-review s24, DEMO PREREQ] Apply TikTok platform migration to live Supabase** — `apps/api/src/lib/db/migrations/2026-06-24_add_tiktok_platform.sql` widens the integrations.platform CHECK to include 'tiktok'. Until applied to prod (ozhekoiehpajeytwltrv), the OAuth callback upsert 500s on a constraint violation. Non-destructive. [owner:: claude] [priority:: high] [status:: open]
- [ ] **[s24] Set TikTok env vars in Railway (welra API)** — TIKTOK_CLIENT_KEY, TIKTOK_CLIENT_SECRET (from the FRESH Welra TikTok app, NOT R&R's sandbox key), TIKTOK_REDIRECT_URI = exactly `https://api.welra.io/integrations/tiktok/callback`. [owner:: ryan] [priority:: high] [status:: open]
- [ ] **[s24] Create FRESH TikTok app + verify welra.io domain** — Website URL = welra.io; Products = Login Kit (+ Display API only if per-video later needed — currently NOT used); Scopes = user.info.basic/profile/stats; verify welra.io in TikTok console (serve the tiktokXXXX.txt from welra.io root); register the redirect URI above. Apply Reason = multi-tenant analytics framing (in runbook). [owner:: ryan] [priority:: high] [status:: open]
- [ ] **[s24] After approval: flip NEXT_PUBLIC_TIKTOK_OAUTH=true** in Vercel (web) to make the one-click Connect TikTok button live. Flip the instant the app is approved (options-available-by-default — do NOT wait for a customer to ask). [owner:: ryan] [priority:: high] [status:: open]
- [ ] **[arch-review s24, RISK low] Add TikTok branch to tokenHealthCron auto-refresh** — currently Instagram-only; TikTok refresh token rotates and is persisted by the fetcher each weekly run (stays ~365d out), but a TikTok-only customer whose reports pause >365d would lapse without auto-refresh. Mirror refreshInstagramToken. [owner:: claude] [priority:: low] [status:: open]

## WooCommerce one-click connect (built s24 2026-06-24 — wc-auth flow)
Converted WooCommerce onboarding from manual ck_/cs_ key paste to WooCommerce's /wc-auth/v1/authorize one-click flow (merchant approves on their store → WC POSTs keys to our callback → row written as "ck:cs", same shape the fetcher reads). Manual paste kept as a collapsed fallback. arch-review caught + FIXED a blocker (WC posts the callback form-encoded; added a urlencoded content-type parser scoped to oauthRoutes). tsc green all 3 workspaces.
- [ ] **[arch-review s24, RISK low] WooCommerce return_url false "connected" banner on DENY** — on merchant deny, WC redirects browser to return_url with &success=0 and never calls the callback, but return_url is hardcoded ?connected=woocommerce so the dashboard flashes a connected banner (card itself stays disconnected). Fix: have /dashboard suppress the banner when success=0. [owner:: claude] [priority:: low] [status:: open]
- [ ] **[arch-review s24, RISK low] SSRF hardening on store-URL fetches (Woo + Shopify)** — server issues GETs to customer-supplied store URLs (Woo probe + woocommerce.ts fetcher). Pre-existing, limited (blind, customer reaches own store), but if hardening: block private/link-local IP ranges before fetching. [owner:: claude] [priority:: low] [status:: open]
- [ ] **[s24] Validate the WC callback content-type against a live store at demo** — confirmed WC core sends form-encoded (parser added handles it) AND JSON is still parsed; verify against the actual store version used in the first real connect. [owner:: ryan|claude] [priority:: medium] [status:: open]

## Integration architecture completeness (s24 2026-06-24)
Audited the whole connect→fetcher→report→render pipeline. It's GENERIC and sound (full-JSON source analysis + generic HTML render); a new source needs only 4 touchpoints (dispatch switch, types, DB CHECK, optional tips/highlights). Eliminated the dead ends: added `INTEGRATION_READINESS` single-source-of-truth in @welra/types (live/beta/coming), drove the dashboard from it (Etsy now shows "coming soon" instead of a hollow connect on its STUB fetcher; WooCommerce one-click gated behind NEXT_PUBLIC_WOO_ONECLICK until smoke-tested), added TikTok STARTER_TIPS, fixed `.env.example` (Etsy/Shopify redirect URIs pointed at a non-existent welra.io/auth/callback path — corrected to the real API route /integrations/{platform}/callback; added META_*/TIKTOK_*), and added live smoke-test scripts (scripts/smoke-printify.ts, smoke-woocommerce.ts). tsc green all 3 workspaces.
- [ ] **[s24] Implement the Etsy fetcher (currently a STUB returning null)** — `apps/api/src/integrations/etsy.ts`. Etsy v3: receipts→revenue/orders, listings→views/conversion to populate EtsyWeekData. Do alongside Etsy app approval so it can be live-tested; then flip INTEGRATION_READINESS.etsy from 'coming' to 'beta'/'live'. [owner:: claude] [priority:: high] [status:: open]
- [ ] **[s24] Run smoke tests with real creds → flip readiness to 'live'** — `PRINTIFY_TOKEN=… npx tsx scripts/smoke-printify.ts` (R&R has a token) and `WOO_STORE/WOO_CK/WOO_CS=… npx tsx scripts/smoke-woocommerce.ts` (needs a real WC store). On pass: set INTEGRATION_READINESS to 'live' and, for Woo, NEXT_PUBLIC_WOO_ONECLICK=true. [owner:: ryan|claude] [priority:: high] [status:: open]
- [ ] **[s24] Stripe-as-source is a stub with no connect path** — `integrations/stripe.ts` returns null and isn't surfaced (readiness='coming'). Either build Stripe Connect OAuth + fetcher intentionally, or leave unsurfaced. Decision needed before advertising Stripe as a source. [owner:: ryan] [priority:: low] [status:: open]
- [ ] **[s24] Verify live Etsy/Shopify OAuth redirect URIs match the API route** — `.env.example` previously pointed at welra.io/auth/callback/* (non-existent). Confirm the values set in Railway are https://api.welra.io/integrations/{platform}/callback and match the provider console registration. [owner:: ryan] [priority:: medium] [status:: open]
