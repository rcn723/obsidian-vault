---
title: Welra Continuation Playbook — START HERE for any new session
project: Welra
type: playbook
updated: 2026-06-12
tags: [welra, playbook, onboarding, continuation]
---

# Welra Continuation Playbook

**Audience: any Claude session (any model), any tool, or any human picking up Welra cold.** This is the single entry point. Read this, then the docs in §5 as needed. Everything here is verified as of 2026-06-11.

## 1. What Welra is

SaaS by Ryan Northam (GR3NB LLC, ryan@welra.io): one **plain-English weekly business report** for e-commerce sellers, emailed every Monday. Pricing $19/$69/$129 (Starter/Pro/Growth; Growth annual 25% off is deliberate). Brand = "weekly radar" (radar-sweep icon, ink-navy/teal/amber palette). **Language rule: never lead with "AI" in marketing or platform-facing copy — "plain-English" is the benefit; AI disclosure lives in the privacy policy only.** This rule exists because Etsy denied our API application partly over AI-flavored surface copy.

## 2. Where things stand (the honest snapshot)

- **Billing:** Stripe TEST mode, fully validated e2e. Live-mode switch deliberately waits for beta validation.
- **Ingestion that works:** CSV upload + WooCommerce REST + **Printify (LIVE 2026-06-11, token-based — covers R&R's Etsy sales via POD data, no Etsy API needed)** + **Instagram engagement (LIVE, Graph API)**. **Shopify fetcher BUILT but unverified** — needs a dev-store install + "Protected customer data access" toggled in the Partner Dashboard. Etsy fetcher NOT built (blocked on API approval). Dashboard Connect UI live for all of the above (/dashboard/integrations). Platform decisions: [[Projects/Welra/Platform_Feasibility_2026-06]] (TikTok Shop = CSV now/API post-beta; Facebook sales API dead; Square/Gumroad next candidates). **First live verification pending: Ryan pastes R&R's Printify token.**
- **✅ RESOLVED 2026-06-11: Anthropic credits purchased → eval run + iterated to 3/3 PASSING (3 stable runs).** Key outcome: synthesis runs on `claude-sonnet-4-6` (set in Railway as `REPORT_SYNTHESIS_MODEL` — haiku synthesis hallucinated causal mechanisms in every run; haiku stays for pass-1 source analysis + judge upgraded to sonnet). Prompts hardened: causes only as "worth checking whether…", no absent metrics, no fabricated comparisons, actions justified only by the seller's own numbers. Report generation is UNBLOCKED.
- **Etsy API: DENIED 2026-06-10.** Reapply on/after **2026-06-25** (scheduled reminder `etsy-api-resubmit-reminder` exists, 9am Jun 25). Exact reapplication copy is in [[Projects/Welra/Etsy_API_Approval_Strategy]] — use it verbatim; do NOT improvise. Related: Ryan's other Etsy identity (rust-and-rainbow, same network) is banned over AI-generated content — never submit anything from that account, never attempt network/identity evasion.
- **Web:** welra.io is LIVE with the full brand, plain-English copy, Etsy trademark disclaimer, Founding Seller banner. Deployed via `npx vercel deploy --prod` (CLI authed as rcn723).
- **Git pushes WORK as of 2026-06-12** (Ryan added `workflow` scope to the PAT; full backlog incl. CI workflow pushed to rcn723/welra). ⚠️ Pushing still does NOT deploy: API deploys via `railway up --service welra`, web via `npx vercel deploy --prod` (Railway GitHub auto-deploy still unwired — dashboard Settings → Source).
- **Pending checks:** Sunday cron first-fire 2026-06-14 = first true e2e report test, dry-run ON (check Railway logs Monday); Sentry DSN not set; fresh e2e auth test after the Site-URL fix (throwaway signup + email change — see Tasks); Ryan to connect R&R's Printify token (first live fetcher verification). RESOLVED 6/11: waitlist table (already existed), platform CHECK (printify+instagram migrated), Supabase Site URL localhost→www.welra.io + wildcard redirect allowlist.

## 3. The path (do in this order)

**Now (blocked-on-Ryan items to nudge):** ① ~~Anthropic credits~~ DONE 6/11 (eval 3/3). ② PAT `workflow` scope → push (unblocks CI + future web deploys). ③ Sentry account + SENTRY_DSN in Railway. ④ Termly privacy edit (CSV retention wording only). ⑤ Shopify Partner Dashboard: enable Protected customer data access (gates real-store installs).

**Claude build queue (in order, no permission needed):**
1. ~~Shopify fetcher~~ DONE 2026-06-11 — verify against a dev store once one installs (date bucketing + protected-data gate).
2. ~~Dashboard "Connect Etsy/Shopify" buttons~~ DONE 2026-06-11 (/dashboard/integrations, incl. Woo form).
2b. ~~Web /dashboard/reports + /dashboard/settings~~ DONE 2026-06-11 (reports list/detail w/ PDF links; settings w/ editable name+timezone, secure email change, Stripe billing portal, ZIP export). All dashboard nav resolves.
3. ~~Free "Shop Radar Scan" page + shareable Week Cards~~ DONE 2026-06-12 (session 10) — welra.io/scan LIVE (public, nothing stored, rate-capped) + Week Card PNGs in every report email. Ryan's consolidated to-do: [[Projects/Welra/Ryan_Action_List_2026-06-12]]. **NEXT BUILD candidates:** Monday Radar newsletter scaffold (Phase 3 #3) or Free Report Friday tooling — but Mon 6/15 cron-log check and beta recruitment support come first.
4. Jun 25: Etsy reapplication (Ryan logs into the Welra Etsy account in Chrome; fill form from strategy doc; Ryan clicks submit). If approved → build Etsy fetcher (receipts + listings, access-token auto-refresh via 90-day refresh token).
5. Beta: 3–5 sellers via CSV/Woo per the campaign plan; Van Westendorp pricing questions in week 2.
6. Then: Stripe live mode → `REPORT_DRY_RUN=false` → launch per [[Projects/Welra/Growth_Plan_2026-06]] G1.

**Growth phases G1–G5** (gates, features, architecture): [[Projects/Welra/Growth_Plan_2026-06]]. **Architecture invariants + scaling cliffs + check-in protocol**: [[Projects/Welra/Architecture_Roadmap]] — run its 15-min check-in at every gate and at 25/100/500 customers; append to its Decision log.

## 4. Operating rules (non-negotiable, learned the hard way)

1. `tsc --noEmit` + `npm run build` locally before EVERY deploy. API deploy = `railway up --service welra` ONLY (git push does not deploy). Verify via Railway **Logs** tab (not Deploy tab): boot lines for all 4 workers + health 200.
2. Run the `arch-review` skill before calling any schema/multi-service change done; fix BLOCKERS before closing; log new bug patterns to memory (`feedback_scaffold_quality.md`, 28 patterns and growing).
3. Lazy-init every SDK/Queue. Never `as`-cast DB rows to domain types (use lib/integrationRow.ts-style mappers). Tokens AES-encrypted. New datasets enter retentionCron in the same PR. Every Claude call metered per customer.
4. Compliance lines that must never break: Etsy data never cross-shop/benchmarks/training; EU billing rejected; only verified-payment Stripe statuses grant access; privacy policy updates BEFORE features ship.
5. Vault discipline: read `_Dashboard` + `_Inbox/To_Claude` at session start; update State/Tasks during; log to Worklogs + `_Inbox/To_Antigravity` at end. Frontmatter + wikilinks on every note.

## 5. Document map (which doc answers what)

| Question | Doc |
|---|---|
| Live status, session history | [[Projects/Welra/State]] |
| What's open, who owns it | [[Projects/Welra/Tasks]] |
| Etsy reapplication (exact copy, do/don't) | [[Projects/Welra/Etsy_API_Approval_Strategy]] |
| Shopify app setup / redirect URLs | [[Projects/Welra/Etsy_Shopify_Developer_Applications]] |
| Marketing: beta recruitment + awareness plays | [[Projects/Welra/Marketing_Campaign_2026-06]] |
| Brand: icon, palette, typography, voice | [[Projects/Welra/Brand_Identity]] |
| Growth phases, gates, on-demand product | [[Projects/Welra/Growth_Plan_2026-06]] |
| Infrastructure, invariants, cliffs, check-ins | [[Projects/Welra/Architecture_Roadmap]] |
| Privacy promises vs reality | [[Projects/Welra/Privacy_Audit_2026-06-10]] |
| Strategy rationale / pricing decisions | [[Projects/Welra/Strategy_Review_2026-06-09]] |
| Repo-level conventions, routes, commands | `README.md` in the repo |

**Repo:** `~/Claude/Projects/side business/Welra` (GitHub rcn723/welra). **Secrets:** all in Railway env (incl. Etsy/Shopify creds, SHOPIFY_CLI_PARTNERS_TOKEN exp 2026-12-10). **E2E audit:** `Workflow({ name: 'welra-e2e-audit' })` before production deploys. **Eval:** `npm run eval` in apps/api.
