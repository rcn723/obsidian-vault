---
title: Dropship Pipeline — Tasks
project: Dropship_Pipeline
type: tasks
updated: 2026-07-04
tags: [dropship, automation]
---

# Dropship Pipeline — Tasks

## Open
- [ ] **Business plan revised to a <$100 cash-cap bootstrap ramp** — [[Projects/Dropship_Pipeline/Business_Plan_Dog_Cooling_Mats]]: Shopify dropped for a $0-hosting Vercel+Stripe storefront (reusing Welra's Vercel account, a NEW separate Stripe account — not Welra's, which stays untouched per its standing do-not-touch), initial cash ~$75-100 (test order + Round 1 ad seed), every round after funded by prior-round revenue. Start at Phase 0 [owner:: ryan] [priority:: high] [status:: open]
- [ ] Confirm Welra's Vercel account plan tier (Pro/Team vs. Hobby) before building the storefront there — Hobby tier's terms restrict commercial use — Phase 1, Step 7 of the business plan [owner:: ryan] [priority:: high] [status:: open]
- [ ] **Compare 3 dropship channels, not just CJ** (CJ read too expensive) — check Alibaba's own Dropshipping Center first (dropship-tagged suppliers, likely cheapest, ~20-40% below AliExpress/CJ per general research), then AliExpress, then CJ as fallback. All three block automated price-checking — must log in manually. Get real per-unit + shipping cost for the mat AND the bundle upsell item — Phase 1, Steps 1–4 of the business plan [owner:: ryan] [priority:: high] [status:: open]
- [ ] Check `dropship-pipeline/logs/launchd-stdout.log` weekly for the first month to confirm the 7am job actually fires (SETUP step 3) [owner:: ryan] [priority:: medium] [status:: open]
- [ ] [DEFERRED from arch-review] Before any Gate-5 ad spend: work the entity/compliance checklist in `dropship-pipeline/SETUP.md` (LLC placement decision, bank subaccount, resale certificate; nexus + insurance are post-traction) [owner:: ryan] [priority:: high] [status:: open]
- [ ] [DEFERRED from arch-review] Per-stage checkpointing for agents 2–4: a retry after a stage-3/4 failure re-runs and re-appends stage 2 (token cost + duplicate log entries; gates unaffected — scan-log is guarded) [owner:: claude] [priority:: low] [status:: open]
- [ ] [DEFERRED from arch-review] Obsidian Git will auto-commit `logs/` + `.last-run` daily — harmless noise; gitignore if it bothers [owner:: claude] [priority:: low] [status:: open]

## Done
- [x] Fixed prompt ambiguity in agents/03-plan-builder.md and agents/04-validator.md that let the validator agent try to write files directly, get blocked in headless mode, and leak "I don't have write permission" narration into verdicts-log.md; added `--allowedTools ""` to validator call sites; cleaned the contaminated 7/4 entry [owner:: claude] [status:: done] (2026-07-04)
- [x] Re-login the `claude` CLI — CONFIRMED RESOLVED 2026-07-03 (TODO consolidation session): verified `pipeline-run-2026-07-03.log` completed clean end-to-end with real API cost incurred (trend scanner $0.879, feasibility screener $0.069, both logs appended), no 401s. Pipeline is running itself every morning now. [owner:: ryan] [status:: done] (2026-07-03)
- [x] Install pipeline into vault, fix plist paths (`~/Documents/MyVault` → `~/MyVault`), load launchd job [owner:: claude] [status:: done] (2026-07-02)
- [x] Per-agent `--model` selection (haiku/haiku/sonnet/sonnet) for token cost [owner:: claude] [status:: done] (2026-07-02)
- [x] Arch-review: found + fixed 5 silent-failure risks (tac→tail -r, duplicate-scan guard, ADVANCE/GO grep gates, error+cost logging) — detail in [[Projects/Dropship_Pipeline/State]] [owner:: claude] [status:: done] (2026-07-02)
