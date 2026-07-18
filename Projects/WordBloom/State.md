---
title: WordBloom State
project: WordBloom
type: state
updated: 2026-07-17
tags: [wordbloom, game, prototype, state]
---

# WordBloom — State

**One-liner:** ("Petal Words" — renamed from WordBloom, name-collision found by adversarial review.) Cozy daily word-garden game (F2P: rewarded ads + gem IAP + remove-ads) filling a verified top-grossing-chart gap — zero F2P word games with IAP+ads in the US iPhone top-100 grossing (only NYT Games, subscription).

## Current state (2026-07-17 — v2 redesign shipped: unique-game iteration)
- **v2 keyed to documented failure modes** (docs/design-v2.md): Bloom Book 56-species collection (deterministic word→species, pangram→Legendary, procedural SVG flora, 4th tab), spoiler-free share card, rewarded-ad streak repair (once/streak), 3-card onboarding, and a **learn-as-you-grow** layer — a real, fact-checked one-line botanical fact per species (shown on discovery + tappable in the Book; cozy+educational hook). Draft 24-species catalog refuted by pacing simulation (complete in 29d = content exhaustion); shipped 56 = final Legendary ~day 104 casual. 24/24 tests, e2e clean, www+iOS synced.

## Prior state (2026-07-15 evening — App-Store-ready to the Xcode boundary)
- **Ship-plan executed after adversarial review** (4 claims refuted incl. name + ATT-privacy shortcut; DST day-boundary bug + 4 collateral bugs found → ALL fixed): logic extracted to logic.js with **17 green unit tests**, two-layer dictionary (93k accept / 23.6k curated), 400 rebalanced puzzles with curated pangrams, sequential collision-free schedule, Bloom Words mechanic (differentiation vs 4.3 spam), Capacitor iOS project generated + synced (SwiftPM, NO CocoaPods needed), RevenueCat+AdMob adapters (fail-closed on native), Restore Purchases + entitlement re-sync, icon/splash in asset catalog, store collateral written (store/), arch-review run → 3 blockers found & fixed in-session, 0 open.
- Docs: docs/ship-plan.md (v2 findings log), docs/arch-review-2026-07-15.md, store/listing.md.

## Earlier state (2026-07-15 — born this session)
- **Playable prototype BUILT + browser-verified** at `~/Desktop/Claude/wordbloom/` (static HTML/JS, no backend)
- Verified end-to-end: tap word entry, scoring, pangram bonus, tier-up modal (+gem bonus), hint via petals AND rewarded-ad stub, gem-pack purchase sheet stub, cosmetic buy/equip (dusk theme, butterfly), remove-ads (banner hides), localStorage persistence across reload
- Market analysis + monetization design in `wordbloom/docs/` — the "why this niche" evidence is chart data pulled 2026-07-15
- 400 pre-balanced daily puzzles shipped (`words/puzzles.json`); dictionary = ENABLE 93k filtered
- Run: `npx serve -l 4173 ~/Desktop/Claude/wordbloom` or launch.json config `wordbloom`

## Not done (prototype → shippable)
- Real StoreKit 2 + AdMob wiring via Capacitor (the seam is `monetize.js` — designed for zero gameplay-code changes)
- Dictionary curation (common-words layer), cloud save (Supabase), soft-launch metric gates
- See [[Projects/WordBloom/Tasks]] and `wordbloom/docs/monetization.md`

## Decisions
- No forced interstitials — cozy demographic churns on them; rewarded-only ad design
- Mechanics: Spelling-Bee-style loop (not copyrightable) differentiated by garden meta + tone; never reuse NYT trade dress
