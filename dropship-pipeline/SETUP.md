# Setup

## 1. Install the pipeline

```bash
# Unzip into your vault
cp -r dropship-pipeline ~/Documents/MyVault/dropship-pipeline
cd ~/Documents/MyVault/dropship-pipeline
chmod +x run-pipeline.sh
mkdir -p logs
```

## 2. Test it manually first

Do not schedule it blind. Run it once by hand and read the output:

```bash
./run-pipeline.sh
cat scan-log.md
```

Confirm `claude` and `jq` are both on your PATH (`which claude`, `which jq`).
If `jq` is missing: `brew install jq`.

Why test manually first: the script uses `--allowedTools` to pre-authorize
WebSearch and WebFetch without a permission prompt, since headless mode
can't ask you interactively. If a prompt is malformed or a tool call
behaves unexpectedly, you want to catch that watching it run once, not
find out three days into an unattended schedule. Tradeoff: this costs you
10 minutes of attention you could skip, but skipping it means your first
debugging session happens via log files instead of a live terminal.

## 3. Schedule it with launchd

Cron is deprecated for this kind of thing on modern macOS and needs extra
permissions. launchd is the native replacement.

```bash
cp launchd/com.ryan.dropship-pipeline.plist ~/Library/LaunchAgents/
launchctl load ~/Library/LaunchAgents/com.ryan.dropship-pipeline.plist
```

To stop it later:
```bash
launchctl unload ~/Library/LaunchAgents/com.ryan.dropship-pipeline.plist
```

Real constraint: this only runs while your Mac is on, awake or waking, and
you're logged in. If it's asleep at 7am, `RunAtLoad` fires it at your next
login instead, and the script's marker file stops it from double-running
that day. Why this matters: a job that silently doesn't run for a week
because the laptop was closed is worse than no automation, because you'll
assume it's working. Check `logs/launchd-stdout.log` weekly for the first
month to confirm it's actually firing.

## 4. Cost awareness

Each full run is 4 headless Claude Code calls. Based on typical headless
call costs, expect roughly $0.10 to $0.40 per full run depending on how
much web search context gets pulled in. Over a month that's a few dollars,
trivial, but check `--output-format json`'s `total_cost_usd` field in the
logs occasionally so a runaway prompt doesn't surprise you.

## 5. Obsidian Git will version this automatically

Since your vault already auto-commits daily via the Obsidian Git plugin,
scan-log.md, feasibility-log.md, plans-log.md, and verdicts-log.md all get
versioned for free. No extra step needed here, just confirm the
dropship-pipeline folder isn't excluded in your `.gitignore`.

---

# Before Gate 5 (real ad test): entity and compliance checklist

You already have the LLC, so the pipeline's job is to feed it, not to
create the need for one. A few things worth deciding before you spend on
a real test, not after:

**Decide if this runs under your existing LLC or a separate one.**
Why: if the existing LLC holds other assets or runs other activity, a
liability event from this venture (defective product claim, chargeback
dispute) sits inside the same entity and exposes everything else in it.
Tradeoff: a new LLC costs filing fees (roughly $50-500 depending on state)
plus an annual report and registered agent going forward, against the
risk of commingled liability if you skip it. For a sub-$500 ad test, most
people keep it under the existing LLC and revisit this if it actually
gets traction. Confirm with your accountant, not me, once real money is
in motion.

**Open a dedicated bank subaccount for this venture.**
Why: commingling funds between business activities is the single most
common way people accidentally undermine their own LLC's liability
protection. Tradeoff: one more account to reconcile, small overhead for
real protection.

**Get a resale certificate before ordering from suppliers that require one.**
Why: without it, many wholesale suppliers charge you sales tax on the
wholesale purchase, which you then can't fully recover, cutting into
margin twice. Tradeoff: minor paperwork per state, but do it before the
first supplier order, not after.

**Sales tax economic nexus is revenue-triggered, not choice-triggered.**
Why: most states require registration and collection once you cross
roughly $100k in sales or 200 transactions in that state per year,
regardless of LLC structure. Tradeoff: irrelevant at Gate 5 test-spend
levels, so don't over-engineer this now, just know the number that
triggers it so it doesn't blindside you if this actually works.

**General liability or product liability insurance, once past Gate 5.**
Why: the LLC shields your personal assets from business debts in most
cases, but it doesn't stop the business itself, or in some cases you as
an officer, from being sued over an actual product-caused injury.
Insurance is the layer the LLC doesn't cover. Tradeoff: real monthly cost
($30-100 typical for small ecommerce) you shouldn't pay before you know
the idea survives Gate 5, but shouldn't skip once you're taking real
orders.
