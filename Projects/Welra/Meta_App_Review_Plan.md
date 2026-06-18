---
title: Meta App Review Plan (Instagram one-click connect)
project: Welra
type: strategy
updated: 2026-06-16
tags: [welra, instagram, meta, app-review, integrations, go-to-market]
---

# Meta App Review Plan — unlock one-click Instagram connect

**Goal:** get Meta to grant *Advanced Access* to the four Instagram permissions Welra uses, so the one-click "Log in with Facebook" button can ship to real sellers (flip `NEXT_PUBLIC_INSTAGRAM_OAUTH=true`). Until then, only app-role users can use Facebook Login; everyone else is stuck on the manual long-lived-token paste form (too technical for mom-and-pop).

**Priority:** LOW / future. This is a friction-reducer, NOT a customer blocker — same class as the Etsy API. The manual token + concierge path serves Instagram today, and Instagram is only an *optional engagement add-on* (sales platforms + CSV are the core). **Do this AFTER beta user #1.** See [[Projects/Welra/Tasks]].

---

## What Welra actually requests (verified in code, 2026-06-16)

Least-privilege is already true — every requested scope is exercised by the fetcher:

| Permission | Why Welra needs it | Code proof |
|---|---|---|
| `instagram_basic` | Read the seller's own profile + media (followers_count, media_count, recent posts: likes, comments, timestamp) | `instagram.ts` account + `/media` calls |
| `instagram_manage_insights` | Read account `reach` for the week | `instagram.ts` `/insights` call |
| `pages_show_list` | Discover the IG business account from the seller's linked Facebook Page | `oauth.ts` `/me/accounts?fields=...instagram_business_account` |
| `pages_read_engagement` | **VERIFY IT'S ACTUALLY USED.** Discovery only reads the IG-account link (covered by `pages_show_list`). If the flow works without it, DROP it — every extra permission adds review burden. | not clearly exercised |

Scopes string: `oauth.ts:30`. **Do not request anything broader** (no `business_management`, no `instagram_manage_comments`, no publishing scopes) — Welra never writes, never reads DMs.

---

## Step 0 — Fix before you submit (must-do)

- [x] **Align the Graph API version.** DONE 2026-06-16 (s20): `oauth.ts` `META_API_VERSION` bumped `v21.0`→`v22.0` to match the fetcher's `GRAPH_BASE`; cross-referencing comments added to both so they can't drift again. API tsc + build green. (Not yet deployed — ships with the next `railway up`.)
- [ ] **Confirm the Meta app exists.** `oauth.ts` already reads `META_APP_ID` / `META_APP_SECRET` / `META_REDIRECT_URI` from env — so credentials are wired. Log into the Meta App Dashboard and confirm the app is real, named correctly, and is a **Business** app type with the "Facebook Login for Business" + "Instagram Graph API" products added.
- [ ] **Confirm `META_REDIRECT_URI`** in the app's Valid OAuth Redirect URIs matches the env value exactly (api.welra.io callback).

## Step 1 — Prerequisites Meta requires before review (the long poles)

- [ ] **Business Verification of GR3NB LLC** in Meta Business Manager. Needs legal business name, address, phone, and a verification document (business registration / formation doc / utility bill). **This is the slowest step — days to weeks.** Some permissions won't approve until it completes. **Start this first — it runs in the background while you recruit beta users.**

  **Do it in ONE 30-min sitting, then walk away.** Have ready: GR3NB LLC formation/registration doc (legal name + address must match *exactly* what you type), business phone (503-502-5360), business email, and control of the `welra.io` domain (DNS).
  1. [business.facebook.com](https://business.facebook.com) → confirm a **Business Portfolio** exists for GR3NB (create one if not).
  2. **Business Settings → Business Info → Security Center / Verification → Start Verification.**
  3. Enter legal name / address / phone **exactly** as on the formation doc — mismatches are the #1 rejection cause.
  4. Upload the doc; choose phone or email confirmation.
  5. Submit → it enters Meta's queue. Done. Check back in ~a week.
- [ ] **Public Privacy Policy** that *specifically* names Instagram/Meta data: what you collect (follower/media/engagement counts), how it's used (the weekly report), retention, and how it's deleted. `welra.io/privacy` exists — confirm it covers Meta data explicitly, not just generically.
- [ ] **Data Deletion path.** Meta requires either a Data Deletion Callback URL or a Data Deletion Instructions URL. Disconnect (revokes access) isn't the same as deletion — document/expose a deletion request URL.
- [ ] **App basics set:** icon, display name, category, App Domains, contact email, and the app switched to **Live mode**.

## Step 2 — Make the flow testable (the chicken-and-egg trap)

Meta reviewers *replicate the flow themselves*. They can't test a button that's gated off.

- [ ] **The one-click "Log in with Facebook" button must be live for the reviewer.** Flip `NEXT_PUBLIC_INSTAGRAM_OAUTH=true` (at least on the URL the reviewer tests) so they can actually grant permissions. If it stays gated, they reject for "can't test."
- [ ] **Provide test credentials + step-by-step repro:** a Welra login, a test IG business account linked to a Facebook Page, and the exact clicks: dashboard → Optional Instagram section → Connect → grant → see the engagement section in the report.

## Step 3 — The submission content (the part that gets rejected)

- [ ] **Per-permission use-case text**, in plain merchant language. Explain each scope as "reading the seller's *own* Instagram business metrics to include in their private weekly summary." **Apply the no-"AI" playbook** — never say AI/ML/automated-analysis; Meta pattern-matches that against prohibited use just like Etsy did. See [[Knowledge_Base/feedback_platform_api_applications]].
- [ ] **Screencast** (required for each advanced permission): record a real user clicking "Log in with Facebook," granting access, the IG account connecting, and then the **weekly report email/section showing the IG engagement data** (week's posts, likes, follower trend). The reviewer must see the data actually used in a feature, not just collected.
- [ ] **Explicit negatives** in the description: Welra is read-only, never posts, never reads DMs, only touches the connected seller's own account.

## Step 4 — Submit & iterate

- [ ] Submit for **Advanced Access** on each permission (Standard Access only works for app-role users = current dev-mode state).
- [ ] Expect at least one round of clarification. Respond fast, tighten the screencast/description, don't broaden scopes to "fix" a rejection.
- [ ] On approval: flip `NEXT_PUBLIC_INSTAGRAM_OAUTH=true` in Vercel prod, verify the one-click flow end-to-end with a real seller account.

---

## Effort & sequencing

1. **Now / cheap:** Step 0 (version fix is a one-line code change + redeploy). Do it whenever you're next in the API.
2. **Kick off early, runs in background:** Step 1 Business Verification (it's the bottleneck).
3. **Real work, ~half a day:** Steps 2–3 (test account + screencast + use-case copy).
4. **Then:** submit, iterate.

Realistic calendar: **2–4 weeks** start-to-approval, mostly waiting on Business Verification. None of it gates a paying customer — schedule it after beta validation, alongside the Etsy resubmit (post 2026-06-25).

## Related
[[Projects/Welra/Tasks]] · [[Projects/Welra/Etsy_API_Approval_Strategy]] · [[Knowledge_Base/feedback_platform_api_applications]] · [[Projects/Welra/Continuation_Playbook]]
