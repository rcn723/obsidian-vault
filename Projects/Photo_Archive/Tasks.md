---
title: Photo Archive — Tasks
project: Photo_Archive
type: tasks
updated: 2026-07-12
tags: [photos, lightroom, nas, dedup, archive]
---

# Photo Archive — Tasks

Context: [[Projects/Photo_Archive/State]] · [[Projects/Photo_Archive/NAS_Gaps_and_Process_Report]] · [[Projects/Photo_Archive/Photo_Workflow_SOP]]

## Open
- [ ] Ryan reviews `_DELETE_CANDIDATES` on the Passport (now 42,441 files / 265 GB after the 7/12 consolidation; subfolders `passport/`, `mac/`, `consolidation/`, `consolidation-mac/`, `old-delete-folder/`) + `~/Desktop/Claude/photo-dedup/review_manifest.csv` — **READY NOW** (steps in [[_RYAN_TODO]] 📷 PHOTOS) [owner:: ryan] [priority:: high] [status:: open]
- [ ] Excire initialization on the consolidated `_ORGANIZED/` collection — pending, planned for tonight 2026-07-12 (as relayed by the coordinating session) [owner:: claude] [priority:: medium] [status:: open]
- [ ] NAS-side duplicate scan (Synology Storage Analyzer / dedup scripts) to free space before the backlog lands — NAS is 86% full, 791 GB free vs a 510 GB backlog [owner:: claude] [priority:: high] [status:: open]
- [ ] Archive the 510 GB backlog to the NAS trip-by-trip, checksum-verified (2024 Japan South Korea first — largest single-copy risk) — blocked on NAS space recovery + Ryan's go-ahead [owner:: claude] [priority:: high] [status:: blocked]
- [ ] Rename-aware check of the 23,800-file / 236 GB "maybe renamed" tier from the gap analysis [owner:: claude] [priority:: medium] [status:: open]
- [ ] Ryan: Lightroom Catalog Settings — Metadata → enable "Automatically write changes into XMP"; File Handling → discard 1:1 previews after 30 days (exact clicks in [[_RYAN_TODO]] 📷 PHOTOS) [owner:: ryan] [priority:: medium] [status:: open]
- [ ] Ryan: retire dead LR roots (C:/, D:/, the two 2017 //NORTHAM-JONES shares — after Claude verifies no unique files) + delete the empty `~/Pictures/TempCatalog` [owner:: ryan] [priority:: medium] [status:: open]
- [ ] Set up icloudpd → 00_INBOX + Lightroom Auto Import (kills the manual iCloud-download chore — SOP Stage 0) [owner:: claude] [priority:: medium] [status:: open]
- [ ] Monthly Passport-as-NAS-backup sync job (rsync/Hyper Backup, verified) — sequenced after the backlog is archived [owner:: claude] [priority:: medium] [status:: blocked]
- [ ] Face backfill via LR People view / digiKam (recognition.db already on the NAS): Vietnam → Madagascar → 2014 Africa → Peru [owner:: ryan] [priority:: low] [status:: open]

## Done
- [x] Consolidate ALL media into ONE definitive area (Ryan's request) — **DONE + VERIFIED 2026-07-12**: all photos/videos moved into `/Volumes/My Passport/_ORGANIZED/` (79,433 files / 607 GB, complete duplicate-free collection mirroring original folder names; `_README.txt` explains the layout); Mac now EMPTY of loose media (0 files outside app libraries/project dirs, 452 GB free); `_DELETE_CANDIDATES/` grew to 42,441 files / 265 GB across 5 journaled subfolders — nothing ever deleted; 80,662+3 actions, 3 locked-file stragglers resolved. Journals: `~/Desktop/Claude/photo-dedup/consolidation_manifest.csv` + `CONSOLIDATION_MANIFEST.csv` on the drive [owner:: claude] [status:: done] (2026-07-12)
- [x] Repoint the 6 relocated Lightroom roots (2024 Christmas, 2024 Japan South Korea, 2025 DIsneyland, 2025 Yellowstone, Mac Pictures, Mac Dell Laptop Working PHotos) to their `_ORGANIZED/` paths via direct SQLite update — catalog backed up first (`NorthamJonesPhotos-3-2-v13-3.lrcat.backup-20260712-142700`), 150/150 sampled files verified resolving, Lightroom safe to open [owner:: claude] [status:: done] (2026-07-12)
- [x] Monitor Phase-4 dedup execution to completion — **COMPLETED 2026-07-11 ~2:15pm, zero unresolved errors.** All 18,284 keepers copied + verified into `/Volumes/My Passport/_ORGANIZED/` (117 GB); 13,273 Passport losers + 13,241 Mac losers moved into `_DELETE_CANDIDATES/` (144 GB total); 4,338 Mac files skipped as hardlinks (removal frees nothing — left in place by design); ~60 GB freed on the MacBook (449 GB now free); 60 locked/immutable-flag stragglers resolved in a cleanup pass (`chflags nouchg` on the `Documents/misc 2/New folder (4)` tree). Journal: `~/Desktop/Claude/photo-dedup/execution_manifest.csv` (copy at `/Volumes/My Passport/_DELETE_CANDIDATES/MANIFEST.csv`). Passport now 1.9 TB used / 1.8 TB free [owner:: claude] [status:: done] (2026-07-11)
- [x] Rescue the Passport (root cause: silent macOS exFAT repair after unclean eject, ~50 min) + build/install the drive-watch LaunchAgent (`com.ryannortham.drivewatch`) — [[Knowledge_Base/Mac_External_Drive_Runbook]] [owner:: claude] [status:: done] (2026-07-11)
- [x] Mac↔Passport dedup analysis: 18,284 byte-identical duplicate groups / 175 GB redundant, keepers picked by LR-catalog metadata richness; `review_manifest.csv` produced; execution launched with Ryan's approval [owner:: claude] [status:: done] (2026-07-11)
- [x] NAS gap analysis over SSH: 510 GB definite-missing mapped (entire recent trips) + 236 GB maybe-renamed tier — [[Projects/Photo_Archive/NAS_Gaps_and_Process_Report]] [owner:: claude] [status:: done] (2026-07-11)
- [x] Lightroom catalog audit (2.45 GB / 241,894 images / 166,820 mostly-unnamed face regions / dead roots) + wrote [[Projects/Photo_Archive/Photo_Workflow_SOP]] [owner:: claude] [status:: done] (2026-07-11)
