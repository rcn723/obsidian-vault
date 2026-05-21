---
title: Hubitat State
project: hubitat
type: state
updated: 2026-05-21
tags: [hubitat, home-automation]
---

# Hubitat

Current focus: Rule Machine automation build-out. Hub cleanup complete as of 2026-05-21.

See [[Projects/Hubitat/Tasks]] for all open tasks and build order.

## Status Summary
- Hub cleanup: ✅ Complete (2026-05-21)
- Rule Machine rules built: 0/10
- Presence detection: ⚠️ Broken — Ryan's phone (ID 1) + Grace Phone WiFi (ID 515)
- LG ThinQ: ⚠️ Stale since Aug 2024 — blocks [[Projects/Hubitat/Tasks#Rule 4]]
- Fireplace watchdog: ⚠️ Spamming command-off every 5min — must pause before Rule 2

## Device Quick Reference
| Device | ID | Status |
|---|---|---|
| Fireplace | 490 | Active — watchdog spam (5min) URGENT |
| Fireplace override | 527 | Virtual switch — never used |
| Coffee maker | 537 | Active — 7:30 AM daily |
| Kitchen Lights | 497 | Active |
| Island Lights | 495 | Active |
| Kitchen Motion | 498 | Active — battery 100% |
| DD Top Stairs Motion | 566 | Active — battery 91% |
| DD Bottom Stairs Motion | 567 | Active — battery 77% |
| Stairs dimmer | 565 | Exists — no motion rule yet |
| N J HOME Thermostat | 453 | Active — heat 69°F / cool 74°F / auto |
| ShutDown virtual | 136 | Manual only, not on timer |
| Ryan's phone | 1 | Presence broken |
| Grace Phone WiFi | 515 | Presence broken |
| DarkSky Weather | 145 | LIVE — real weather data, keep |
| Washer | 556 | ⚠️ Stale — last data Aug 2024 |
| Dryer | 555 | ⚠️ Stale — last data Aug 2024 |
| Entry light | 532 | Entrance — used in morning rule |
| Office Desk Light | 34 | Office — used in morning rule |
| Outdoor lights | 559, 560, 494, 512, 103 | Deck/patio/front — Rule 3 |

## Related
- [[Projects/Hubitat/Tasks]]
- [[Knowledge_Base/Learnings_and_Conventions]]
