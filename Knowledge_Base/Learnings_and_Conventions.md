---
title: Learnings and Conventions
type: knowledge-base
updated: 2026-06-13
tags: [deployment, railway, node, supabase, dns, domains, conventions, debugging]
---

# Learnings and Conventions

Cross-project lessons. Read this before starting any new build. Every entry cost real debugging time.

---

## Deployment

### Railway has two separate log views
**Problem:** The Deploy tab shows build steps + healthcheck output only. The actual container stdout/stderr is in the **Logs tab** (separate section). Healthcheck failures with no visible cause are often explained by logs that were never looked at.
**Rule:** When a Railway healthcheck fails, check the Logs tab before touching any code.

### Always confirm Railway deploy is green before moving to the next task
**Problem:** Welra was pushed to Railway and assumed deployed. 6 deploys and hours of debugging later, it finally went green. The original broken deploy was never confirmed.
**Rule:** After every `git push`, open Railway → Deployments and wait for the green badge. Do not start the next task until you see it. This is in `feedback_scaffold_quality.md` as a prevention rule.

### Node.js version must match SDK requirements
**Problem:** `@supabase/supabase-js` v2.39+ requires Node 22+ for native WebSocket, or the `ws` package. On Node 20, the Supabase client throws at module load — zero output, zero port binding, silent crash.
**Rule:** Use `node:22-slim` as the default base image for all new projects using modern Supabase. Check SDK release notes for minimum Node version before writing a Dockerfile.

---

## DNS, Domains & TLS

Full step-by-step: [[Knowledge_Base/DNS_Domain_Runbook]]. The essentials:

### Diagnose against the authoritative nameserver, never a cache
**Problem:** During the welra.io apex-SSL fix (2026-06-13), public resolvers (`1.1.1.1`/`8.8.8.8`) and the user's phone kept reporting stale state — they cache NXDOMAIN for the SOA negative-TTL (~1 hour), so they lie for an hour after a fix lands.
**Rule:** Always `dig +short @<authoritative-ns> <host>` (find it via `dig NS <domain>`). The SOA serial (3rd field) is the health tell: frozen across edits = registrar isn't republishing; differs across nameservers or goes backwards = fleet desynced. Both mean registrar support must force a zone rebuild — stop editing records.

### Namecheap re-injects its parking IP from two places
**Problem:** `162.255.119.x` kept reappearing on the apex A record after every manual delete. Two separate features cause it: the **Parking Page** AND a **"Redirect Domain"** URL redirect (`welra.io → www`). Each regenerates the record.
**Rule:** Turn off Parking AND remove any Redirect Domain. The host (Vercel/Netlify) handles apex→www itself — don't use the registrar's redirect.

### Vercel issues one cert for apex + www
**Problem:** The apex cert wouldn't provision while `www` was NXDOMAIN — Vercel's single cert covers both names, so either one failing validation stalls the whole cert.
**Rule:** Get BOTH names resolving before expecting a cert. `A @ → 76.76.21.21`; `www` → `cname.vercel-dns.com` (or `A www → 76.76.21.21` if a CNAME won't publish — Vercel routes by hostname, not IP). Never reconfigure Vercel to fix what is a registrar problem. A clean `curl -L https://domain` returning 200 proves the cert (openssl can false-negative on timeout). Don't trust "works on my phone" — usually it's hitting cached `www` while the apex is still broken.

---

## End-user connection walkthroughs

When writing "how to connect <platform>" steps for non-technical users (token/OAuth setup):
1. **Derive required scopes from the actual fetcher code**, not docs — least privilege. (Welra's Printify code only calls `shops.json` + `orders.json`, so the walkthrough requests Custom scope with exactly those two, not "All scopes (full access)".)
2. **Verify the menu path against the LIVE UI, not just docs** — docs lag. (Printify's account menu is bottom-left → Connections, not the documented top-right.) If the user is looking at the screen, their report is ground truth.
3. **Stress "Copy to clipboard — shown once"** on every one-time secret (Printify token, WooCommerce consumer secret, Shopify admin token). OAuth flows with no manual secret are exempt.

---

## Node.js / API Architecture

### Never instantiate SDK clients at module level with optional keys
**Problem:** `const stripe = new Stripe(env.STRIPE_SECRET_KEY)` at module level crashes instantly when `STRIPE_SECRET_KEY` is `''`. Stripe validates keys in its constructor. The crash happens during `require()` — before any logger exists — producing zero output.
**Rule:** Any SDK whose key has a falsy default (`''`, `undefined`) must use a lazy getter:
```ts
function getStripe(): Stripe {
  if (!env.STRIPE_SECRET_KEY) throw new Error('STRIPE_SECRET_KEY not configured')
  return new Stripe(env.STRIPE_SECRET_KEY)
}
```
Call `getStripe()` inside handlers, never at module top-level. After writing any route file, grep for `^const .* = new ` and verify each SDK tolerates an absent key.

### BullMQ Queue objects must be lazy-initialised
**Problem:** `export const myQueue = new Queue(NAME, { connection: redis })` at module top-level throws immediately when `redis` is null (i.e. REDIS_URL not set). Even if the start function is never called, the module load itself crashes.
**Rule:** Use the getter pattern:
```ts
let _queue: Queue | null = null
function getQueue(): Queue {
  if (!redis) throw new Error('Redis not configured')
  return _queue ??= new Queue(NAME, { connection: redis as any })
}
```
All `start*()` and `register*()` functions call `getQueue()` internally. Never export a module-level Queue instance.

### Add boot trace + crash handlers to every server entry point
**Problem:** Silent crashes (module-level throws before the logger initialises) produce zero output and are impossible to diagnose from healthcheck logs alone.
**Rule:** Every `server.ts` / entry point should include at the very top:
```ts
process.on('uncaughtException', (err) => {
  process.stderr.write(`[FATAL] uncaughtException: ${err.stack ?? err.message}\n`)
  process.exit(1)
})
process.on('unhandledRejection', (reason) => {
  process.stderr.write(`[FATAL] unhandledRejection: ${String(reason)}\n`)
  process.exit(1)
})
```
These use synchronous `stderr.write` so output is guaranteed even before the process fully initialises.

---

## Environment Variables

### Railway never reads .env files from the repo
**Problem:** env vars set in `apps/api/.env` are not loaded by Railway containers. Every required var must be explicitly set in Railway → Service → Variables.
**Rule:** `.env` files are for local development only. Treat Railway Variables as the source of truth for production. Keep a checklist of required Railway vars in the project State.md.

### Never use z.coerce.boolean() for env flags
**Problem:** `REPORT_DRY_RUN: z.coerce.boolean()` — env vars are strings, and `Boolean('false') === true`. Setting the var to `false` in Railway would have silently kept dry-run on at launch.
**Rule:** Boolean env flags use `z.enum(['true','false']).transform(v => v === 'true')`, with the SAFE state as default. Trace every documented "flip this flag" procedure through the actual parser.

### Zod env validation should not crash on optional-until-configured services
**Problem:** `STRIPE_SECRET_KEY: z.string().startsWith('sk_')` with no default crashes the server at boot before Stripe is set up. Same for Redis URL with `z.string().url()`.
**Rule:** Services that aren't configured at initial deploy should default to `''` or be optional in Zod, with runtime warnings emitted. Validate at the call-site (inside the handler/function), not at boot. Fail-fast only for truly required credentials (DB, auth).

---

## Vault Conventions

- Every new note needs YAML frontmatter (title, type, updated, tags)
- Use wikilinks `[[Path/To/Note]]` for all cross-references
- Tasks use inline Dataview: `[owner:: ryan|claude] [priority:: high] [status:: open]`
- Dashboard (`_Dashboard.md`) is the session entry point — read it first
- State.md per project tracks current status; Tasks.md tracks open work

---

## Auth & Billing Flows

### Never accept userId or email from the request body on billing routes
**Problem:** `POST /checkout/session` accepted `userId` from the request body. Any unauthenticated caller could create a Stripe session on behalf of any user ID, activating the wrong customer's account via webhook.
**Rule:** Any route that creates a Stripe session, processes a payment, or writes to a customer record must verify a JWT first. Derive `userId` and `email` from `supabase.auth.getUser(token)` — never trust them from the client body.

### Supabase `.update().select().single()` does not error on 0 rows — use upsert
**Problem:** `handleCheckoutCompleted` called `.update().eq('id', userId).select().single()`. When no customer row existed, PostgREST returned `data: null, error: null`. The code checked `if (error) throw error` — which passed — and then called `sendWelcomeEmail(null as Customer)`, crashing.
**Rule:** A `.update()` affecting 0 rows is not an error in PostgREST. Always check `if (!data)` separately. When a row may not exist yet, use `.upsert({ onConflict: 'id' })` instead of `.update()`.

### Idempotency keys require atomic INSERT ON CONFLICT — not SELECT+INSERT
**Problem:** Webhook idempotency used SELECT-then-INSERT. Under concurrent Stripe retries, both requests could pass the SELECT (row not yet inserted) and both INSERT — processing the event twice.
**Rule:** Use `supabase.from('table').insert(row, { count: 'exact' })` with a unique constraint. If `count === 0`, the row already existed — skip processing. Never use SELECT+INSERT for idempotency.

### Always verify DB trigger reads every field passed in signUp options.data
**Problem:** Signup passed `plan` in `options.data` to Supabase Auth. The `handle_new_auth_user` trigger only wrote `(id, email, name)` — `plan` was silently dropped. Every customer defaulted to `'starter'` regardless of selection.
**Rule:** After writing a signUp() call with `options.data`, read the corresponding trigger in schema.sql and confirm every field in `data` is read from `NEW.raw_user_meta_data` and written to the customers row.

### Keep schema.sql CHECK constraints in sync with TypeScript enum types
**Problem:** TypeScript `PlanTier = 'starter' | 'pro' | 'growth'` but schema had `CHECK (plan IN ('starter', 'pro', 'multi'))`. Inserting a `'growth'` row would fail at runtime.
**Rule:** After renaming any enum value in TypeScript, grep `schema.sql` for the old value and update all CHECK constraints to match.

---

## Testing

### Reusable e2e test workflow — run before any production deploy
Script saved at: `~/.claude/workflows/welra-e2e-audit.js`
Run with: `Workflow({ name: 'welra-e2e-audit' })`

What it tests (44 agents, ~8 min):
- Code audit: signup/auth flow, checkout route, webhook handler, dashboard, API health
- Live API tests: health check, checkout happy/negative paths, webhook signature validation, all public pages
- Adversarial verification: every HIGH/BLOCKER finding reviewed by a skeptic agent before reporting

Catches: auth trust boundary violations, silent DB update failures, race conditions, missing null checks, enum/constraint drift, unauthenticated endpoints.

---

## LLM Product Quality (added 2026-06-11, Welra eval session)

### A noisy judge makes prompt iteration whack-a-mole
**Problem:** Welra's report eval used a haiku judge with a terse rubric. It fired inconsistently on edge cases (investigation framing, arithmetic derived from present data), so "passing" was run-to-run luck and prompt fixes chased noise.
**Rule:** Calibrate the judge before iterating prompts: use a stronger model than feels necessary, write the rubric with explicit NOT-a-violation examples, and give the judge every input the generator received (Welra's judge flagged numbers our own pipeline computed because it never saw them). Then require N consecutive passing runs, not one.

### Small models state invented causes as fact
**Problem:** haiku synthesis fabricated causal mechanisms in every eval run ("you're losing them at checkout", "your listing changes are working") even after honesty-hardened prompts with examples. Sonnet under the same prompts passed 3/3 consistently.
**Rule:** For customer-facing narrative where unsupported claims are a product risk, the synthesis model tier is a quality control, not a cost knob. Keep cheap models for extraction/analysis passes; use the stronger tier for the voice that ships. Also: audit your own prompt examples — Welra's action example literally taught the model to cite external benchmarks the judge then flagged.

## Supabase Auth in Production (added 2026-06-11)

### Site URL defaults to localhost and testing never catches it
**Problem:** Welra ran weeks in production with Auth Site URL = `http://localhost:3000`. Every auth email link without an explicitly allowlisted redirect falls back to Site URL — real users could land on localhost. Tests passed because test flows always sent explicit redirects.
**Rule:** Go-live checklist item for every Supabase project: Site URL = production domain; redirect allowlist uses `https://domain/**` wildcards (matching is EXACT-path otherwise — `/dashboard` does not cover `/dashboard/settings`); "Secure email change" (dual confirmation) left ON.

### Email changes: use Supabase secure email change, don't build verification
**Rule:** `supabase.auth.updateUser({ email })` with secure email change sends confirmation to BOTH old and new addresses — takeover-resistant, zero custom code. One thing it doesn't do: update your own `customers.email` column — reconcile app-side after auth reflects the new address.

---

See also: [[Projects/Rust_and_Rainbow/State]], [[Projects/Welra/State]]
