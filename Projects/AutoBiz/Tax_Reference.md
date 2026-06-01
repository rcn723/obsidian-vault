---
title: GR3NB LLC — Tax Reference
project: AutoBiz
type: reference
updated: 2026-05-28
tags: [tax, legal, gr3nb, finance]
---

# GR3NB LLC — Tax Reference

Quick reference for tax obligations, deductions, and deadlines.
See also: [[Projects/AutoBiz/Business_Plan]] · [[Projects/AutoBiz/Tasks]]

Mac folder: `~/Documents/GR3NB/`

---

## Entity Details

| Field | Value |
|---|---|
| Legal name | GR3NB LLC |
| State | Oregon |
| EIN | 42-2858110 |
| Tax classification | Single-member LLC (disregarded entity) → Schedule C |
| S-Corp election | File IRS Form 2553 when ARR hits $60k |
| DBA 1 | Welra (welra.io) |
| DBA 2 | Rust & Rainbow |
| Bank | Mercury Bank |

---

## Quarterly Estimated Tax Deadlines

Pay at: https://directpay.irs.gov → Estimated Tax → Form 1040-ES
Set aside 25–30% of every payout. Log confirmation numbers in `Tax/2026/Quarterly_Taxes/`.

| Quarter | Income Covers | Due Date |
|---|---|---|
| Q1 2026 | Jan–Mar | April 15, 2027 |
| Q2 2026 | Apr–Jun | June 16, 2027 |
| Q3 2026 | Jul–Sep | September 15, 2027 |
| Q4 2026 | Oct–Dec | January 15, 2028 |

---

## Annual Compliance Deadlines

| Item | Due | Cost | Where |
|---|---|---|---|
| Oregon LLC annual renewal | ~May each year | $100 | sos.oregon.gov |
| Welra DBA renewal | ~2028, every 2 yrs | $50 | sos.oregon.gov |
| Rust & Rainbow DBA renewal | ~2028, every 2 yrs | $50 | sos.oregon.gov |
| gr3nb.com domain renewal | Annual | ~$15 | Namecheap |
| welra.io domain renewal | Annual | ~$15 | Registrar |
| Personal income tax return | April 15 | — | Schedule C + SE tax |
| S-Corp election (Form 2553) | When ARR hits $60k | — | IRS |

---

## Deductible Expenses

### Startup Costs (Section 195 — deduct all in Year 1 if under $5,000 total)
- Oregon LLC filing: $100
- DBA filings (×2): $100
- gr3nb.com domain: $15
- welra.io domain: (amount)
- Termly legal docs: $30
- Operating Agreement: $0 (Rocket Lawyer free)
- **Total startup costs: ~$245 → fully deductible in 2026**

### Ongoing Business Deductions (Schedule C)
- Hosting: Railway, Supabase, Vercel
- AI/API: Claude API (Anthropic)
- Email: Resend
- Payment processing: Stripe fees
- CPA fees: ~$400 Year 1
- Oregon LLC annual renewal: $100/yr
- Domain renewals
- Internet bill: business use % only
- Home office: see below

### Home Office (Simplified Method)
- $5.00 × sq ft of dedicated workspace (max 300 sq ft = $1,500/yr)
- Workspace must be used *regularly and exclusively* for business
- Worksheet: `~/Documents/GR3NB/Home_Office/Home_Office_Worksheet_2026.md`

### Self-Employment Tax
- 15.3% of net profit
- Deduct half of SE tax on personal return (above-the-line deduction)
- Saves ~7.65% of net profit on income taxes

---

## Monthly Filing Habit (1st of Every Month, ~10 min)

1. Download Mercury bank statement → `Bank_Statements/2026/mercury-YYYY-MM.pdf`
2. Download Stripe payout report → `Tax/2026/Income/Stripe/stripe-YYYY-MM.pdf`
3. Download all software invoices → `Tax/2026/Receipts/Software/`
4. Add all expenses to `GR3NB_Expense_Log_2026.csv`

---

## Document Checklist Location

`~/Documents/GR3NB/Legal/DOCUMENT_CHECKLIST.md`

---

## CPA Talking Points (Year 1)

> "Single-member Oregon LLC — GR3NB LLC. Two DBAs: Welra (SaaS) and Rust & Rainbow (POD/e-commerce).
> All income and expenses through Mercury Bank. Startup costs ~$245 — Section 195 deduction.
> Home office at [address] — [X] sq ft, simplified method.
> Receipts in ~/Documents/GR3NB/Tax/2026/. Expense log in GR3NB_Expense_Log_2026.csv.
> S-Corp election at $60k ARR."

---

## S-Corp Election (Future)

At ~$60k ARR, file IRS Form 2553:
- Pay yourself a reasonable salary (~$40k/yr)
- Remaining profit = distributions (no 15.3% SE tax on distributions)
- Saves ~$6,000–15,000/year above that threshold
- Hire a CPA before doing this — requires payroll setup (Gusto ~$40/mo)
