# Mac Environment Reference — Ryan's MacBook Pro

*For Claude to reference before recommending installs, PATH changes, or system configuration.*
*Last updated: 2026-05-21*

---

## Machine Identity

- **Model:** MacBook Pro (R-MacBook-Pro)
- **Username:** `ryannortham`
- **Shell:** zsh (default on modern macOS)
- **Shell config file:** `~/.zshrc`

---

## Critical: This Is an Intel-Managed Corporate Mac

Ryan's MacBook is managed by Intel IT. This has real consequences for installs:

- `/usr/local/bin` and `/usr/local/lib` are **in PATH but may not be writable** by the user
- npm may report a successful global install but silently fail to write to `/usr/local/lib/node_modules`
- The binary symlink into `/usr/local/bin` may never get created even when install "succeeds"
- Intel has added custom package paths: `/opt/pkg/env/active/bin` and `/opt/pmk/env/global/bin` — these are Intel's own package managers, not standard macOS paths

**Confirmed incident (2026-05-08):** `npm install -g @anthropic-ai/claude-code` completed without error but installed nothing. `/usr/local/lib/node_modules/@anthropic-ai/` did not exist. Binary was not in `/usr/local/bin`.

**Fix applied (2026-05-08):** Redirected npm global prefix to `~/.npm-global` — a user-owned directory. All subsequent global installs should use this path.

---

## Node.js / npm Setup

- **Node version:** v22.22.2
- **npm version:** 10.9.7
- **Node location:** `/usr/local/bin/node`
- **npx location:** `/usr/local/bin/npx`
- **npm global prefix:** `~/.npm-global` (fixed 2026-05-08, was `/usr/local`)
- **PATH addition:** `$HOME/.npm-global/bin` added to `~/.zshrc`

### Fix Applied for npm Global Installs

```bash
mkdir -p ~/.npm-global
npm config set prefix ~/.npm-global
echo 'export PATH="$HOME/.npm-global/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

This is already done. Verify anytime with `npm config get prefix` — should return `/Users/ryannortham/.npm-global`.

---

## PATH (as of 2026-05-08)

```
~/.npm-global/bin                         (added 2026-05-08, user-owned npm globals)
/usr/local/bin
/System/Cryptexes/App/usr/bin
/usr/bin
/bin
/usr/sbin
/sbin
/var/run/com.apple.security.cryptexd/...  (Apple security paths, 3 entries)
/opt/pkg/env/active/bin                   (Intel package manager)
/opt/pmk/env/global/bin                   (Intel package manager)
```

---

## Install Strategy by Tool Type

| Tool type | Recommended approach | Why |
|---|---|---|
| npm global packages | `npm install -g` — prefix is now `~/.npm-global` | Fixed and verified |
| One-off CLI tools | `npx tool@latest` | No install, no PATH issues, always works |
| Homebrew packages | `brew install` | Homebrew manages its own paths, usually fine |
| curl \| bash scripts | **Avoid** | Security risk + may fail silently on managed Mac |
| Python packages | `pip install --user` or use venv | System Python may be locked |

---

## Software Confirmed Installed

| Tool | Version | Location | Notes |
|---|---|---|---|
| Node.js | v22.22.2 | `/usr/local/bin/node` | Fine, above all minimums |
| npm | 10.9.7 | via Node | v11 available but not urgent |
| npx | current | `/usr/local/bin/npx` | Works fine |
| Claude Code | 2.1.133 | `~/.npm-global/bin/claude` | Installed and authenticated 2026-05-08 |
| Ruflo | 3.6.x | `~/ruflo-test/` | Initialized and MCP registered 2026-05-08 |
| anthropic (Python) | 0.104.1 | `~/Library/Python/3.9/` | `pip3 install anthropic` — 2026-05-22 |

---

## Ruflo Setup (2026-05-08)

- **Install directory:** `~/ruflo-test/` (project-scoped, not system-wide)
- **Files written:** `.claude/`, `.claude-flow/`, `.mcp.json`, `CLAUDE.md`
- **MCP registered via:** `claude mcp add ruflo -- npx ruflo@latest mcp start`
- **Config written to:** `/Users/ryannortham/.claude.json`
- **Status at install:** 16/16 hooks active, MCP 1/1 connected, AgentDB initialized
- **Note:** Ruflo is project-scoped. To use in another directory, run `npx ruflo@latest init` there.
- **Honest fit assessment:** Ruflo targets developers coding in the terminal with Claude Code. Ryan's primary Claude usage is chat/conversational via Claude Desktop. Installed for AI skill-building purposes, not active daily use.

---

## Before Recommending Any Install to Ryan

1. Check if the tool can be run via `npx` instead — avoids all PATH issues on this machine
2. Confirm `npm config get prefix` returns `~/.npm-global` before any global install
3. Never recommend `curl | bash` install scripts
4. After any install, always verify with `which <tool>` before moving on
5. `/usr/local` writes silently fail on this managed machine — do not assume otherwise

---

## Obsidian Vault and Claude Desktop MCP

*Separate from system installs — captured here for completeness.*

- Vault path: `/Users/ryannortham/MyVault` (moved from `~/Documents/MyVault` on 2026-05-21)
- Claude project folder: `/Users/ryannortham/Claude` (moved from `~/Documents/Claude` on 2026-05-21)
- Claude Desktop MCP config: `~/Library/Application Support/Claude/claude_desktop_config.json`
- MCP server uses `/usr/local/bin/npx` → `@modelcontextprotocol/server-filesystem` → vault path
- GitHub repo: `github.com/rcn723/obsidian-vault`
- Obsidian Git plugin handles daily auto-commit and push
- Memory files live in `/Users/ryannortham/MyVault/memory/`
