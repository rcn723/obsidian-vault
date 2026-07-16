---
title: Petal Words (WordBloom) Tasks
project: WordBloom
type: tasks
updated: 2026-07-15
tags: [wordbloom, petalwords, tasks]
---

# Petal Words — Tasks

*Scaffold is App-Store-ready up to the Xcode boundary (see `wordbloom/docs/ship-plan.md` v2 + `docs/arch-review-2026-07-15.md`). Ryan-owned console steps below; ordered.*

## Ryan — path to TestFlight
- [ ] Playtest the web build (`npx serve -l 4173 ~/Desktop/Claude/wordbloom`) and decide go/park [owner:: ryan] [priority:: high] [status:: open]
- [ ] Install Xcode (~12 GB) + `sudo xcode-select -s /Applications/Xcode.app` (no CocoaPods needed — SwiftPM) [owner:: ryan] [priority:: high] [status:: open]
- [ ] Enroll Apple Developer Program $99/yr (seller-name decision: personal vs LLC) [owner:: ryan] [priority:: high] [status:: open]
- [ ] App Store Connect: create app "Petal Words" (fallback "Petal Words: Word Garden") + 4 IAPs (ids in monetize.js) [owner:: ryan] [priority:: high] [status:: open]
- [ ] RevenueCat account: project + 4 products + `remove_ads` entitlement → paste public key into monetize.js [owner:: ryan] [priority:: medium] [status:: open]
- [ ] AdMob account: app id → Info.plist GADApplicationIdentifier + 2 ad-unit ids → monetize.js [owner:: ryan] [priority:: medium] [status:: open]

## Claude — before submission (DEFERRED from arch-review 2026-07-15)
- [ ] [DEFERRED from arch-review] Google UMP consent flow (EEA/UK ads blocked without it) [owner:: claude] [priority:: high] [status:: open]
- [ ] [DEFERRED from arch-review] Full SKAdNetworkItems list (~50 entries) in Info.plist [owner:: claude] [priority:: high] [status:: open]
- [ ] [DEFERRED from arch-review] Host store/privacy.html + store/support.html, fill [SUPPORT_EMAIL] [owner:: claude] [priority:: high] [status:: open]
- [ ] [DEFERRED from arch-review] Boot fetch-failure error screen (corrupt-install resilience) [owner:: claude] [priority:: low] [status:: open]
- [ ] v1.1 candidates: haptics + daily local notification (4.2 insurance), streak-repair rewarded ad, petal-doubler [owner:: claude] [priority:: low] [status:: open]
