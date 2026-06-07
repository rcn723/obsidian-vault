---
title: Learnings and Conventions
type: knowledge-base
updated: 2026-06-07
tags: [deployment, railway, node, supabase, conventions, debugging]
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

See also: [[Projects/Rust_and_Rainbow/State]], [[Projects/Welra/State]]
