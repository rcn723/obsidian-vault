---
title: Platform App-Review Runbook (TikTok / Meta brand-consistency)
project: Welra
type: runbook
updated: 2026-06-19
tags: [runbook, platform, app-review, tiktok, meta, branding, ops]
---

# Platform App-Review Runbook

Operational runbook for **developer-app review rejections** on TikTok, Meta, and similar consoles. These are review-console quirks, not code bugs. See also [[Knowledge_Base/DNS_Domain_Runbook]], [[Projects/Welra/Meta_App_Review_Plan]], [[Projects/Welra/Etsy_API_Approval_Strategy]].

## Incident: "Icon does not match brand" (TikTok, 2026-06-19, RustandRainbow app)

**Symptom.** TikTok dev-app rejected. Flagged field: *Website URL*. Reviewer note: *"Icon does not match brand. The app icon submitted in Basic Info does not match the icon displayed on the website. Ensure the same icon is used across TikTok, the website, and browser tab (favicon)."*

**The trap — the wording lies.** It sounds like the *uploaded icon* is wrong. It is not. The real cause: the **website had no favicon and no logo image at all** (text-only header → browser showed the default globe). TikTok compares the app icon against the site's favicon/logo; with nothing on the site to compare, the reviewer reads "no matching icon" as "icon does not match brand." The icon you uploaded can be perfectly fine.

**Fastest diagnostic (do this FIRST — ~60s).** Open the app's Website URL in a browser and check two things:
1. Is there a real `<img>` logo in the header? (DevTools: `document.querySelectorAll('header img').length`)
2. Is there a favicon? (DevTools: `document.querySelector('link[rel*=icon]')` — `null` = none, tab shows default globe)

If either is missing, THAT is the rejection cause — not your uploaded icon.

**Fix.** Make ONE mark appear identically in all three places:
- TikTok/Meta **app icon** (1024×1024 PNG/JPG, no text, no human faces — a pet/logo is fine)
- Website **header logo** (an actual `<img>`, not just text)
- **favicon** + apple-touch-icon (`<link rel="icon">` + `<link rel="apple-touch-icon">`)

Derive favicon/apple-touch by downscaling the *exact same file* used as the app icon, so they're pixel-identical. Add the `<link>` tags to every page the reviewer might open (home + privacy + terms). For GitHub Pages project sites, use absolute paths (`/<repo>/favicon.png`).

**Verify before resubmit (live, not local).** GitHub Pages publishes static assets BEFORE the rebuilt HTML — `favicon.png` can return 200 while the page still shows the old text-only header. Re-check the live URL with a cache-buster (`?v=2`) until `link[rel=icon]` is present AND the header `<img>` actually loaded (`img.complete && img.naturalWidth > 0`). Pages rebuild lag is ~30–90s.

**Resubmit.** Don't change the icon on the console — it already matches once the site is fixed. Just resubmit; the crawler re-checks the site. If it bounces again, it's caching — wait and resubmit; the site is correct.

**Escalation.** Only if multiple resubmits fail with the same note despite a verified-matching site: contact via the "contact us here" link in the rejection banner; attach screenshots of the app icon, the live site header, and the browser tab favicon side by side proving they're identical.

## Reusable rule

Before submitting ANY developer app for review (TikTok, Meta, future platforms): confirm the **app icon, website header logo, and favicon are the same image**. A bare/legal-only website with no favicon and no logo is the #1 silent cause of "brand mismatch" rejections. This will hit **Meta App Review** identically — pre-check the site before submitting Welra's Meta app.
