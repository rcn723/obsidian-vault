# CLAUDE.md — Welra

## Project Overview
Welra is a SaaS product delivering weekly AI-written business intelligence reports for multi-channel e-commerce sellers. Built by Ryan Northam (ryan@welra.io).

## Tech Stack
- Language: TypeScript
- Runtime: Node.js 22 (node:22-slim for containers)
- Frontend: Next.js (App Router) → Vercel → welra.io
- API: Fastify → Railway → welra-production.up.railway.app
- Database: Supabase (PostgreSQL + Auth + Storage)
- Queue: BullMQ
- Payments: Stripe (test mode → live mode pending e2e validation)
- GitHub: rcn723/welra

## Commands
- `tsc --noEmit` — Type check (always run before pushing)
- `npm run build` — Production build (run locally before every Railway/Vercel push)
- `npm run dev` — Start dev server
- `railway variables --set "KEY=VALUE"` — Set Railway env vars (never use .env files)
- `railway up --service welra` — Deploy. **GitHub auto-deploy is NOT wired**; `git push` and `railway redeploy` do NOT pick up code changes.

---

## 🧠 Thinking Rules

1. **Read before write.** Before modifying any file, read it first. Match existing patterns, naming conventions, and code style.
2. **Verify before assuming.** Check actual source files for import paths, function signatures, and type definitions. Never rely on memory.
3. **Ask when unsure.** If confidence is below 95%, ask clarifying questions before modifying files.
4. **Plan before executing.** For tasks touching 3+ files, outline the plan and get approval before making changes.

## 🛡️ Safety Rules

1. **Off-limits files — NEVER modify:**
   - `*.lock` / `*-lock.*`
   - `.env*`
   - `node_modules/`, `.next/`, `dist/`
2. **Destructive operations require confirmation:**
   - Deleting files or directories
   - Dropping/truncating Supabase tables or running destructive migrations
   - Force-pushing or modifying Railway / Vercel CI configs
3. **Never commit secrets.** No API keys, tokens, or credentials. Use environment variables.
4. **Railway never reads `.env` files.** All env vars must be set via `railway variables set` or Railway dashboard.
5. **Confirm green deploy before moving on.** Check Railway **Logs** tab (not Deploy tab) for runtime errors after every deploy.

## ⚡ Quality Rules

1. **Build locally first.** Run `tsc --noEmit` + `npm run build` before every push. Prevents Railway deploy failures.
2. **Arch-review gate.** Run `arch-review` before declaring any scaffold, schema change, or multi-service feature done.
3. **Lazy SDK init.** Never call Supabase/Stripe/etc. constructors at module load time — initialize inside functions or route handlers.
4. **BullMQ lazy init.** Queue instances must be initialized lazily, not at module level.
5. **Explicit > clever.** Readable code beats concise code. Name variables descriptively.
6. **No dead code.** Delete commented-out code. Git has history.

## 📦 Output Rules

1. **Be concise.** Show only changed lines with context. Don't echo back full files.
2. **Diff over dump.** Describe what changed and why.
3. **Batch related edits.** Group related file changes into a single logical operation.
4. **Verify before done.** Run type-check and build. Only report completion after passing.

## 🏗️ Architecture Conventions

- `node:22-slim` as the base Docker image (required for Supabase realtime native WebSocket)
- Lazy-init all SDKs — never at module level (prevents Railway boot crashes)
- Add boot trace + `process.on('uncaughtException', ...)` crash handlers to every server entry
- **Stripe status**: only `payment_intent.succeeded` (or `checkout.session.completed`) grants access — never `processing`
- **UUIDs must match** across Supabase auth, `customers` table, and Stripe metadata
- Webhook events must be logged AFTER handler completes, not before
- Supabase `getPublicUrl` is for public buckets only — use signed URLs for private storage
- `REPORT_DRY_RUN=true` in Railway until live Stripe mode is verified

## 💳 Stripe Products

| Plan    | Monthly | Annual  |
|---------|---------|---------|
| Starter | $19/mo  | $190/yr |
| Pro     | $69/mo  | $690/yr |
| Growth  | $129/mo | $1,161/yr |

Annual discounts: Starter/Pro = 2 months free (deliberate); Growth = 3 months free (deliberate conversion hook — do not "fix").

Webhook endpoint (test mode): `we_1TgdoUHQhXwdEcI9y0HXZsGM` → `https://welra-production.up.railway.app/webhooks/stripe`
Events: `checkout.session.completed`, `customer.subscription.updated`, `customer.subscription.deleted`, `invoice.payment_succeeded`, `invoice.payment_failed`
(Old dead-URL endpoint `we_1TgD1g...` is disabled. Create live-mode endpoint via API — `POST /v1/webhook_endpoints` returns the signing secret.)

## 🚦 Current Status

**E2E test-mode validation COMPLETE (2026-06-09)** — checkout → webhook → Supabase confirmed. 3 more pre-live bugs fixed same day (dry-run coercion, incomplete→trialing, getPublicUrl on private bucket).
**Critical path:** Etsy + Shopify dev app submissions → CSV upload → beta users → Stripe live mode.
See [[Projects/Welra/State]], [[Projects/Welra/Tasks]], and [[Projects/Welra/Strategy_Review_2026-06-09]].

## 🔁 E2E Test Workflow

Run before any production deploy or after major changes:
```
Workflow({ name: 'welra-e2e-audit' })
```
Script: `~/.claude/workflows/welra-e2e-audit.js` (44 agents: code audit + live API tests + adversarial verify)

## 🗂️ Vault Integration

Session start: read `_Dashboard.md` and `_Inbox/To_Claude.md`
During work: update `Projects/Welra/State.md`, check off tasks in `Tasks.md`
Session end: log to `Worklogs/Claude_Log.md`, write to `_Inbox/To_Antigravity.md`, clear `_Inbox/To_Claude.md`

---

<!-- 📏 Keep this file under 200 lines. Use .claude/rules/ for topic-specific overflows. -->
