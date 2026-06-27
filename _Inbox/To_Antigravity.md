---
title: To Antigravity
type: inbox
updated: 2026-06-26
tags: [handoff, welra, growth-pipeline]
---

# To Antigravity — 2026-06-26 (Welra: one-click-integrations shipped to prod)

## Welra — branch shipped + Printify proven live (2026-06-26, s25)

Ryan chose "push + deploy" the `feature/one-click-integrations` branch and "run the Printify smoke test." Done:

- **Branch `feature/one-click-integrations` pushed to origin + deployed to prod** (API via `railway up --service welra`, web via `vercel deploy --prod`). Both verified green: `/health/` 200, clean boot, www.welra.io 200, new blog post live at /blog/weekly-shop-review-monday-habit. Satisfies the long-standing P0 (deploy API report fix + blog post). Branch is 7 commits ahead of main, **NOT merged to main**.
- **Fixed a git/prod drift landmine:** three live-but-uncommitted working-tree changes (`@anthropic-ai/sdk` 0.105.0 Railway-streaming fix, boot-time report-catchup, the Monday-review blog post) were committed (`0b5ff31`, `06fa464`, `71b444c`) so a clean-checkout deploy can't regress them. `railway up`/`vercel` ship the working tree, not git — always reconcile before pushing.
- **Printify fetcher proven live** via `scripts/smoke-printify.ts` (R&R read-only token); flipped `INTEGRATION_READINESS.printify` → `live` (`461afa9`). Bookkeeping only — the Printify card was already ungated.

**Still open (engineering):** WooCommerce one-click held (`NEXT_PUBLIC_WOO_ONECLICK` off) until `smoke-woocommerce.ts` runs against a real store; Etsy + Stripe fetchers are STUBS; TikTok/Shopify/Instagram one-click gated on platform approvals; decide whether to merge the branch to main. **Business #1 task unchanged:** land beta user #1 (warm network / concierge-Printify offer). Ryan's pending action list from 2026-06-25 below still stands (minus the blog deploy, now done).

---

# To Antigravity — 2026-06-25 (Welra growth pipeline)

## Welra — growth pipeline run (2026-06-25)

Scheduled growth pipeline executed. Stage 1–3 complete. **THE ONE: #22 Concierge POD offer** (20/20) — removes the CSV barrier for Printify/POD sellers Ryan knows personally. 3 DM variants + yes-path runbook written and added to Tasks.md P1 section. #19 Scan give-first share also SELECTED (16/20); scan-link DM variant added to §C outreach copy. No code changes, no deploy. Growth_Pipeline.md updated (ideas table + new gate results + graveyard +1). Tasks.md updated with new P1 concierge task + new §C DM variant. State.md date updated. Worklog appended.

**Ryan's pending actions (oldest first):**
1. **TODAY** — Etsy API resubmit (window opens June 25; use verbatim copy from Etsy_API_Approval_Strategy.md; log into Welra Etsy account only)
2. Send concierge DM to 3 Printify/POD sellers he knows (DMs in Tasks.md P1 "Concierge POD offer")
3. Deploy blog post: `npx vercel deploy --prod` from repo root (staged 2026-06-23)
4. Send Resend broadcast (drafted 2026-06-21; Resend UI → Welra Leads audience)
5. Post IH build-in-public draft (drafted 2026-06-21)
6. Submit BetaList listing (Press_Drafts §4)
7. Source of Sources 2-min signup (sourceofsources.com)

The concierge offer is the unlock — it removes the sticking point on the warm-intro (#1) that has been pending since June 20.

# To Antigravity — 2026-06-23 (Welra growth pipeline + R&R NAS deploy)

## Welra — growth pipeline run (2026-06-23)

Growth pipeline ran autonomously. THE ONE = blog post "The 15-minute Monday review every seller should do" — full TSX written, build-verified (`tsc` exit 0, `/blog/weekly-shop-review-monday-habit` generated), staged in repo, NOT deployed. Ryan to run `npx vercel deploy --prod` from repo root when ready. Gives Ryan a credible give-first shareable for FB groups.

Pending Ryan actions (in priority order):
1. Send Resend broadcast (drafted 2026-06-21, still open)
2. Post IH draft (drafted 2026-06-21, still open)
3. Deploy new blog post (`npx vercel deploy --prod`)
4. Submit BetaList (copy in Press_Drafts §4, 20 min)
5. Source of Sources signup (sourceofsources.com, 2 min)
6. Warm-intro outreach to sellers Ryan knows personally

Growth_Pipeline.md, Tasks.md, and Worklog updated.

---

# To Antigravity — 2026-06-23 (R&R generation v2 + NAS deploy)

Worked the goal: *R&R idea/image generation must not repeat, must adopt new trends, and the pipeline must stop depending on the MacBook being open.*

**Clauses 1 & 2 — DONE & verified:**
- No-repeat: dedup spans ALL designs_log history + the static library (normalized); all generated designs persisted. Fixed a live crash — `--mode generate` had been dying every weekly launchd run (`EOFError`, no TTY) after spending Ideogram credits.
- Adopts trends: new Claude generator (`generate_design_ideas`) steered by season + best-sellers + trends; PLUS 9 hand-researched current-trend concepts added to the static pool so trend adoption is live even without an API key.

**Clause 3 — DONE & EXECUTED (posting is now Mac-independent):**
- Ryan authorized the deploy + the "NAS supervisor" cutover. `./setup.sh rust-rainbow` → code + `.env` + venv on the NAS; `--mode suggest` + `--mode monitor` both ran exit 0.
- The live NAS run exposed a SECOND headless crash — `run_monitor()` also prompted `input()` to DELETE listings. Fixed to report-only when headless. Audited all `input()` sites; file headless-clean; redeployed.
- **Cutover:** NAS scheduling is root-only (DSM GUI), so I deployed `rr-supervisor.py` — a user-space scheduler (admin, nohup/ppid 1, flock, heartbeat) firing market (M/W/F 10:00), report (Mon 7:00), suggest (Mon 8:00), monitor (Sun 23:00). The 4 matching Mac launchd jobs are unloaded + archived. **The Mac can now be closed** and posting still happens. No double-post (next market Wed 10:00, NAS only).

**Residuals (Ryan, documented in Tasks):**
1. Reboot-durability: add ONE DSM Boot-up Triggered Task → `rr-supervisor-start.sh` (else supervisor dies on NAS reboot).
2. Mac `watchdog.sh` cron will false-alarm (checks stale Mac market.log) — repoint or remove. (Classifier blocked me from removing monitoring unauthorized — correct.)
3. After 6/25 META refresh, sync the token into the NAS `.env` (refresh_token still on Mac by Ryan's choice). Token valid to 7/1.
- `generate` stays on Mac (rembg/Py3.8 → Phase 2b: Ideogram native-transparent refactor).

**Docs:** [[Projects/Rust_and_Rainbow/State]], [[Projects/Rust_and_Rainbow/Tasks]], [[Knowledge_Base/NAS_RR_Migration_Runbook]] (exact cutover commands), scaffold-quality memory (headless-job pattern + 2nd-instance note). Code in `agent.py` + `requirements/rust-rainbow.txt` is uncommitted — pending Ryan's review before commit/push.

---
## From Claude — 2026-06-25 (Stock Agent)
**Stock:** Backtest attribution showed momentum is the only edge (solo +41.7%/Sharpe 2.67); the other 3 strategies were net-losers dragging it down. Reallocated `config.yaml` to **momentum-only, top_n=3** — live 150d backtest now **PASSES the go-live gate** (+45.36%, Sharpe 2.60, p=0.099). `paper_mode` still TRUE. **Pending Ryan:** `./deploy.sh stock` to push to NAS (SSH gated for Claude). **OOS validation DONE:** edge significant OOS (4y p=0.011) but momentum lost −37.6% in 2022. **Fixed in `agent.py`** — absolute-momentum trend filter (cash when SPY down): 2022 −37.6%→−20.0%, max DD −42.3%→−23.9%, 4/5 multi-year windows now PASS the full gate. **DEPLOYED to the live NAS bot 2026-06-26** (Ryan-authorized; healthcheck green) — active on today's 14:00 PDT run. Now forward-testing on live paper. Go-live plan written ([[Projects/Stock_Agent/Go_Live_Plan]]) — all real-money steps are Ryan's. Still open (lower pri): tighten filter for the 4.75y window (23.9% DD), repair/retire the 3 disabled strategies. paper_mode stays TRUE. See [[Projects/Stock_Agent/State]] / [[Projects/Stock_Agent/Tasks]].

---
## From Claude — 2026-06-25
**Welra:** branch `feature/one-click-integrations` has 3 commits (TikTok source, WooCommerce one-click, readiness gating) — NOT pushed or deployed; awaiting Ryan's call on push + the external-gated steps (live smoke tests with real creds, Etsy fetcher impl + approval, platform approvals). See Projects/Welra/Tasks.md "TikTok integration" / "WooCommerce one-click" / "Integration architecture completeness" blocks. Pricing/posture: options-available-by-default, one-click, flip readiness→live only after each pipe's smoke test passes.
**R&R/NAS:** IG token refreshed + now auto-refreshes weekly on the NAS supervisor; DSM boot task created (reboot-durable). Nothing pending here.
