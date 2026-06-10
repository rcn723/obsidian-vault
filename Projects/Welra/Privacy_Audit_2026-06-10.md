---
title: Welra Privacy Audit — policy claims vs actual data handling
project: Welra
type: audit
updated: 2026-06-10
tags: [welra, privacy, gdpr, audit, compliance]
---

# Privacy Audit — 2026-06-10

Published Privacy Policy / business-plan claims traced against the deployed codebase (UK GDPR applies in-scope — UK is a launch market). Conducted during the overnight session; see [[Projects/Welra/Strategy_Review_2026-06-09]] for context.

## Claim-by-claim

| Published claim | Reality in code | Verdict |
|---|---|---|
| "Raw API/platform data deleted after report generation — never stored long-term" | Largely true for API pulls (data is fetched per-run, aggregated, not persisted). **Exception (new 2026-06-10): CSV uploads persist normalized order rows (date, order ID, amount) in private storage indefinitely** — required so future weekly reports can read them. | ⚠️ **Policy wording conflicts with CSV feature** |
| "Report history retained for 12 months after cancellation" | Reports persist in DB; **no deletion job exists** — data is retained forever. | ⚠️ Promise not implemented |
| "Customers can export all reports as ZIP at any time" | Export not built; `/reports` route is a stub. | ❌ Promise not implemented |
| "Automated Supabase cleanup job deletes expired data on schedule" | Does not exist. | ❌ Not implemented |
| Platform tokens handled securely | OAuth tokens encrypted at rest (AES-256-GCM, key in Railway env — verified in lib/crypto.ts). | ✅ |
| Read-only platform access | True for built integrations (read-only API scopes). | ✅ |
| Data freshness stamp on every report | Implemented in report template. | ✅ |

## Required actions (tracked in [[Projects/Welra/Tasks]])

1. **Amend Privacy Policy wording** to disclose CSV-upload retention: customer-uploaded order data is stored to power future reports, deleted on account deletion / X months after cancellation. (Termly edit — Ryan.)
2. **Build the retention/deletion job** before launch, covering: reports (12 mo post-cancellation), CSV order data, integrations rows + tokens on cancellation.
3. **Build ZIP export** or soften the policy promise to "contact support to export" until built.
4. UK GDPR data-subject requests: manual handling is acceptable at this scale, but the policy must not promise automation that doesn't exist — review wording during the Termly edit.

**Bottom line:** no data is being mishandled today (nothing real flows yet, one test user), but two published promises are unimplemented and one new feature (CSV) contradicts the "never stored long-term" wording. Fix the wording + retention job before real customers sign up.
