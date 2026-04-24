# Project Workflow Guide
## How GitHub, Obsidian, and Claude Work Together

---

## The Big Picture

You have three tools that work as a system:

| Tool | What It Does | Where It Lives |
|------|-------------|----------------|
| **Obsidian** | Where you write and organize all notes and project files | `/Users/ryannortham/Documents/MyVault` |
| **GitHub** | Automatic cloud backup and version history of everything in Obsidian | `github.com/rcn723/obsidian-vault` |
| **Claude Desktop** | AI assistant that can read and write directly into your vault | Connected via MCP filesystem |

The key insight: **anything you save in Obsidian is automatically backed up to GitHub and readable by Claude.** You only need to work in one place — Obsidian.

---

## Where to Save Project Files

Everything goes inside your vault at:
```
/Users/ryannortham/Documents/MyVault/
```

### Recommended Folder Structure

```
MyVault/
├── Projects/
│   ├── Project Name/
│   │   ├── Overview.md        ← what the project is, goals, status
│   │   ├── Notes.md           ← running notes and research
│   │   ├── Tasks.md           ← to-do items and progress
│   │   └── Reference/         ← supporting files and documents
├── Reference/                 ← general reference material not tied to one project
├── Claude Setup Reference.md  ← system setup notes
└── Project Workflow Guide.md  ← this file
```

You don't have to follow this exactly — but keeping each project in its own folder makes it much easier for Claude to find and work with your files.

---

## How GitHub Backup Works

You don't need to do anything. The Obsidian Git plugin runs automatically every day and:

1. Detects any files you've added, changed, or deleted
2. Commits those changes with a timestamp
3. Pushes them to `github.com/rcn723/obsidian-vault`

Your GitHub token is stored in Mac Keychain so this all happens silently with no passwords required.

**To trigger a manual backup anytime:**
- In Obsidian: press `Ctrl+P` and search for `Obsidian Git: Commit and push`

**To see your backup history:**
- Go to `github.com/rcn723/obsidian-vault` in a browser
- Click on any file to see its full change history

---

## How Claude Reads and Writes Your Files

Claude Desktop is connected directly to your vault. In any Claude Desktop conversation you can ask Claude to:

**Read your project files:**
> Read my Projects/Northam Family History/Overview.md and summarize where things stand

**Search across your vault:**
> Search my vault for anything related to Intel retirement planning

**Write or update a file:**
> Add a new task to my Projects/Northam Family History/Tasks.md — "Scan the Peterson family photos"

**Create a new project file:**
> Create a new project folder and overview note for my Hubitat automation project

**Summarize a session and save it:**
> Summarize what we just decided and save it to my Projects/Intel Retirement/Notes.md

Claude can only access files inside your vault at `/Users/ryannortham/Documents/MyVault`. Files outside that folder are not visible to Claude.

---

## Starting a New Project — Step by Step

1. **Create a folder** in Obsidian under `Projects/Your Project Name/`
2. **Create an Overview.md** inside it — write what the project is, the goal, and current status
3. **Tell Claude about it** — in your next Claude session say:
   > I have a new project. Read Projects/Your Project Name/Overview.md and help me get started
4. **Let Claude help build out the structure** — it can create Tasks.md, suggest a folder layout, pull in research, and write notes directly into the project folder
5. **GitHub handles the backup** — no extra steps needed

---

## Best Practices

**Write project overviews in plain language.** Claude reads these before helping you, so a clear one-paragraph description of what the project is and where it stands saves a lot of back-and-forth.

**Keep one active notes file per project.** A running `Notes.md` where you dump research, decisions, and updates beats dozens of small scattered files.

**Let Claude write the summaries.** After a long research or planning session, ask Claude to summarize what was decided and save it directly to your project notes. This keeps your vault current without extra work.

**Don't put sensitive credentials in vault files.** Your GitHub repo is public. Passwords, account numbers, and tokens should stay out of Obsidian notes.

---

## Quick Reference Commands

| What You Want | What to Say to Claude |
|--------------|----------------------|
| See all projects | `List everything inside my Projects folder` |
| Check project status | `Read my [Project Name] Overview and tell me where things stand` |
| Add a task | `Add this task to my [Project Name] Tasks.md: [task]` |
| Save session notes | `Summarize what we covered and save it to [Project Name] Notes.md` |
| Find something | `Search my vault for anything about [topic]` |
| Start fresh project | `Create a new project folder for [name] with an Overview and Tasks file` |

---

## If You Need to Rebuild This Setup

See `Claude Setup Reference.md` in the root of your vault. It has every path, the full config file, and a troubleshooting guide.
