---
title: Mac External Drive Not Mounting Runbook
project: ops
type: runbook
updated: 2026-07-11
tags: [macos, usb, external-drive, exfat, disk-utility, wd-passport, runbook]
---

# Mac External Drive Not Mounting / Disk Utility Hangs

## ⚡ Fastest diagnostic — run this FIRST

```sh
iostat -d disk4 1 5        # find N first if needed: ls -la /dev/disk*  (newest timestamp = the drive)
```

**If MB/s > 0 while the drive is unmounted → macOS is silently repairing the
filesystem. The drive is FINE. Do NOT unplug. Just wait (20 min–hours for 4TB
exFAT).** Everything else — Finder blank, Disk Utility hanging empty, `diskutil
list` never returning — is a *symptom of the repair*, not a fault.

If MB/s ≈ 0 and it never mounts → real problem; see decision table below.

## Why this happens (2026-07-11 incident, WD My Passport Wireless Pro 4TB)

1. Drive is unplugged without ejecting → exFAT volume flagged dirty.
2. Next plug-in: `diskarbitrationd` runs an exFAT check/repair **before
   mounting, with zero UI feedback**.
3. During the repair, diskarbitrationd is blocked → Disk Utility opens blank
   and hangs; `diskutil list` hangs; Finder shows nothing.
4. User assumes drive is dead, unplugs → repair aborted, volume still dirty →
   next plug-in restarts the repair from scratch. **Infinite loop.** Ryan lost
   hours to this exact cycle.

## Decision table

| Check | Command | Result → meaning |
|---|---|---|
| Is the disk seen at USB level? | `ioreg -p IOUSB -w0` | Device listed → cable/port/enumeration fine. Not listed → cable (charge-only?), port, or drive power. |
| Did storage attach? | `ls -la /dev/disk*` — new diskN with recent timestamp | Present → drive + bridge working. Absent (but USB enumerated) → drive in wrong mode (see Wireless Pro note) or bridge failure. |
| Is it mid-repair? | `iostat -d diskN 1 5` | MB/s > 0 → **repair in progress, WAIT**. ~0 → stalled/dead. |
| What did macOS log? | `log show --last 45m --style compact --predicate 'process == "diskarbitrationd"'` (put in a script file — inline zsh quoting mangles it) | Look for `repaired disk, id = /dev/diskNsM, ongoing` and "Checking file system hierarchy" — confirms silent repair. |
| Is diskutil itself wedged? | `ps aux \| grep diskutil` | Hung `diskutil list` processes: `kill` them; they'll hang again until repair completes — that's expected. |

**Never use `diskutil` / Disk Utility to diagnose this** — they go through
diskarbitrationd, which is the very thing that's blocked. Use `ioreg`,
`iostat`, `mount`, `ls /dev/disk*` (none of them hang).

## WD My Passport Wireless Pro specifics

- Power the drive **OFF before** plugging into the computer. If its Wi-Fi mode
  is running, USB can act as charge-only (no storage enumeration).
- If battery is dead, charge on wall power first — the internal HDD may not
  spin reliably otherwise.
- Default format is exFAT (volume "My Passport"), GPT, 4TB → repairs are slow.

## Permanent fix (installed 2026-07-11): drive-watch

LaunchAgent that notifies when a plugged-in drive is being silently repaired
("leave it plugged in"), when it's ready, and when it's genuinely stalled.

- Runs from `~/Library/Application Support/drive-watch/drive_watch.py`
  (LaunchAgents **cannot read ~/Desktop** — TCC blocks it with
  `Operation not permitted`; that's why it's installed there)
- Agent: `~/Library/LaunchAgents/com.ryannortham.drivewatch.plist` ·
  Log: `~/Library/Logs/drivewatch.log` ·
  Source + README: `~/Desktop/Claude/drive-watch/`
- Health check: `launchctl list | grep drivewatch` (second column 0 = healthy)

## What does NOT work / wasted paths

- Opening Disk Utility "to see the drive" — hangs blank until repair ends.
- Unplugging and replugging — restarts the repair from zero. The worst move.
- Killing the hung `diskutil` — harmless but pointless; DA stays blocked.
- New cable / different port / reboot — irrelevant when iostat shows active I/O.
- `system_profiler SPUSBDataType` — can return empty while DA is wedged; use
  `ioreg -p IOUSB` instead.

## Prevention

- **Always eject before unplugging** (Finder right-click → Eject). A cleanly
  ejected exFAT volume mounts in seconds.
- Keep the Mac awake during a long repair (lid open, on power).

Related: [[Knowledge_Base/Learnings_and_Conventions]] · drive-watch source in
`~/Desktop/Claude/drive-watch/README.md`
