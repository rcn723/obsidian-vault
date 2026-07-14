---
title: Photo Archive — State
project: Photo_Archive
type: state
updated: 2026-07-12
tags: [photos, lightroom, nas, dedup, passport, archive]
---

# Photo Archive — State

## What it is
Personal photo archive overhaul across the MacBook, the WD My Passport Wireless Pro (4 TB), the Synology NAS photo share (192.168.1.2), and one Lightroom Classic catalog (241,894 images). Goal: one leak-proof pipeline (ingest → cull → metadata → verified NAS archive), the unarchived backlog landed on the NAS, and the Passport demoted from quasi-archive to backup. Process reference: [[Projects/Photo_Archive/Photo_Workflow_SOP]] · full analysis: [[Projects/Photo_Archive/NAS_Gaps_and_Process_Report]].

## Current status (2026-07-12 — project created 2026-07-11)

### Consolidation into ONE media area — DONE + VERIFIED (2026-07-12)
- Ryan requested ONE definitive media area. Executed: **ALL photos/videos moved into `/Volumes/My Passport/_ORGANIZED/`** — now **79,433 files / 607 GB**, the complete duplicate-free collection, mirroring original folder names. `_ORGANIZED/_README.txt` on the drive explains the layout. **`_ORGANIZED/` is now THE working collection.**
- **The Mac is now EMPTY of loose media** — 0 files outside app libraries/project dirs; 452 GB free. The old folder trees on the Passport are media-empty shells.
- `_DELETE_CANDIDATES/` grew to **42,441 files / 265 GB**, organized in subfolders: `passport/`, `mac/`, `consolidation/`, `consolidation-mac/`, `old-delete-folder/` — all journaled, nothing ever deleted.
- 80,662 + 3 actions total; 3 locked-file stragglers resolved. Journals: `~/Desktop/Claude/photo-dedup/consolidation_manifest.csv` + `CONSOLIDATION_MANIFEST.csv` on the drive.
- Consequence to keep in view: the entire 607 GB collection's unarchived portion now lives ONLY on the Passport (the Mac copies are gone) — the NAS backlog archive (below) is the remaining redundancy fix.
- Still pending (as relayed, planned tonight 2026-07-12): Excire initialization on the consolidated collection.

### Lightroom catalog repointed to _ORGANIZED — DONE (2026-07-12, safe to open Lightroom)
- The 6 relocated roots (2024 Christmas, 2024 Japan South Korea, 2025 DIsneyland, 2025 Yellowstone, Mac Pictures, Mac Dell Laptop Working PHotos) were repointed to their `_ORGANIZED/` paths via direct SQLite update on the catalog.
- Catalog backed up FIRST: `NorthamJonesPhotos-3-2-v13-3.lrcat.backup-20260712-142700`. Verification: 150/150 sampled files resolve. **Lightroom is safe to open.**
- The pre-existing dead roots (C:/, D:/, the two 2017 SMB shares) are a separate, still-open cleanup item — see [[Projects/Photo_Archive/Tasks]].

### Drive rescue + drive-watch — DONE
- Morning scare: the Passport appeared dead on the MacBook. Root cause = macOS silently repairing its dirty exFAT volume (consequence of an unclean eject). Repair completed in ~50 min; drive is healthy (4 TB, 1.7 TB used).
- Built + installed the **drive-watch** LaunchAgent (`com.ryannortham.drivewatch`, source `~/Desktop/Claude/drive-watch/`) — notifies during future silent repairs so a working drive never looks dead again. Ops detail: [[Knowledge_Base/Mac_External_Drive_Runbook]] (already written today — do not recreate).

### Dedup — EXECUTION COMPLETE (2026-07-11 ~2:15pm, zero unresolved errors; drive totals superseded by the 2026-07-12 consolidation above)
- Analysis scope: Mac vs Passport (NAS excluded by Ryan's choice). Found **18,284 byte-identical duplicate groups, 175 GB redundant** (91 GB Mac / 84 GB Passport). Winner per group picked by Lightroom-catalog metadata richness. Review manifest: `~/Desktop/Claude/photo-dedup/review_manifest.csv`.
- Final numbers: all **18,284 keepers copied + verified** into `/Volumes/My Passport/_ORGANIZED/` (117 GB, mirroring source folders); **13,273 Passport losers + 13,241 Mac losers** moved into `_DELETE_CANDIDATES/` (144 GB total); **4,338 Mac files skipped as hardlinks** (removal frees nothing — left in place by design); **~60 GB freed on the MacBook** (449 GB now free); 60 locked/immutable-flag stragglers all resolved in a cleanup pass (`chflags nouchg` on the `Documents/misc 2/New folder (4)` tree).
- Journal: `~/Desktop/Claude/photo-dedup/execution_manifest.csv`, with a copy at `/Volumes/My Passport/_DELETE_CANDIDATES/MANIFEST.csv`. Nothing was deleted; every move is reversible via the journal.
- Passport now **1.9 TB used / 1.8 TB free** — safe to touch again (the hands-off constraint is lifted). Awaiting Ryan's review of `_DELETE_CANDIDATES` before anything further happens to those files.

### NAS gap analysis — DONE (action pending)
- Via SSH (admin@192.168.1.2): **79,023 files / 510 GB definitely never archived to the NAS** — including ENTIRE trips: 2024 Japan South Korea (124 GB), 2025 Disneyland (25 GB), 2025 Yellowstone (17 GB), Dad's 80th (22 GB), plus `LR SYNC PC` staging (124 GB). A further **23,800 files / 236 GB "maybe renamed"** need a rename-aware check before trusting.
- NAS volume is **86% full (791 GB free)** — a NAS-side dedup must free space before the 510 GB backlog can land. Full detail: [[Projects/Photo_Archive/NAS_Gaps_and_Process_Report]].

### Lightroom catalog audit — DONE (SOP written)
- `NorthamJonesPhotos-3-2-v13-3.lrcat`: 2.45 GB, 241,894 images. Findings: 166,820 face regions detected but mostly UNNAMED; flags barely used (842 picks); 0 publish services; dead roots (C:/, D:/, two 2017 SMB shares); stray empty TempCatalog in `~/Pictures`.
- New process doc covering ingest→archive + catalog hygiene: [[Projects/Photo_Archive/Photo_Workflow_SOP]].

### Found infrastructure
- digiKam databases (incl. `recognition.db`) discovered on the NAS photo share — free face-recognition infrastructure already in place for the backfill.

## Next (ordered — mirrors the report's "Suggested order of operations")
1. ✅ Dedup execution complete (2026-07-11) → ✅ full consolidation into `_ORGANIZED/` + LR catalog repoint (2026-07-12). Excire init still pending (planned tonight).
2. Ryan reviews `_DELETE_CANDIDATES` (now 42,441 files / 265 GB, five subfolders) + `review_manifest.csv` — **ready now**.
3. NAS-side duplicate scan to free space.
4. Archive the 510 GB backlog to the NAS trip-by-trip, verified (Japan first — largest single-copy risk).
5. LR settings (auto-XMP, preview discard) + retire dead roots.
6. icloudpd → 00_INBOX + monthly Passport backup job.
7. Face backfill (LR People view / digiKam).

Live task list: [[Projects/Photo_Archive/Tasks]].

## Related
[[Projects/Photo_Archive/Tasks]] · [[Projects/Photo_Archive/Photo_Workflow_SOP]] · [[Projects/Photo_Archive/NAS_Gaps_and_Process_Report]] · [[Knowledge_Base/Mac_External_Drive_Runbook]]
