---
title: Petal Words (WordBloom) Tasks
project: WordBloom
type: tasks
updated: 2026-07-17
tags: [wordbloom, petalwords, tasks]
---

# Petal Words — Tasks

*Full ordered path: `wordbloom/docs/production-plan.md`. Critical path = Apple Dev enrollment → Xcode build → TestFlight dogfood week → submit (~2 weeks to "in review").*

## Phase 0 — decide (before spending)
- [ ] Playtest web build (`npm run serve` in wordbloom/) and make go/park call [owner:: ryan] [priority:: high] [status:: open]
- [ ] Publish as personal name vs LLC (sets App Store seller name) [owner:: ryan] [priority:: high] [status:: open]

## Phase 1 — accounts (start together; enrollment is the long pole)
- [ ] Enroll Apple Developer Program $99/yr (approval up to ~2 days) [owner:: ryan] [priority:: high] [status:: open]
- [ ] Install Xcode + `xcode-select -s` + accept license (no CocoaPods) [owner:: ryan] [priority:: high] [status:: open]
- [ ] AdMob account → iOS app → 1 rewarded + 1 banner unit; copy App ID + unit IDs [owner:: ryan] [priority:: high] [status:: open]
- [ ] RevenueCat account → project → copy public SDK key [owner:: ryan] [priority:: high] [status:: open]
- [ ] Pick support email for listing + privacy/support pages [owner:: ryan] [priority:: medium] [status:: open]

## Phase 2 — Claude pre-submission code (doable NOW, no accounts)
- [x] Google UMP consent flow (requestConsentInfo→showConsentForm before any ad; fail-closed) [owner:: claude] [priority:: high] [status:: done]
- [x] Full SKAdNetworkItems — 50 official Google IDs in Info.plist (plist validated) [owner:: claude] [priority:: high] [status:: done]
- [x] Boot fetch-failure error screen (fetchOK guard + retry card; e2e-verified recover) [owner:: claude] [priority:: medium] [status:: done]
- [x] Support email games@welra.io filled into privacy.html + support.html [owner:: claude] [priority:: medium] [status:: done]
- [x] Hosted on Vercel (public): https://petal-words.vercel.app/privacy.html + /support.html [owner:: claude] [priority:: high] [status:: done]

## Phase 3 — wire real credentials
- [ ] Paste RevenueCat key → monetize.js; AdMob App ID → Info.plist; unit IDs → monetize.js [owner:: ryan] [priority:: high] [status:: open]
- [ ] `npm run build && npx cap sync ios` after paste [owner:: claude] [priority:: high] [status:: open]

## Ryan — small follow-ups from Phase 2 hosting
- [ ] Create the games@welra.io mailbox/alias in Namecheap PrivateEmail so support mail actually lands [owner:: ryan] [priority:: medium] [status:: open]
- [ ] Use the CLEAN alias URLs in the store listing (petal-words.vercel.app/...), NOT the hash deploy URLs (those are behind Vercel login) [owner:: ryan] [priority:: high] [status:: open]

## Phase 4 — App Store Connect
- [ ] Create app (bundle com.northam.petalwords, name Petal Words) [owner:: ryan] [priority:: high] [status:: open]
- [ ] Create 4 IAPs (3 consumable gems + non-consumable removeads) w/ exact product IDs [owner:: ryan] [priority:: high] [status:: open]
- [ ] RevenueCat: add 4 products, map removeads → entitlement `remove_ads` [owner:: ryan] [priority:: high] [status:: open]

## Phase 5 — build to device
- [ ] `npx cap open ios` → set Signing Team → run on Simulator then iPhone [owner:: ryan] [priority:: high] [status:: open]
- [ ] Sandbox-test all 4 purchases + Restore [owner:: ryan] [priority:: high] [status:: open]

## Phase 6 — TestFlight (the real gate)
- [ ] Archive → upload → internal TestFlight; dogfood ~1 week [owner:: ryan] [priority:: high] [status:: open]
- [ ] Fix dogfood-surfaced bugs → new build [owner:: claude] [priority:: medium] [status:: open]

## Phase 7 — listing & submit
- [ ] Screenshots 6.7" + 6.1" (Play/Garden/Book/discovery/share) [owner:: ryan] [priority:: high] [status:: open]
- [ ] Paste listing copy + privacy label + review notes from store/listing.md; submit [owner:: ryan] [priority:: high] [status:: open]

## Phase 8 — launch & measure
- [ ] Release; watch D1/D7/share vs gates (35%/12%/3%) before any paid UA [owner:: ryan] [priority:: medium] [status:: open]
- [ ] v1.1 (only if gates clear): haptics, daily notification, petal-doubler, seasonal species [owner:: claude] [priority:: low] [status:: open]
