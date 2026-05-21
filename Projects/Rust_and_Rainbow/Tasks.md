---
title: Rust & Rainbow Tasks
project: rust-and-rainbow
type: tasks
updated: 2026-05-21
tags: [etsy, printify, social-media]
---

# Rust & Rainbow Tasks

See [[Projects/Rust_and_Rainbow/State]] for platform status, pillars, and cron details.

## High Priority

- [ ] Delete duplicate Gay Dog Dad Retro listing in Printify dashboard — published May 11 + May 14. Deleting in Printify auto-unpublishes from Etsy. [owner:: ryan] [priority:: high] [status:: open]
- [ ] Refresh META_ACCESS_TOKEN at developers.facebook.com — expires 2026-07-01, must refresh by June 25 or Instagram/Facebook posts fail silently [owner:: ryan] [priority:: high] [status:: open] [due:: 2026-06-25]

## Low Priority

- [ ] Fix run_monitor() — `sales` field hardcoded 0. Needs `GET /v1/shops/{shop_id}/orders.json` Printify order API call to pull real sales counts and update designs_log.json [owner:: antigravity] [priority:: low] [status:: open]

## Related
- [[Projects/Rust_and_Rainbow/State]]
