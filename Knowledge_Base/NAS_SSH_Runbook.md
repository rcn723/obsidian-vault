---
title: Synology NAS SSH / Agent-Sync Troubleshooting Runbook
type: runbook
updated: 2026-06-22
tags: [nas, synology, ssh, rsync, agents, sync, runbook, ops]
---

# Synology NAS SSH / Agent-Sync Troubleshooting Runbook

Cross-project. Born from the 2026-06-22 incident where `sync-projects.sh` (Mac → NAS push for the Stock and Rust & Rainbow agents) failed with `Permission denied (publickey,password)` — the NAS at **192.168.1.2** had stopped accepting the `~/.ssh/nas_key`. This runbook makes the next occurrence a ~2-minute fix. See also [[Knowledge_Base/Learnings_and_Conventions]] and [[Knowledge_Base/DNS_Domain_Runbook]].

## Setup facts (so you don't re-derive them)

- **Host:** `192.168.1.2`, **user:** `admin`, **key:** `~/.ssh/nas_key` (pub: `~/.ssh/nas_key.pub`)
- **Mac `~/.ssh/config`** already has: `Host 192.168.1.2 / User admin / IdentityFile ~/.ssh/nas_key`
- **NAS base path:** `/volume1/claude-agents/` (sub-dirs `stock/`, `rust-rainbow/`, `venvs/`, `logs/`, `scripts/`)
- **Canonical Mac source for R&R:** `~/Claude/Projects/side business/Rust & Rainbow/` (NOT `~/Documents/Claude/...` — that stale path was a silent sync bug, fixed 2026-06-22 in `nas-setup/sync-projects.sh`)
- **Sync is one-way Mac → NAS** with `rsync --delete`; excludes `.env`, `market.log`, caches — but NOT `designs_log.json` (first sync after drift overwrites the NAS's social-rotation state once; self-corrects)

## The one fast diagnostic (run this FIRST)

Don't re-run the whole sync to see it fail. Isolate the auth with a key-only test:

```bash
ssh -i ~/.ssh/nas_key -o BatchMode=yes -o ConnectTimeout=8 admin@192.168.1.2 'echo NAS_OK'
```

- **Prints `NAS_OK`** → SSH is fine; the problem is elsewhere (path bug, rsync exclude, NAS disk). Stop here.
- **`Permission denied (publickey,password)`** → the NAS no longer accepts the key. Go to Fix. (`BatchMode=yes` is what makes this clean — it refuses the password fallback so you see the *pubkey* verdict, not an interactive prompt.)
- **`Connection refused` / timeout** → SSH service is off. DSM → Control Panel → Terminal & SNMP → enable SSH. Then re-test.
- The `WARNING: connection is not using a post-quantum key exchange` line is **harmless noise** — ignore it, it is not the failure.

## Two distinct error strings — don't confuse them

- **`Permission denied (publickey,password)`** = the steady-state truth: TCP + KEX fine, key is *offered but rejected* → it's not in the NAS `authorized_keys`. This is the real problem to fix (see below). Verify with `ssh -v …` — you'll see `Offering public key: …nas_key` followed by `Authentications that can continue: publickey,password` (server refused it).
- **`Connection closed by 192.168.1.2 port 22`** = the server dropped the session *after* TCP connect. If `nc -z -w5 192.168.1.2 22` still **succeeds** (port reachable), this is NOT a firewall/IP block — it's transient: **DSM Account Protection** or **sshd MaxStartups throttling** kicking in after a burst of failed logins. Fix: stop hammering, wait ~60s, and if it persists, unblock this Mac's IP (`192.168.1.62`) in **DSM web UI → Control Panel → Security → Protection → Allow/Block List** (or temporarily disable Auto Block). Then retry once. (If `nc` *times out* instead, it IS a firewall-level block → same DSM unblock, Account/firewall.)

## Why the key breaks (root causes, most common first)

1. **DSM update wiped or re-permissioned `~/.ssh/authorized_keys`** (most common). Synology resets home-dir state on major DSM upgrades.
2. **"User home service" got toggled off** → `~` for `admin` vanishes, so `authorized_keys` is unreadable.
3. **Home-dir permissions too loose** → OpenSSH silently refuses keys if `~` is group/other-writable.

## The fix

**Step 1 — re-install the public key (prompts for the admin password):**
```bash
ssh-copy-id -i ~/.ssh/nas_key.pub admin@192.168.1.2
```
Re-test with the fast diagnostic above. If `NAS_OK` → done, re-run the sync.

**Step 2 — if key still rejected after copy, it's the Synology permission quirk.** Via DSM password SSH (`ssh admin@192.168.1.2`, enter password) or the DSM UI:
- DSM → Control Panel → User & Group → Advanced → **enable "user home service"**
- Then:
  ```bash
  chmod 0711 ~                       # home must NOT be group/other-writable
  chmod 0700 ~/.ssh
  chmod 0600 ~/.ssh/authorized_keys
  ```
- Confirm `PubkeyAuthentication yes` in `/etc/ssh/sshd_config` (uncomment if needed), then `sudo synosystemctl restart sshd` (or toggle SSH off/on in DSM).
- Re-test.

## Escalation script (if a person must act)

Hand the NAS owner exactly this: *"SSH into 192.168.1.2 as admin with the password, enable Control Panel → User & Group → Advanced → user home service, then run `chmod 0711 ~ ; chmod 0700 ~/.ssh ; chmod 0600 ~/.ssh/authorized_keys`. If `~/.ssh/authorized_keys` is missing, run `ssh-copy-id -i ~/.ssh/nas_key.pub admin@192.168.1.2` from the Mac first."*

## Deploying agents to this NAS — hard constraints (learned 2026-06-22)

The reusable platform lives at `~/Claude/agent-platform/` (supersedes `~/Claude/nas-setup/`). Constraints that shaped it, all verified on this DS916+ (DSM, x86_64, Python 3.8.12, PDT):

- **rsync is dead on macOS → use tar-over-SSH.** macOS shipped `openrsync` (protocol 29); the NAS has GNU rsync (protocol 31); they cannot interoperate — even `rsync -a` fails "unexpected end of file." `tar c | ssh 'tar x'` over a clean channel (`ssh -T -o LogLevel=ERROR`) sidesteps the whole rsync protocol. Verify the channel is clean first (a login banner on stdout corrupts the tar stream).
- **admin cannot write `/volume1` root** (root-owned) → base the deployment in **`/volume1/homes/admin/...`** (admin's home, which admin owns). Requires "user home service" enabled in DSM.
- **Non-interactive sudo is password-blocked** (`sudo -n true` → "a password is required"). So nothing headless can touch root-owned paths (`/etc/crontab`, `/volume1` root). Run everything as plain admin from admin's home.
- **There is NO `crontab` command on Synology.** User crontabs don't exist. Scheduling options are only: (a) **DSM Task Scheduler** (GUI, durable across DSM updates — the right answer; `agent-platform/schedule.sh spec <agent>` prints exactly what to enter, User=admin), or (b) edit `/etc/crontab` (tab-separated, with a `who` user column) which needs root/sudo.
- **Python 3.8 is EOL → pin transitive deps.** Latest packages increasingly use 3.9+ syntax. Concrete: `multitasking` (a yfinance dep) latest uses `type[Thread]` subscripting → `TypeError: 'type' object is not subscriptable` at import on 3.8. Pin `multitasking==0.0.11`. After a working install, `healthcheck.sh --freeze <agent>` captures exact pins.
- **yfinance "database is locked"** on the NAS: threaded downloads race the SQLite tz-cache (`~/.cache/py-yfinance/tkr-tz.db`) on slow storage; intermittent, drops a ticker, agent still exits 0. Force single-threaded yfinance if it matters.

## After the key works

```bash
bash ~/Claude/nas-setup/sync-projects.sh     # Mac → NAS push (Stock + R&R)
ssh admin@192.168.1.2 'tail -20 /volume1/claude-agents/logs/rust-rainbow.log'   # verify
```

Expect the first R&R sync to overwrite the NAS `designs_log.json` (social-rotation `last_posted` resets once — harmless). Confirm the NAS now has current `agent.py` (e.g. `grep -c run_suggest` on the NAS copy).
