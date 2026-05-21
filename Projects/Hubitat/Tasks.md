---
title: Hubitat Tasks
project: hubitat
type: tasks
updated: 2026-05-21
tags: [hubitat, home-automation]
---

# Hubitat Tasks

See [[Projects/Hubitat/State]] for device reference and current status.
Build order below is the correct sequence — blocked tasks listed after their unblockers.

## Manual — Ryan in Hubitat UI

- [ ] Pause or change fireplace watchdog from 5min → 10min (or pause entirely before Rule 2) [owner:: ryan] [priority:: high] [status:: open]
- [ ] Build Mode 0 — Mode Daily Schedule via Mode Manager built-in app (not Rule Machine) [owner:: ryan] [priority:: high] [status:: open]
- [ ] Build Rule 3 — Outdoor lights sunset/11pm via Simple Automations [owner:: ryan] [priority:: high] [status:: open]
- [ ] Build Rule 5 — Morning wake lights 7:15am via Rule Machine [owner:: ryan] [priority:: high] [status:: blocked]
- [ ] Build Rule 2 — Fireplace 4hr auto-shutoff via Rule Machine — pause watchdog first [owner:: ryan] [priority:: high] [status:: blocked]
- [ ] Build Rule 7 — Kitchen night motion lights via Rule Machine [owner:: ryan] [priority:: medium] [status:: blocked]
- [ ] Build NEW — DD Stair motion lights (566/567 → 565) via Rule Machine [owner:: ryan] [priority:: medium] [status:: open]
- [ ] Build ShutDown on 11pm timer via Simple Automations [owner:: ryan] [priority:: medium] [status:: open]
- [ ] Disable Ecobee native schedule before enabling Rule 6 [owner:: ryan] [priority:: medium] [status:: open]
- [ ] Build Rule 6 — Thermostat setback by mode via Rule Machine — disable Ecobee schedule first [owner:: ryan] [priority:: medium] [status:: blocked]
- [ ] Fix presence detection — toggle off/on in Hubitat mobile app for Ryan's phone (ID 1) and Grace Phone WiFi (ID 515) [owner:: ryan] [priority:: medium] [status:: open]
- [ ] Build Rule 1 — Away mode via Rule Machine — fix presence detection first [owner:: ryan] [priority:: medium] [status:: blocked]
- [ ] Re-auth LG ThinQ — Washer (556) and Dryer (555) stale since Aug 2024 [owner:: ryan] [priority:: medium] [status:: open]
- [ ] Build Rule 4 — Laundry notifications via Rule Machine — re-auth LG ThinQ first [owner:: ryan] [priority:: low] [status:: blocked]
- [ ] Build Rule 8 — Coffee weekend delay via Simple Automations [owner:: ryan] [priority:: low] [status:: open]
- [ ] Remove Device 54 "Not in use, Dim light" from ShutDown rule, then delete device [owner:: ryan] [priority:: medium] [status:: open]
- [ ] Assign rooms to 4 AirPlay speakers: 572 (Roam), 573 (Arc), 575 (Playbase), 577 (Entertainment Room) [owner:: ryan] [priority:: low] [status:: open]

## Related
- [[Projects/Hubitat/State]]
