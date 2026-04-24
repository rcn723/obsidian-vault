# Claude + Obsidian + GitHub Setup Reference

## Key Paths

| Item | Path |
|------|------|
| Obsidian vault | `/Users/ryannortham/Documents/MyVault` |
| Claude Desktop config | `~/Library/Application Support/Claude/claude_desktop_config.json` |
| npx location | `/usr/local/bin/npx` |
| Node.js location | `/usr/local/bin/node` |
| GitHub repo | `https://github.com/rcn723/obsidian-vault` |
| Git identity | `rcn723` / `ryan@northamfamily.org` |

---

## Claude Desktop MCP Config

Full contents of `claude_desktop_config.json`:

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "/usr/local/bin/npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-filesystem",
        "/Users/ryannortham/Documents/MyVault"
      ]
    }
  },
  "preferences": {
    "launchPreviewPersistSession": true,
    "coworkScheduledTasksEnabled": true,
    "ccdScheduledTasksEnabled": true,
    "sidebarMode": "chat",
    "dockBounceEnabled": true,
    "coworkWebSearchEnabled": true,
    "keepAwakeEnabled": true,
    "coworkOnboardingResumeStep": {
      "step": "setup",
      "accountKey": "75292a0a-0c9e-4ee4-bb78-9e4fa6fbbc51:1361c7b2-ca7e-4aaa-9c28-430a9f085b14"
    },
    "chicagoEnabled": true,
    "ccAutoArchiveOnPrClose": true
  }
}
```

---

## What Was Set Up

1. Git initialized in Obsidian vault
2. Git identity configured as `rcn723` / `ryan@northamfamily.org`
3. `.gitignore` created for Obsidian-specific files
4. Initial commit made and pushed to `github.com/rcn723/obsidian-vault`
5. Obsidian Git community plugin installed — daily auto-commit and push enabled
6. Mac Keychain stores GitHub Personal Access Token silently (no re-auth needed)
7. Node.js installed at `/usr/local/bin/node`
8. Claude Desktop MCP filesystem server configured pointing at `/Users/ryannortham/Documents/MyVault`

---

## If Something Breaks

**MCP not connecting (no hammer icon or filesystem error):**
1. Check Node is still there: `node --version` in Terminal
2. Check npx path: `which npx`
3. Check config file looks right: `cat ~/Library/Application\ Support/Claude/claude_desktop_config.json`
4. Check logs: `cat ~/Library/Logs/Claude/mcp-server-filesystem.log`
5. Fully quit Claude (Cmd+Q) and reopen — don't just close the window

**GitHub push failing:**
1. Token may have expired — generate a new one at github.com/settings/tokens
2. Run `git push` in Terminal from inside the vault to see the actual error

**Obsidian Git not auto-committing:**
- Open Obsidian settings > Community Plugins > Obsidian Git > confirm schedule is set

---

## Useful Claude Prompts to Use With This Setup

- `List the files in my Obsidian vault`
- `Read my Cowork Projects Master Index and give me a status summary`
- `Search my vault for anything related to Intel retirement planning`
- `Search my vault for anything related to the Northam family history project`
