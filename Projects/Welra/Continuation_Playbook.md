---
title: Welra Continuation Playbook — START HERE for any new session
project: Welra
type: playbook
updated: 2026-06-20 (session 22 — product shipped, the gate is go-to-market; warm network = path to user #1)
tags: [welra, playbook, onboarding, continuation]
---

# Welra Continuation Playbook

**Audience: any Claude session (any model), any tool, or any human picking up Welra cold.** This is the single entry point. Read this, then the docs in §5 as needed. Verified as of **2026-06-20 (session 22)**.

## 1. What Welra is

SaaS by Ryan Northam (GR3NB LLC, ryan@welra.io): one **clear weekly business report** for e-commerce sellers, emailed every Monday (on a mission to help small shops grow). Pricing $19/$69/$129 (Starter/Pro/Growth; Growth annual 25% off is deliberate). Brand = "weekly radar" (radar-sweep icon, ink-navy/teal/amber palette). **Language rule: never lead with "AI" in marketing or platform-facing copy; the benefit is a *clear* read on their shop — say "clear", not "plain English". AI disclosure lives in the privacy policy only.** Canonical voice/style: [[Projects/Welra/Brand_Identity]]. (This rule exists because Etsy denied our API application partly over AI-flavored surface copy.)

## 2. Where things stand (the honest snapshot)

> **⚠️ The honest bottleneck (unchanged, now ~22 sessions in): Welra has 0 customers, 0 revenue, Stripe still in TEST mode.** The product is essentially built and shipping; **the business hasn't started.** The loop is customer-driven: every task ranked "does this get/keep/unblock a *paying customer*?" (T0–T3). Live planning surface = the **This Week** block + **Focus Sheet** at the top of [[Projects/Welra/Tasks]] (everything under the Archive line is cold storage). **The #1 task is go-to-market and Ryan-owned: land beta user #1.** Don't build a frozen/T3 task until ≥3 active users need it. Run the loop with `/welra`.

- **Product is live and working.** Reports unblocked (synthesis on `claude-sonnet-4-6` via `REPORT_SYNTHESIS_MODEL`; haiku hallucinated). `REPORT_DRY_RUN=false` since 6/14. `api.welra.io` is the live API host. Web `welra.io` live. **`welra.io/sample` is LIVE (s22)** — a dedicated page showing the FULL real report + beta CTA; the shareable asset for outreach (pairs with the homepage `#sample` excerpt + email-capture). Report email rendered raw markdown (`**`/`---`) on EVERY report — **found by dogfooding s22, fixed + deployed** (`renderSynthesisHtml()` in reportRenderer.ts) before user #1 ever saw it.
- **Ingestion that works:** CSV upload + WooCommerce REST + **Printify (LIVE, token — covers R&R's Etsy POD sales, no Etsy API)** + **Instagram engagement (LIVE, Graph v22)**. **Shopify fetcher BUILT but unverified** (needs a dev-store install + "Protected customer data access" toggled in the Partner Dashboard). Etsy fetcher NOT built (blocked on API approval). Connect UI live for all at `/dashboard/integrations` (Instagram demoted s20 to an optional section — CSV is the hero). Platform decisions: [[Projects/Welra/Platform_Feasibility_2026-06]].
- **Recruitment reality (the real lesson, s21–s22):** BOTH cold channels penalize a *brand-new identity* — Reddit (new-account AutoMod removals + DM rate limit) and Facebook (new-member group auto-decline). **Ryan has NO aged personal account anywhere** (deleted his real FB years ago), and R&R is $0 sales / 3 IG followers — so cold communities AND the R&R audience are slow/weak paths. **DECISION: warm network — sellers Ryan personally knows, reachable by any channel — is the real route to beta user #1.** Cold communities are a 1–2 week warming play. The give-first comments, group shortlist, CSV export guide, and DM copy are all ready in [[Projects/Welra/Marketing_Campaign_2026-06]] + [[Projects/Welra/CSV_Export_Guide]] + Tasks §A–E. The moment a seller says yes → take their CSV → run the real pipeline → return a report same-day.
- **Etsy API: DENIED.** Reapply on/after **2026-06-25** (reminder `etsy-api-resubmit-reminder` fires 9am Jun 25); exact copy in [[Projects/Welra/Etsy_API_Approval_Strategy]] — verbatim, do NOT improvise. Welra's denial is SOFT/reviewable (fixable use-case + third-party-app wording, already addressed by the de-AI'd site); R&R's `rust-and-rainbow` API app is terminally banned — never submit from it, never network-evade. Emailed developer@etsy.com s19 to confirm reapply mechanics — watch ryan@welra.io for the reply. **Etsy is a friction-reducer, NOT a customer blocker — Printify/CSV serve Etsy sellers today.**
- **Deploys (CONFIRMED working s22):** API = `railway up --service welra` (CLI authed, project linked → healthcheck/`/health` 200); web = `npx vercel deploy --prod` from the **repo root** (`.vercel` is linked there, authed as rcn723). Git push works but does NOT auto-deploy. s20's Instagram-demote + Graph-v22 fix are now deployed (shipped in the s22 deploy).
- **Pending / open checks:** Sentry DSN not set; Resend Audience not enabled (`RESEND_AUDIENCE_ID` unset → lead capture stores + sends sample, just no Broadcast sync); refresh `META_ACCESS_TOKEN` before ~6/25 (IG token; auto-refresher exists); Meta Business Verification (the long pole for public Instagram OAuth) not started — parked until after beta.

## 3. The path (do in this order)

The build is essentially done; **the gate is go-to-market, not code.**

1. **Land beta user #1 — WARM (Ryan-owned, THE task).** Reach a seller he actually knows (any channel) with the free-weekly-report offer; show `welra.io/sample` as proof. In parallel, cold accounts (Reddit/FB "Rust Rain") warm for ~1–2 weeks. (See [[Projects/Welra/Marketing_Campaign_2026-06]].)
2. **Onboard user #1 end-to-end & sit with their first REAL report** (Ryan + Claude). First time Welra runs on outside seller data. Judge it cold: accurate? honest? worth $19+/mo? This conversation generates the *real* backlog.
3. **Etsy reapply on/after 6/25** (Ryan logs into the Welra Etsy account, fills the form verbatim from the strategy doc, clicks submit). If approved → build the Etsy fetcher. Still not a customer blocker.
4. **Stripe live mode** — ONLY after a validated beta user says they'd pay. Recreate products/prices, swap sk_live/pk_live/price IDs in Railway+Vercel, create the live webhook via API, verify all 6 STRIPE_PRICE_* match live IDs. Then launch per [[Projects/Welra/Growth_Plan_2026-06]] G1.
5. **Deferred / gated (don't build until a real user needs it):** per-plan connection caps NOT enforced (revenue leak at charge time — go-live gate); commit the applied-but-uncommitted migrations; reportGenerator unchecked-update-error; Monday Radar newsletter; Free Report Friday tooling.

**Growth phases G1–G5:** [[Projects/Welra/Growth_Plan_2026-06]]. **Architecture invariants + scaling cliffs:** [[Projects/Welra/Architecture_Roadmap]] (run its 15-min check-in at each gate + at 25/100/500 customers).

**🚫 Do-not-touch (current rabbit holes):** Stripe live mode (gated on a validated user); Etsy submission before 6/25; Meta App Review submission. Separately, **Rust & Rainbow is a SIDE project — its TikTok API + IG→FB cross-posting are OFF the beta-user-#1 path; don't let them eat a session.** (R&R FB cross-post code is built but blocked on Ryan minting a fresh Page token; TikTok needs Ryan to resubmit + change the console contact email.)

## 4. Operating rules (non-negotiable, learned the hard way)

1. `tsc --noEmit` + `npm run build` locally before EVERY deploy. API deploy = `railway up --service welra` ONLY (git push does not deploy). Verify via Railway **Logs** tab (not Deploy tab): boot lines for all workers + health 200.
2. Run the `arch-review` skill before calling any schema/multi-service change done; fix BLOCKERS before closing; log new patterns to `feedback_scaffold_quality.md` (40+ patterns and growing). A passing eval that scores raw text is NOT proof the rendered artifact is correct — render it and look (s22 markdown bug).
3. Lazy-init every SDK/Queue. Never `as`-cast DB rows to domain types (use boundary mappers). Tokens AES-encrypted. New datasets enter retentionCron in the same PR. Every Claude call metered per customer.
4. Compliance lines that must never break: Etsy data never cross-shop/benchmarks/training; EU billing rejected; only verified-payment Stripe statuses grant access; privacy policy updates BEFORE features ship.
5. **Vault / memory loop (Ryan's s22 correction — [[feedback-close-the-memory-loop]]):** read `_Dashboard` + `_Inbox/To_Claude` + this playbook at session START; **check what already exists before building (don't re-invent);** update State + Worklog + To_Antigravity after ANY milestone/deploy — NOT just at session end. Frontmatter + wikilinks on every note.

## 5. Document map (which doc answers what)

| Question | Doc |
|---|---|
| Live status, session history | [[Projects/Welra/State]] |
| What's open, who owns it (Focus Sheet + T0–T3) | [[Projects/Welra/Tasks]] |
| Beta recruitment + outreach copy + give-first comments | [[Projects/Welra/Marketing_Campaign_2026-06]] |
| Per-platform CSV export steps (verified) | [[Projects/Welra/CSV_Export_Guide]] |
| Blog/content cadence + topic backlog | [[Projects/Welra/Content_Calendar]] |
| Etsy reapplication (exact copy, do/don't) | [[Projects/Welra/Etsy_API_Approval_Strategy]] |
| Meta App Review / Business Verification plan | [[Projects/Welra/Meta_App_Review_Plan]] |
| Dev-app review "icon doesn't match brand" fix | [[Knowledge_Base/Platform_App_Review_Runbook]] |
| Shopify app setup / redirect URLs | [[Projects/Welra/Etsy_Shopify_Developer_Applications]] |
| Brand: icon, palette, typography, voice | [[Projects/Welra/Brand_Identity]] |
| Growth phases, gates, on-demand product | [[Projects/Welra/Growth_Plan_2026-06]] |
| Infrastructure, invariants, cliffs, check-ins | [[Projects/Welra/Architecture_Roadmap]] |
| Privacy promises vs reality | [[Projects/Welra/Privacy_Audit_2026-06-10]] |
| DNS/domain/SSL troubleshooting | [[Knowledge_Base/DNS_Domain_Runbook]] |

**Repo:** `~/Claude/Projects/side business/Welra` (GitHub rcn723/welra). **Secrets:** all in Railway env. **Sample report:** `welra.io/sample` (live) + `apps/api/scripts/dogfood-report.ts` regenerates it. **E2E audit:** `Workflow({ name: 'welra-e2e-audit' })` before production deploys. **Eval:** `npm run eval` in apps/api.
