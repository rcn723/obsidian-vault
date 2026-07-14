---
title: NAS Gaps and Process Report
project: Photo_Archive
type: report
updated: 2026-07-11
tags: [photos, nas, gaps, dedup, process]
---

# Photo Archive: Gap Map & Process Assessment
*Prepared 2026-07-11 · Read-only analysis of MacBook, WD Passport, NAS archive, and Lightroom catalog*

## Part 1 — What never made it to the NAS (the gap map)

Your NAS archive holds 951,923 files (2.57 TB). Comparing every in-scope
photo/video on the Mac and Passport against it (by filename + exact size):

**79,023 files — 510 GB — have no NAS counterpart at all ("definite missing").**
Another 23,800 files (236 GB) have a size match under a different name and
need a rename-aware check before trusting ("maybe renamed").

### Definite-missing, by where they're stranded

| Location | Files | Size | What it is |
|---|---|---|---|
| Passport `LR SYNC PC` | 26,898 | 124.3 GB | Old Lightroom sync staging that never completed its journey |
| Passport `2024 Japan South Korea` | 12,949 | 123.9 GB | **Entire trip, unarchived** |
| Mac + Passport `Dell Laptop Working PHotos` | 17,709 | 59.7 GB | Working folder contents that never graduated |
| Passport `iPhone Videos` | 2,061 | 50.9 GB | iCloud video downloads |
| Passport `2025 DIsneyland` | 1,491 | 24.9 GB | **Entire trip, unarchived** |
| Passport `SD Card Imports` | 934 | 22.0 GB | Card dumps never processed |
| Mac `Dads 80th photos` | 1,254 | 21.8 GB | **April 2026 event, unarchived** |
| Passport `2025 Yellowstone` | 762 | 17.2 GB | **Entire trip, unarchived** |
| Mac `Pictures` | 1,330 | 12.0 GB | 80th-bday working set |
| Passport `Iphone Screenshots` | 1,653 | 10.4 GB | Phone offloads |
| Mac `Documents` / Passport `Extras` | 8,339 | 17.5 GB | Scattered strays |

Full list: `missed_on_nas.csv` (every file, with confidence tier).

**The headline: your last ~2 years of major events (Japan/South Korea,
Disneyland, Yellowstone, Dad's 80th) exist only on devices that aren't your
archive — and two of those devices have known corruption history (the
Passport's FOUND.000 folders) or no redundancy at all.**

### Metadata gaps inside the NAS archive (from the Lightroom catalog)

The archive itself is well-organized (year + event folders), but coverage
is uneven:

- **Faces:** essentially untagged on the biggest trips — Vietnam 1,281 of
  29,138 · Madagascar 1,073 of 12,151 · 2014 Africa 1 of 7,741 · 2013 Peru
  0 of 4,633 · 2014 Alaska 1 of 2,001 · 2015 West Coast 0 of 2,087.
- **GPS:** strong after ~2014, weak before — 2007: 24% · 2008: 20% ·
  2009: 27% (understandable: pre-GPS cameras; fixable in bulk by trip).
- **Keywords:** some year-folders nearly bare — 2014: 87 of 2,074 ·
  2015: 221 of 3,752.

## Part 2 — Process assessment

### Your current flow (as reconstructed from the data)

```
SD card ──> Lightroom (geotag, faces, rename, organize) ──> NAS "final storage"
iCloud ──> manual download ──> (same treatment intended) ──> NAS
```

The *intent* is right. The evidence says the pipeline leaks at four joints:

1. **No "archived = verified" checkpoint.** Nothing confirms a set actually
   landed on the NAS before the working copy stops mattering. Result:
   whole trips stranded in `LR SYNC PC`, `SD Card Imports`, and working
   folders — invisible because the files *exist somewhere*.
2. **Transfers are copies, not verified moves.** Copying leaves the source
   behind; over years that produced the 175 GB of duplicates we just
   organized, and makes "what's archived?" unanswerable by looking.
3. **Too many ingest mouths, no single inbox.** SD cards, iCloud downloads,
   phone dumps (`Brock phone photos…`), screenshots — each created its own
   folder-universe on whichever device was handy.
4. **The Passport plays two conflicting roles** — scratch space AND
   quasi-archive — plus it travels, gets yanked without ejecting (today's
   repair; the FOUND.000 folders), and holds the only copy of real events.

### The iCloud leg specifically

`iPhone Videos/iCloud Photos/` (87 GB) and `Iphone Screenshots` show the
pattern: manual, occasional, bulk downloads that pile up unprocessed.
Manual iCloud export is the most forgettable step in the whole chain —
it needs to be the most automatic one.

## Part 3 — Recommendations (all free)

### A. Adopt states, not places (the core fix)
One pipeline where a folder name IS the status:
```
NAS/photo/00_INBOX/<date-source>/     everything lands here, from anywhere
NAS/photo/10_WORKING/<event>/         only what Lightroom is actively processing
NAS/photo/NAS Photos/<year>/<event>/  the archive (unchanged)
```
Rule: a photo exists in exactly ONE state. When it moves forward, it
*moves* (verified, then source removed). Ten minutes of discipline per
import ends the "is this archived?" question forever.

### B. Make "archive it" a verified one-command step
You now own the tooling: the dedup scripts from today double as a
checksum-verified mover. I can wrap them into a single
`archive-verify` command: copies to NAS → verifies checksums → only then
clears the source. (The same trick that just moved your Mac losers safely.)

### C. Automate the iCloud leg with icloudpd
Free, open-source (`icloudpd`), runs on the Mac or NAS on a schedule:
incremental-downloads your iCloud library straight into `00_INBOX`,
tracks what it already fetched, handles HEIC/Live Photos. Your manual
download step disappears; screenshots and videos stop pooling on devices.

### D. Backfill faces with digiKam — it's already on your NAS
Your NAS share carries digiKam's databases (including `recognition.db`) —
someone set this up before. digiKam's face recognition is free and batch:
point it at one trip at a time (Vietnam → Madagascar → Africa → Peru, the
four biggest gaps), let it cluster faces overnight, confirm names in bulk.
Faces then live in XMP where Lightroom can read them too.

### E. Write metadata OUT of the catalog
You have 284k XMP sidecars on the NAS — good instinct, keep it total:
Lightroom → Catalog Settings → Metadata → **"Automatically write changes
into XMP"** = on. Your geotags/faces/keywords then survive any catalog
loss and are readable by digiKam/Synology/anything.

### F. Face the NAS space wall before the backlog lands
NAS: 791 GB free; unarchived backlog: ~510 GB. Landing it leaves <10%
free — Synology performance and snapshot room suffer. Free countermeasures,
in order: (1) run Synology Storage Analyzer for intra-NAS duplicates
(your `LR SYNC PC` pattern almost certainly exists on the NAS too);
(2) after this cleanup, the Passport (4 TB, freshly organized) becomes the
offsite/second copy via a monthly Hyper Backup or rsync job rather than a
primary holder of unique data.

### G. Backup honesty (3-2-1 without new spend)
Today, most of the archive exists in exactly one place (NAS, RAID ≠
backup). After the backlog lands on the NAS: Passport = rotating second
copy (rsync/Hyper Backup, monthly), and your existing cloud (iCloud keeps
phone-originals; consider Synology C2-free-tier/Glacier only if you later
accept cost). Minimum viable: the monthly Passport sync — automatable,
$0, and it turns the drive that caused today's scare into your safety net.

### H. Small hygiene wins
- Retire dead Lightroom roots (C:/, D:/, the two //NORTHAM-JONES 2017
  shares) and the empty TempCatalog — one master catalog, one truth.
- Keep drive-watch (installed today) — it already saved you once.
- Eject before unplugging, always: today's entire outage was one skipped
  eject.
- Monthly 15-minute "archive close": inbox empty? backup job green? gap
  script clean? (I can make the gap check a one-command re-run.)

## Suggested order of operations
1. ✅ Dedup/organization executing now (Passport becomes reviewable).
2. Ryan reviews `_DELETE_CANDIDATES` + this report.
3. NAS-side duplicate scan (free space recovery) — I can run it next.
4. Archive the 510 GB backlog to the NAS, verified, trip-by-trip
   (Japan first — it's the largest single-copy risk).
5. Turn on XMP auto-write; retire dead catalog roots.
6. Set up icloudpd + monthly Passport backup job.
7. digiKam face-backfill, one trip per week.
