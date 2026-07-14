---
title: Photo Workflow SOP — Lightroom-Centered Process v2
project: Photo_Archive
type: sop
updated: 2026-07-11
tags: [photos, lightroom, workflow, sop, nas, archive]
---

# Photo Workflow SOP — Lightroom-Centered Process v2

The single reference for how photos flow from camera/phone to the NAS
archive. Designed 2026-07-11 from the dedup/gap analysis findings (see
[[Projects/Photo_Archive/NAS_Gaps_and_Process_Report]]). Everything here
uses Lightroom Classic features you already own — no new spend.

## The golden rules

1. **A photo lives in exactly ONE state:** `00_INBOX` → `10_WORKING` →
   `NAS Photos` archive. The folder it's in IS its status.
2. **All folder moves happen INSIDE Lightroom** (Folders panel drag), never
   in Finder. LR then moves the file AND keeps the catalog truthful — no
   broken links, and the move itself is your "archived ✓" checkpoint.
   *(This one habit prevents the 510 GB stranded-photos problem from ever
   recurring.)*
3. **Metadata is written to files, not just the catalog** (auto-XMP, below).
4. **Nothing is deleted outside Lightroom's reject workflow.**

## Stage 0 — Ingest (goal: one mouth, not five)

- **SD cards:** Lightroom Import dialog, always with:
  - **Copy** into `10_WORKING/<YYYY Event Name>/`
  - **File renaming template** `YYYYMMDD_<Event>_####` — named correctly
    from second zero, never renamed again
  - **Metadata preset** (creator/copyright) applied at import
  - ☑ **"Don't import suspected duplicates"** — LR's built-in dup guard;
    this checkbox alone would have prevented much of the 175 GB we cleaned
  - ☑ Build **Smart Previews** — for THIS import only, and they get
    discarded at archive time (Stage 3). Never build them catalog-wide:
    242k of them ≈ 250+ GB of proxies and a bogged-down catalog — the
    exact overwhelm Ryan hit before. Scoped to the working set (a few
    thousand photos), they stay in the low single-digit GB.
- **iPhone/iCloud:** `icloudpd` (free) auto-downloads to `00_INBOX` on a
  schedule; LR's **Auto Import** (File → Auto Import Settings) watches
  `00_INBOX` and pulls everything into the catalog with the same renaming +
  metadata preset. The manual "download from iCloud" chore disappears.
- **Family phone dumps** (Brock etc.): drop into `00_INBOX`, same funnel.

## Stage 1 — Cull BEFORE metadata (don't geotag garbage)

Current usage: 842 picks / 36 rejects in 242k photos — flags are unused
today, and they're the fastest tool in the app.

- Library, Loupe view, **Caps Lock ON** (auto-advance), then one pass:
  **P** = pick · **X** = reject · nothing = neutral
- Bursts: **stack** them (⌘G), pick the best frame, judge the stack once
- Finish: Filter → Rejected → ⌘⌫ (Delete Rejected Photos → Delete from
  Disk). This is the ONLY deletion path in the whole workflow.

## Stage 2 — Metadata in batches (never per-photo)

- **People:** the catalog already holds **166,820 detected face regions,
  mostly unnamed**. Work in People view (O): it clusters similar faces —
  name a cluster once, dozens tag at once. Backfill order: Vietnam →
  Madagascar → 2014 Africa → Peru (the four biggest gaps). New imports:
  People view shows "Unnamed People" per event — clear it per import.
- **GPS:** Map module. Select all photos from one stop → drag onto the map
  once. For hikes/trips, import a **GPX track log** (free phone apps
  record them) and LR auto-matches by timestamp — a whole day geotags in
  one action. Backfill order: pre-2010 years (2007: 24% coverage).
- **Keywords:** define **Keyword Sets** (Metadata → Keyword Set → Edit) per
  recurring context (family, trips, holidays); apply with the **Painter
  tool** (spray-can) in Grid view. Sync Metadata button for bulk-applying
  captions/keywords to selections.
- **Captions:** only where the story isn't in the keywords (4,940 so far —
  keep that habit for the keepers, skip for the rest).

## Stage 3 — Archive (the leak-proof step)

- In LR's Folders panel, **drag the finished event folder from
  `10_WORKING` to `NAS Photos/<year>/`**. LR moves the files to the NAS
  and every catalog link survives. When the folder sits under `NAS Photos`
  in the Folders panel, it is archived — no ambiguity, ever.
- Then select that folder → **Library → Previews → Discard Smart
  Previews**. Smart Previews are a working-set proxy, not an archive
  format — building/keeping them for the whole catalog is what bogs LR
  down. Working set in, archive out: the cache stays small forever.
- Monthly: glance at `10_WORKING` — anything older than 60 days is either
  finished (move it) or abandoned (decide).
- The Passport's new role after this cleanup: **backup of the NAS, not a
  primary home** — monthly verified sync (rsync/Hyper Backup), see
  [[Projects/Photo_Archive/NAS_Gaps_and_Process_Report]] Part 3G.

## Stage 4 — Catalog: leaner, faster, safer

Current: one 2.45 GB catalog, 242k images, dead roots, 376 collections,
sync residue, TempCatalog stray. Fixes:

1. **Retire dead roots** (Folders panel): `C:/`, `D:/`, the two 2017
   `//NORTHAM-JONES` shares — after confirming no unique files (the gap
   analysis can verify). Right-click → Remove. Kills phantom "missing
   folder" noise and shrinks backups.
2. **Delete `~/Pictures/TempCatalog/`** — verified empty (0 images).
   One catalog = one truth.
3. **Catalog Settings → Metadata → ☑ "Automatically write changes into
   XMP"** — your geotags/faces/keywords survive any catalog disaster and
   are readable by digiKam/Synology.
4. **File → Optimize Catalog** quarterly (compacts the 2.45 GB file).
5. **Previews:** Catalog Settings → File Handling → Standard Preview Size
   = Auto, **Discard 1:1 previews after 30 days** — keeps Previews.lrdata
   from ballooning.
6. **Smart Previews for the archive:** because imports build Smart
   Previews (Stage 0), you can cull, keyword, geotag, and even develop
   **with the NAS/Passport disconnected** — LR edits the 1½ MB proxy and
   syncs when the volume reappears. This decouples your laptop sessions
   from drive availability entirely.
7. **Backups that don't pile up:** keep "Back up catalog on exit" weekly,
   but the Backups folder keeps every copy forever — prune to the last
   3–4 (they're zipped catalogs; old ones are pure disk waste).

## Self-auditing catalog — Smart Collections as dashboards

Create once (you have only 16 smart collections; these make the catalog
police itself):

| Smart collection | Rule | Catches |
|---|---|---|
| ⚠ No GPS | GPS Data → is false | geotag gaps at a glance |
| ⚠ Unnamed faces | People → Unnamed People > 0 | face backlog per event |
| ⚠ Unkeyworded | Keywords → are empty | metadata debt |
| ⚠ Stale working | Folder = 10_WORKING + Capture Date > 60 days ago | stranded events (the Japan-trip failure mode) |
| ★ Portfolio | Rating ≥ 4 | instant best-of for sharing |

## Efficiency extras (each saves minutes every session)

- **Publish Services** (currently unused): create a Hard Drive publish
  service for recurring export targets (e.g. family-share folder) — LR
  tracks published vs modified state, so re-exports are incremental.
- **Batch rename later?** F2 with saved templates (never rename in Finder).
- **Secondary display** (F11) full-screen Loupe while Grid on the laptop.
- **Target collection** (B key) to gather cross-folder picks on the fly.
- **Painter tool** for drag-tagging keywords/flags across a grid.
- **Import presets** (bottom of Import dialog) — the whole Stage-0 config
  saved as one click per source (SD card vs inbox).

## Excire Search 2026 (subscribed, was never initialized — that's why it
never worked)

**One-time setup:** All Photographs → Library → Plug-in Extras → Excire
Search → Initialize/Analyze Photos → run overnight (242k images). The
.excat was 304 KB on 2026-07-11 = empty index = every past search failed.
New imports analyze incrementally in seconds afterwards.

| Use | How | Solves |
|---|---|---|
| Face backfill | Find people → by example face → select all → apply person keyword | the 166k unnamed faces, one person at a time, decades at once |
| Baseline keywords | Transfer Keywords on bare folders, into a separate `Excire\|` keyword branch | keyword-less 2014/2015 folders; searchability everywhere via XMP |
| Free-text search | Prompt search ("kids jumping into lake") | finding photos without any tagging |
| Find similar | Right-click keeper → find similar | near-duplicate culling byte-dedup can't see |

Rule: machine keywords stay under the `Excire|` parent — never mixed into
curated keywords. LR People view handles NEW imports; Excire handles the
archive backfill.

## Weekly rhythm (≈30 min)

1. Inbox to zero: Auto-Import already pulled `00_INBOX` → cull (Stage 1)
2. Batch metadata on the week's keepers (Stage 2)
3. Finished events → NAS via Folders panel (Stage 3)
4. Glance at the ⚠ smart collections; chip at one backfill trip
5. Monthly extra: backup-job green? Optimize catalog (quarterly), prune
   catalog backups

Related: [[Projects/Photo_Archive/State]] · [[Projects/Photo_Archive/Tasks]] ·
[[Projects/Photo_Archive/NAS_Gaps_and_Process_Report]] ·
[[Knowledge_Base/Mac_External_Drive_Runbook]]
