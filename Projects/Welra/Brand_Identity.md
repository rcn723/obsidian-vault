---
title: Welra Brand Identity & Style Guide
project: Welra
type: reference
updated: 2026-06-15
tags: [welra, brand, design, marketing, style-guide, voice]
---

# Welra Brand Identity & Style Guide

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

## Typography

| Context | Face | Weight / size |
|---|---|---|
| Wordmark | System sans stack (`-apple-system, Segoe UI, Inter, Helvetica`) | 600, lowercase "welra", letter-spacing +0.01em |
| Web headings | Same stack | 600; h1 36–44px, h2 28px, h3 20px, ink navy |
| Web body | Same stack | 400, 16px/1.6, ink navy; secondary text in slate |
| Report email headings | Same stack (email-safe) | 600, ink navy |
| Report numbers / deltas | Same stack, tabular-nums | 500; teal-deep ▲ gains, red ▼ losses — never color alone, always the arrow too |

No webfonts (performance + email deliverability). No serif. No italics for emphasis — restructure the sentence instead. Sentence case everywhere: buttons, headings, nav ("Start free trial", never "Start Free Trial").

## Logo usage

- **Clear space:** keep a margin of ½ the tile width around the icon/lockup; nothing inside it.
- **Minimum sizes:** icon 16px (favicon floor); lockup 120px wide. Below that, use the icon alone.
- **On navy/dark:** wordmark in paper `#F7F9FB`; icon tile may lighten to `#1A2F4D`.
- **On light:** wordmark in ink navy; icon tile stays navy — never invert the tile to white.
- **Don't:** recolor the sweep, rotate the mark, add shadows/gradients/outlines, place the tile on amber or teal fills, or use the wordmark in Title Case/uppercase.

## Component rules (web + email)

- Primary CTA: radar teal fill, ink-navy text, 8px radius. One per view.
- Secondary CTA: ink-navy outline on paper, ink text.
- Links on light: radar-deep `#0FA47C`, no underline until hover.
- Anomaly/alert callout: signal amber left border (4px, square corners) on paper — the ONLY amber element on the page.
- Pricing cards: paper cards, ink headings; recommended plan gets a teal top border + "Most popular" amber badge.
- Report email: paper background, single-column 600px, ink headings, metric rows with tabular numbers, teal/red deltas with arrows.

## Voice & language (canonical — updated session 18, 2026-06-15)

Write like one working seller talking to another: clear, warm, confident, never hype. This applies to ALL marketing, site, email, and platform-facing copy AND to the tone the generated reports aim for.

**Non-negotiable rules**
1. **Never lead with "AI."** Don't open marketing or platform-facing copy with AI/ML/automation. Lead with the seller outcome (understand your numbers, know what to do next, grow your shop). The tech is plumbing, not the pitch. (Reviewers — Etsy/Meta — and customers both pattern-match on it.)
2. **Say "clear," not "plain English."** "Plain English" reads stock/AI. Use **"a clear read," "clear weekly report," "written clearly."** (Decided session 18; "plain English" and "straight talk" both rejected — "clear" chosen over no-jargon / written-like-a-human / straight-talk.)
3. **Small-business growth & success is the throughline.** We exist to help small, independent sellers **grow and succeed.** Frame benefits around growth: "the next move to grow your shop," "what to do next to keep growing," "built to help small shops grow," "make confident decisions." Mission line (canonical): **"On a mission to help small shops grow — one clear decision at a time."**
4. **Future-proof evergreen lines.** Keep cadence words ("weekly," "Monday," "one Monday at a time") OUT of taglines/mission/logo lines so they survive an on-demand product. (Same reason "weekly" was dropped from the logo tagline → "Your business radar.") Cadence is fine in feature copy ("every Monday at 6am"), not in the evergreen brand line.
5. **Honesty (enforced by the report eval harness).** Never claim a cause the data doesn't show; never claim the seller took an action we can't observe. In report follow-through, celebrate the measured **outcome** ("converted at 6.5%, up from 3.1% — whatever you changed, it's moving"), **never** "you did X / your change worked / you completed last week's actions." Frame possible causes only as checks ("worth checking whether…").

**Word choices**
- "report" not "insights"; "your shop" / "your business" not "your business ecosystem"; "grow," "confident decisions," "a clear read."
- Numbers always paired with a "so what" ("Revenue dipped 8% — but that's your normal post-holiday pattern").
- Sentence case everywhere (buttons, headings, nav). No Title Case, no ALL CAPS, no italics for emphasis (restructure instead).

**Quick don't → do**
- "plain-English report" → "clear report" / "a clear read"
- "AI-powered weekly insights" → "one clear weekly report on what happened and what to do next"
- "your business ecosystem" → "your shop"
- "one Monday at a time" (evergreen) → "one clear decision at a time"
- "you added photos and it worked" → "the listing's converting better — whatever you changed, it's moving"

See marketing hooks in [[Projects/Welra/Marketing_Campaign_2026-06]] and the weekly blog voice in [[Projects/Welra/Content_Calendar]].

## Status
- [x] Favicon + logo SVGs committed to repo (2026-06-10)
- [x] Tailwind tokens added (`ink/radar/radar-deep/signal/paper/slate`)
- [x] Apply palette to landing page (header, CTAs, pricing cards) — DONE 2026-06-10 session 8, commit 595c01c (incl. Founding Seller banner in signal amber; logo as plain `<img>` — next/image rejects SVG) [owner:: claude]
- [x] Apply palette to report email template — DONE 2026-06-10 session 8, deployed to Railway (teal revenue card, teal/red deltas, signal-amber highlights, ink headings; footer contact → ryan@welra.io) [owner:: claude]
- [x] Voice & language canonicalized (session 18, 2026-06-15): "plain English" → "clear" across 13 site/email files + scan prompt; small-business grow/succeed throughline added to hero, how-it-works, FAQ, press, footer mission; cadence-free evergreen lines; report follow-through honesty rule. Deployed + verified live. [owner:: claude]
- [ ] Social card images (1200×630 OG + square) in brand colors [owner:: claude]
- ⚠️ Web deploys go through Vercel-on-git-push — favicon/palette go live only after Ryan adds `workflow` scope to the PAT and pushes (the CI commit blocks all pushes until then).

Related: [[Projects/Welra/Marketing_Campaign_2026-06]] · [[Projects/Welra/State]]
