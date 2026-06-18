---
title: To Antigravity
type: inbox
updated: 2026-06-16
tags: [handoff, welra, voice, session-20]
---

# To Antigravity — 2026-06-16 (session 20)

**Session 20 — beta-recruitment prep + small fixes (2 files changed, NOT deployed).** Focus stayed on landing beta user #1; the code work was light.

- **Pricing reconciles** (Starter=1 / Pro=3 / Growth=unlimited platforms — "up to 3" is only Pro). **But a real bug:** plan caps are marketing copy only, no connect route enforces them by plan → a $19 Starter user can connect all 6. Harmless in free beta; logged high-pri as a Stripe-go-live gate in [[Projects/Welra/Tasks]].
- **Instagram demoted** to an "Optional — add your Instagram engagement" section in `dashboard/integrations/page.tsx` (out of the sales grid; CSV leads). The one-click FB-Login is gated behind Meta App Review; manual token path is too technical for mom-and-pop. tsc + web build green, **not deployed**.
- **Graph API version fix:** `oauth.ts` was v21, fetcher `instagram.ts` was v22 → bumped oauth to v22 + cross-ref comments. API tsc + build green, **ships with next `railway up`**.
- **Meta App Review plan** → [[Projects/Welra/Meta_App_Review_Plan]]. **Decision: start Meta Business Verification now, in parallel with recruiting** (one sitting, ~a week in background). Screencast/submission/button-flip parked until after beta.
- **Outreach pack:** Reddit is blocked to all Claude tooling, so a manual hunt recipe (4 `sort=new` URLs + filter), 5 give-first comments, and 3 DM variants are consolidated into a **📋 Outreach copy** block + a **🎯 Focus Sheet** at the top of [[Projects/Welra/Tasks]]. Demo asset [[Projects/Welra/Sample_Report_Demo.html]] built to screenshot for prospects.
- **DMARC/SPF:** root welra.io has no SPF → PrivateEmail sends pass by DKIM only; fix (`v=spf1 include:spf.privateemail.com ~all` on `@`) logged for the send-as DNS work. Not a blocker.
- **Learning loop:** 2 new bug patterns logged (entitlement-not-enforced; intra-integration version drift); arch-review SKILL.md + MEMORY.md updated.
- **The one next action (Ryan-owned, unchanged):** warm the new Reddit account via give-first comments now, send 5 DMs once it unlocks (~1–2 days), start Meta Business Verification. **Still 0 beta users, 0 revenue. Nothing deployed this session.**

---

# To Antigravity — 2026-06-15 (session 19)

**Session 19 — engineering-loop reframe (no code shipped; planning + tooling).** Ryan asked to "get an engineering loop going for Welra." Pushed back: the product is ~18 sessions mature but has **0 customers / 0 revenue / Stripe still TEST** — so the bottleneck is go-to-market, not engineering throughput. Reframed the loop from backlog-driven to **customer-driven** and adopted a **T0–T3** ranking rule (does it get/keep/unblock a paying customer?).

- **[[Projects/Welra/Tasks]] restructured:** new ranked **This Week** block (5 items) + **Frozen** list; everything else moved under an **Archive** banner = cold storage. This Week is the only planning surface now. Re-rank it each session; promote ≤1–2 items from Archive.
- **Etsy:** application is done/as-good-as-it-gets (don't re-tinker), can't submit before 6/25, and is NOT a customer blocker. Real lever = identify why rust-and-rainbow was banned + prep the separate-business case.
- **R&R:** advised against deleting the R&R developer app before reapply (no separable dev account; won't unlink; destroys ban evidence; evasion optics). Keep the shop.
- **Tooling:** `~/.claude/commands/welra.md` (`/welra` loop command); reframe mirrored into [[Projects/Welra/Continuation_Playbook]] §2.
- **The one next action (Ryan-owned):** recruit beta user #1 via CSV/Woo/Printify. The loop flips to customer-driven the moment one real seller's data flows.

---

# To Antigravity — 2026-06-15 (session 18, full)

Big session. All changes are deployed + verified live (web on Vercel, API on Railway `a1593ce2`, Supabase `ozhekoiehpajeytwltrv`). Read [[Projects/Welra/State]] §Session 18 for the blow-by-blow and [[Projects/Welra/Tasks]] for open items.

## Shipped this session
1. **Delivered-status honesty fix** — new `reports.email_sent_at` (the real proof an email sent); `status='delivered'` now means "generated & viewable" only.
2. **Report self-heal** — scheduler skips customers with no connected data source and sends a "connect a platform" SETUP REMINDER instead (unsubscribe + dry-run gated, 28-day cap); new hourly **catch-up cron** `reportCatchupCron.ts` re-delivers any overdue+undelivered report immediately; late reports get an apology banner + "(a little late)" subject. **Late = past 2h** (catch-up starts recovering at +30min).
3. **Marketing capture** — "free sample report" lead magnet on homepage, blog, every blog post, and FAQ → `POST /leads` → `leads` table (RLS on) + Resend **"Welra Leads"** audience (`RESEND_AUDIENCE_ID` set, contact sync verified) + sample-report email.
4. **Follow-through / congratulations** in the weekly report (Pro+Growth) — celebrates measured outcomes on last week's actions, never claims the seller acted. Report eval harness extended + new golden; **eval 4/4 honesty-clean**.

## ⚠️ VOICE CHANGE — important for any copy you write
- **Say "clear", NOT "plain English."** "Plain English" reads stock/AI and is retired. Use "a clear read", "clear weekly report", "written clearly". (Ryan's call this session.)
- **Small-business growth & success is the throughline** — frame benefits around helping small shops grow ("the next move to grow your shop", "help small shops grow", "make confident decisions"). Mission line: **"On a mission to help small shops grow — one clear decision at a time."**
- **Keep cadence words out of evergreen taglines/mission** (no "weekly"/"Monday"/"one Monday at a time") so they survive an on-demand product. Cadence is fine in feature copy.
- **Still never lead with "AI."** Honesty rule still absolute (celebrate outcomes, never claim a cause or an action the data can't show).
- **Canonical source of truth: [[Projects/Welra/Brand_Identity]]** (Voice & language section, updated this session). Marketing/Press/Content-Calendar/Auth-email/Continuation-Playbook docs were all updated to match; historical session logs + completed-task records were intentionally left as-is.

## Open / next
- Optional: drain leftover no-data test-account retry jobs (Ryan chose "let them finish" — finite, self-terminating). Real customers unaffected.
- Marketing next: syndicate posts to LinkedIn/Medium (needs Ryan's accounts; Claude can draft), send a Broadcast to the Welra Leads audience.
- Follow-through precision upgrade (store prior actions structured) + decide if Starter gets follow-through.
- Etsy API reapply on/after 6/25; refresh META_ACCESS_TOKEN before 6/25.
