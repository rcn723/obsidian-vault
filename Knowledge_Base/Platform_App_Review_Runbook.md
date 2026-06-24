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

---

## Rejection: "Website URL has no login entry point" + the deeper "personal use" trap (TikTok, 2026-06-24)

**Symptom.** TikTok rejected a Content Posting API app twice. Reasons: (1) "Your website does not have a login entry point — how can users complete the login process and use the Content Posting API service?"; (2) an earlier rejection for "personal/internal company use." Quote from TikTok: *"does not support personal or internal company use… Not acceptable: Display posts from the TikTok account(s) you or your team manage."*

**Root cause — wrong product on the wrong website.** The app was submitted to *post* a single brand's own content (R&R) from a static legal-only GitHub Pages site. That is the textbook personal-use pattern AND the site had no login. The ACTUAL need was different: a SaaS (Welra) wanting TikTok as a read-only analytics SOURCE its external customers connect.

**The fix that works — submit the integration under the SaaS that actually consumes it, as read-only Login Kit, with the SaaS's real customer-login as the entry point.**
- **Website URL = the multi-tenant SaaS** (welra.io), where customers sign in and connect sources (Etsy/Shopify/TikTok). The existing "Connect X" dashboard IS the login entry point reviewers want. A brand's static legal page never passes.
- **Products = Login Kit (+ Display API only if per-video data is truly needed).** DROP Content Posting API — posting scopes trigger the strictest review and the personal-use flag.
- **Scopes = read-only** (user.info.basic/profile/stats). Frame as "each customer authorizes their OWN account for their own report." That is "apps serving external users" — exactly what TikTok says its APIs are FOR — NOT "accounts you/your team manage."
- **Avoid the Display-API trap:** TikTok explicitly named "display posts from accounts you manage" as a rejected use case. Lead with Login Kit + user.info.stats; never use "display/embed" language; add video.list only if essential and frame as the customer's own performance metrics.
- **3-strike rule:** 3 rejections in a row flags the dev account for manual review. After 2 strikes, submit a FRESH app under the correct (SaaS) identity rather than reconfiguring the tainted one, and don't submit until the use case is genuinely demoable on the live site.
- **Test account:** if the Website URL is behind login, provide a working SaaS test login + steps in Apply Reason, and add the TikTok test account as a sandbox Target User so it can authorize while unaudited.

**Reusable rule.** Match the app's *product + website + scopes* to who actually uses it. An analytics/read need → Login Kit read-only under the consuming SaaS. A posting need for your own brand → use an approved aggregator (Zernio/Buffer), because TikTok rejects single-account self-posting as personal use. Never submit a data-read use case as Content Posting, or a SaaS integration under a single brand's legal-page site.
