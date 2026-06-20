---
title: CSV Export Guide (Per Platform)
project: Welra
type: reference
updated: 2026-06-17
tags: [welra, onboarding, beta, csv, integrations]
---

# CSV Export Guide — How a Seller Gets Their Orders CSV

> **Purpose:** the send-when-they-say-yes reference. When a beta prospect agrees to a free report, this is the exact, *verified* path to get their last ~month of orders as a CSV — per platform. Paraphrase it into the DM in plain language; don't paste the whole thing.
>
> **Why it has to be exact:** a wrong menu step reads as "these people don't know the platform." Every path below was verified against the platform's **official** help docs on **2026-06-17** (sources + re-verify note at the bottom). Re-check before relying on it months later — platform UIs drift.
>
> **What Welra actually needs:** the **orders** export (order-level, not a summary), covering the **last ~month**. The uploader auto-detects Etsy / Shopify / WooCommerce formats and accepts a generic CSV. Minimum useful columns: an **order/sale date**, a **product/item name**, and an **order total / amount**.
>
> Live on-site version of these guides: the per-card walkthroughs at `welra.io/dashboard/integrations` (see [[Projects/Welra/Tasks]] §D for the demo asset).

---

## 🟠 Etsy  *(the #1 beta path — most mom-and-pop sellers)*

**Desktop browser only** — the "Download Data" screen is **not** in the Etsy Seller app.

1. Sign in to Etsy on a computer → open **Shop Manager**.
2. Go to **Settings → Options**.
3. Open the **Download Data** tab.
4. Under **Orders**, set **CSV Type = Orders** *(this is the order-level file — not "Etsy Payments Sales," which is payment records).*
5. Choose the **Month** and **Year** you want. *(For a last-month report, pick last month. Leaving Month blank downloads the whole year.)*
6. Click **Download CSV**. The file saves to your computer.

**Gotchas to mention:** desktop only · you can only pull **one month (or one full year) at a time** · pick **"Orders,"** not "Etsy Payments Sales."

---

## 🟢 Shopify

Native, free, in every Shopify plan — no app needed.

1. In your Shopify admin, go to **Orders**.
2. *(Optional)* filter the list to the period you want.
3. Click **Export** (top-right of the orders list).
4. Choose a scope: **Current page**, **All orders**, or **Orders by date** (set a start/end date).
5. Under **Export as**, choose **CSV for Excel, Numbers, or other spreadsheet programs**.
6. Click **Export orders**.

**⚠️ The big gotcha — delivery depends on size:**
- **≤ 50 orders / current page →** downloads **straight to your device**.
- **51+ orders, or any date-range export →** Shopify **emails the CSV to the store owner's email address**. *It does not download in the browser — tell them to check their inbox.* This is the single most common "where's my file?" confusion.

---

## 🔵 WooCommerce

**Best path for Woo: skip the CSV — connect directly.** Welra connects to WooCommerce via read-only API keys (~2 min, guided at `welra.io/dashboard/integrations`). Woo sellers self-host WordPress and are comfortable with this, and it means no manual export ever. **Lead with this.**

**If they specifically want a CSV** (native, no plugin):
1. WordPress admin → **WooCommerce → Analytics → Orders**.
2. Set the **date range** at the top (last month).
3. *(Optional)* filter by status, product, etc.
4. Click the **Download** link in the **top-right of the orders table**.
5. CSV downloads with: *Date, Order #, Status, Customer, Product(s), Items sold, Net sales.* — enough for Welra.

**Gotchas / what NOT to tell them:**
- The native CSV's **Net sales excludes shipping & tax**, and columns aren't customizable — fine for our report, just know it.
- ❌ **Do not** point them at **WooCommerce → Reports → Export CSV** — that's a *sales summary*, not order records. Wrong file.
- ❌ The WordPress **Tools → Export** gives **XML**, not CSV. Wrong format.
- If they're on a very old store with Analytics hidden, the direct API connect is the clean fallback.

---

## ⚪ Any other platform (Square, BigCommerce, Printify, Etsy-via-Printify, etc.)

Welra accepts a generic CSV, so a seller on a platform not listed above isn't blocked.

1. In their platform, find **Orders** (or **Sales** / **Reports**) and look for an **Export** / **Download CSV** option.
2. Export the **last ~month** of orders.
3. Make sure the file includes at least an **order date** and an **order total** (a product/item name is a bonus).
4. If unsure whether the format works, **just send it** — we confirm the mapping and tell them in minutes. Don't make the seller debug it.

*(Printify specifically can also connect directly in-app — same as WooCommerce, no CSV needed.)*

---

## The handoff (what happens after they export)

1. Seller exports the CSV per their platform above.
2. They send it to Ryan (DM attachment / email).
3. **Hand the CSV to Claude** → it runs through the real Welra pipeline → a genuine weekly report comes back **same-day** (speed is what converts a beta user vs. a ghost).
4. Sit with them on whether it's actually good — that conversation is the real prize.

---

## 🔒 Internal — verification log (not customer-facing)

Paths verified **2026-06-17** against official help docs. Re-verify if used >~2–3 months later.

- **Etsy:** [How to Download a Spreadsheet of Your Sold Transactions](https://help.etsy.com/hc/en-us/articles/360000343328) + [How Do I Download My Etsy Data?](https://help.etsy.com/hc/en-us/articles/360035753053) — corroborates the s13 live-Chrome check (Shop Manager → Settings → Options → Download Data → Orders).
- **Shopify:** [Exporting orders — Shopify Help Center](https://help.shopify.com/en/manual/fulfillment/managing-orders/exporting-orders) (email-vs-download threshold confirmed there).
- **WooCommerce Analytics CSV:** [WooCommerce Analytics docs](https://woocommerce.com/document/woocommerce-analytics/) ("Download" link, top-right of the Orders table) + column list corroborated by [WebToffee](https://www.webtoffee.com/blog/export-woocommerce-orders-without-plugin/). Native *Reports* export = summaries only, confirmed via [ThemeIsle](https://themeisle.com/blog/woocommerce-export-orders-csv/).

Welra's CSV parser was e2e-verified against a real Etsy "Orders" export in session 15 (8 in-week rows + 2 strays → correctly $275.00 / 8 orders, strays excluded). Auto-detect covers Etsy / Shopify / Woo / generic (session 6).
