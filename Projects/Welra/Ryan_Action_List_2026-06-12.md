---
title: Ryan Action List — 2026-06-12 (step-by-step, exact wording)
project: Welra
type: checklist
updated: 2026-06-12
tags: [welra, tasks, ryan, action-list]
---

# Ryan's Action List — do in this order

Everything Claude can't do for you, sequenced by impact. Exact wording included or linked. Total: ~45 min of unblocks today + ~75 min press batch whenever you have it.

---

## Batch A — Infrastructure unblocks (~45 min, do today)

### ~~A1. GitHub PAT `workflow` scope~~ ✅ DONE 2026-06-12 — Claude pushed all 17 queued commits incl. the CI workflow.

### ~~A2. Fresh e2e auth test~~ ✅ DONE 2026-06-12 — email change passed (both addresses confirmed, landed on settings).

### A8. Brand the auth emails — Supabase custom SMTP via Resend (10 min) — NEW
Auth emails currently send from Supabase's shared sender, which looks confusing/phishy to users. Your Resend account already has welra.io verified (DKIM/SPF live), so point Supabase at it:
1. **supabase.com/dashboard** → Welra project → **Project Settings → Authentication** (or Authentication → Emails) → **SMTP Settings** → enable **Custom SMTP**.
2. Enter exactly:
   - **Sender email:** `auth@welra.io`
   - **Sender name:** `Welra`
   - **Host:** `smtp.resend.com`
   - **Port:** `465`
   - **Username:** `resend`
   - **Password:** your Resend API key (the `re_...` key — same one in Railway as RESEND_API_KEY)
3. Save. Bonus: custom SMTP also lifts Supabase's built-in ~2-emails/hour rate limit — which would have throttled real signups at launch.
4. Then **Authentication → Email Templates**: rebrand the four templates (Confirm signup / Magic link / Change email / Reset password). Paste this body, swapping the heading per template, and set subjects like "Confirm your Welra account", "Confirm your new email — Welra":
   ```html
   <div style="font-family:-apple-system,sans-serif;max-width:480px;margin:0 auto;padding:32px 20px;color:#1f2937;">
     <div style="font-size:22px;font-weight:700;color:#0F1E33;margin-bottom:16px;">Welra</div>
     <h2 style="font-size:18px;color:#0F1E33;">Confirm your email</h2>
     <p style="color:#444;line-height:1.6;">Click the button below to continue. This link expires in 24 hours. If you didn't request this, you can safely ignore this email.</p>
     <a href="{{ .ConfirmationURL }}" style="display:inline-block;background:#2FD6A6;color:#0F1E33;padding:12px 24px;border-radius:8px;text-decoration:none;font-weight:600;">Confirm →</a>
     <p style="font-size:12px;color:#9ca3af;margin-top:32px;">Welra · GR3NB LLC · ryan@welra.io</p>
   </div>
   ```
5. Test: send yourself a password-reset email and confirm it arrives from **Welra &lt;auth@welra.io&gt;**.

### A3. Connect Rust & Rainbow's Printify token (10 min) — first live fetcher + first dogfood beta
1. Log into **printify.com** with the R&R account → **My Account → API** (printify.com/app/account/api).
2. Click **Generate** (Personal Access Token) → copy the token.
3. Go to **welra.io/dashboard/integrations** (logged into your Welra account) → **Printify card** → paste the token → **Connect**.
4. Optional but valuable: connect **Instagram** on the same page using R&R's posting token + IG business account ID (same creds the NAS agent uses).
5. Tell Claude it's connected — Claude verifies the fetched totals against Printify's own dashboard (especially `total_price` semantics).

### A4. Sentry account + DSN (10 min) — error monitoring goes live instantly
1. Go to **sentry.io** → sign up (free Developer plan is fine) → create org (e.g. "welra").
2. **Create Project** → platform **Node.js** → name it `welra-api`.
3. Copy the **DSN** (looks like `https://xxxx@xxx.ingest.sentry.io/123`).
4. Railway dashboard → **welra** service → **Variables** → add `SENTRY_DSN` = the DSN → save (Railway redeploys automatically).
5. Tell Claude — Claude confirms the "Sentry initialized" boot line in Railway Logs.

### A5. Shopify "Protected customer data access" toggle (10 min) — gates ALL real-store installs
1. Go to **partners.shopify.com** → **Apps** → the Welra app → **API access** (left nav).
2. Find **"Protected customer data access"** → click **Request access**.
3. Select the **"Protected customer data"** level (orders). Do NOT request the name/address/email/phone field add-ons — we don't read them.
4. Reason for each prompt (paste, adapt as needed — note: no "AI" anywhere):
   > "Welra emails store owners a weekly summary of their own shop's performance. We read order totals, dates, and line items to compute weekly revenue and top products for the store owner only. Data is aggregated per-store, never shared, and raw order data is not retained after the summary is generated."
5. For dev stores this is self-serve (instant). Public-app review comes later — not needed for beta.

### A6. Termly privacy policy edit (10 min) — CSV retention wording
1. Log into **Termly** → open the Welra Privacy Policy → find the data-retention section (the "raw platform data is deleted after report generation / never stored long-term" language).
2. Replace/extend that passage with this (adjust to Termly's editor format):
   > **Connected platforms (Etsy, Shopify, WooCommerce, Printify, Instagram):** we fetch your shop data at report time, aggregate it into your weekly report, and do not retain the raw data afterward.
   >
   > **CSV uploads:** when you upload a CSV export, we store the normalized order records it contains (order date, order ID, and order amount) in private storage so your future weekly reports can include them. This uploaded order data is deleted when you cancel your subscription. Your report history is retained for 12 months after cancellation and then deleted automatically.
   >
   > You can export all of your reports as a ZIP file at any time from your account settings page.
3. While in there, scan for any promise of "automated" data-subject-request handling — if present, soften to "contact us at ryan@welra.io and we will process your request" (manual handling is what exists).
4. Publish. Done — this closes the last open item from the privacy audit.

### A7. Confirm app redirect URLs (5 min, can ride along with A5)
- **Shopify** (Partner Dashboard → app → Configuration): Allowed redirection URL must include
  `https://welra-production.up.railway.app/integrations/shopify/callback`
- **Etsy** (developer portal, the WELRA account — never the R&R one): callback URL must be
  `https://welra-production.up.railway.app/integrations/etsy/callback`
  (Etsy app is pending the 6/25 reapproval — just confirm the URL is saved correctly.)

---

## Batch B — Press setup batch (~75 min, this week)

All copy is **paste-ready** in [[Projects/Welra/Press_Drafts]] — only `[bracketed]` bits need your input. Never write "AI" in any of it. Suggested order (same as the drafts doc):

1. **Qwoted profile** (15 min) — qwoted.com → "Sign up as a Source" → paste §1 of Press_Drafts (headline, bio, tags, website welra.io/press).
2. **Featured.com profile** (10 min) — featured.com → "Become a contributor" → paste §2. Style note: write the quotable line FIRST in every answer.
3. **SourceBottle profile** (10 min) — sourcebottle.com → "I'm a Source" → categories: Business & Finance, Web & Tech, Lifestyle → paste the 50-word bio from §3.
4. **BetaList submission** (20 min) — betalist.com → Submit Startup → paste §4 verbatim (tagline: "One plain-English report. Every platform. Every Monday."). Upload og-card.png from welra.io/press + a full-page screenshot of welra.io.
5. **Google Form survey** (20 min) — create "The 5-Minute Seller Analytics Survey" exactly per §5 (7 questions, no email collection, anyone-with-link). Then post the distribution post (§5, bottom) in ONE friendly community to start — it deliberately contains no Welra link.
6. **First podcast pitch (Friday)** — start with the smallest show. Before sending: confirm the show published in the last 60 days and fill the `[recent episode]` line. Drafts in §6a–6c + generic template §6d. One pitch per week; follow up once after 7–10 days (§6 footer).

Ongoing cadence after setup: answer 2–3 source requests/week in the Friday slot; log any pickup in the Marketing_Campaign metrics table.

---

## Batch C — Calendar / blocked (no action today)

- **Jun 25:** Etsy reapplication (scheduled reminder exists). Use [[Projects/Welra/Etsy_API_Approval_Strategy]] copy VERBATIM. Log into the Welra Etsy account (never R&R), Claude fills the form, you click submit.
- **Mon Jun 15:** Claude checks Railway logs for the Sunday cron (first true e2e report run, dry-run on). Nothing for you unless it fails.
- **Beta recruitment** (Marketing Phase 1): starts after A3 + the press batch — the give-first Reddit/FB week, then beta-tester posts + 20 DMs. Templates are in [[Projects/Welra/Marketing_Campaign_2026-06]] Phase 1.
- **Stripe live mode:** stays blocked until beta validates report quality. Don't touch yet.

---

Related: [[Projects/Welra/Tasks]] · [[Projects/Welra/Continuation_Playbook]] · [[Projects/Welra/Press_Drafts]] · [[Projects/Welra/Press_Playbook]]
