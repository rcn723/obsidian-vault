---
title: Welra Brand Identity — Icon + Color Scheme
project: Welra
type: reference
updated: 2026-06-10
tags: [welra, brand, design, marketing]
---

# Welra Brand Identity

Chosen 2026-06-10. Concept: **Welra = weekly radar** — the icon is a radar sweep on a navy scope, with blips for the seller's sales channels. It tells the product story (we scan all your platforms, you get the signal), reads at 16px favicon size, and no competitor in the space (Metorik, Triple Whale, eRank) uses radar imagery.

## Icon

Primary mark: radar sweep on an ink-navy rounded tile, teal sweep + channel blips (one amber blip = the anomaly we caught).

Files (in repo, `apps/web`):
- `src/app/icon.svg` — favicon (Next.js auto-serves this)
- `public/brand/welra-icon.svg` — standalone icon tile
- `public/brand/welra-logo.svg` — horizontal lockup (icon + lowercase "welra" wordmark)

Alternates considered (SVGs in session 2026-06-10, regenerable on request): B "W-pulse" (W drawn as a sales line ending in an upward teal stroke), C "Monday signal" (beacon arcs).

## Color scheme

| Name | Hex | Tailwind token | Use |
|---|---|---|---|
| Ink navy | `#0F1E33` | `ink` | Headers, footer, wordmark, report headings, dark surfaces |
| Radar teal | `#2FD6A6` | `radar` | Accent on dark bg, CTAs on navy, positive deltas (▲) |
| Radar deep | `#0FA47C` | `radar-deep` | Accent on light bg (AA-contrast variant of teal), links, buttons on paper |
| Signal amber | `#F5A93B` | `signal` | Highlights, anomaly callouts, "Founding Seller" badge |
| Paper | `#F7F9FB` | `paper` | Page + email background |
| Slate | `#5A6B82` | `slate` | Secondary text, captions |
| Negative | `#E5484D` | (tailwind `red-500` ok) | Negative deltas (▼) only — never decorative |

Rules:
- Teal `#2FD6A6` only on dark backgrounds (fails contrast on white) — on paper/white use `#0FA47C`.
- Text on teal buttons: ink navy or `#04342C`, never white.
- Amber is for *signal*, not decoration — anomalies, alerts, one badge max per view.
- Wordmark: lowercase **welra**, system-sans semibold (600), ink navy on light / paper-white on navy. No Title Case.
- Reports + emails inherit the same palette: ink headings, slate body labels, teal ▲ / red ▼ deltas.

## Voice (for marketing assets)
Plain-English, seller-to-seller, zero dashboard jargon. Numbers always paired with a "so what". See hooks in [[Projects/Welra/Marketing_Campaign_2026-06]].

## Status
- [x] Favicon + logo SVGs committed to repo (2026-06-10)
- [x] Tailwind tokens added (`ink/radar/radar-deep/signal/paper/slate`)
- [ ] Apply palette to landing page (header, CTAs, pricing cards) [owner:: claude]
- [ ] Apply palette to report email template [owner:: claude]
- [ ] Social card images (1200×630 OG + square) in brand colors [owner:: claude]
- ⚠️ Web deploys go through Vercel-on-git-push — favicon/palette go live only after Ryan adds `workflow` scope to the PAT and pushes (the CI commit blocks all pushes until then).

Related: [[Projects/Welra/Marketing_Campaign_2026-06]] · [[Projects/Welra/State]]
