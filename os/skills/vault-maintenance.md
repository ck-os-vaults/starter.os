---
type: skill
created: 2026-08-03
updated: 2026-08-11
reviewed: 2026-08-11
status: draft
authority: exploratory
source: ai
---

# vault maintenance

## purpose

Keep structure, metadata, links, indexes, archives, and backups trustworthy without losing important material.

## trigger

Monthly after real use, after a restructure, or when retrieval repeatedly fails. Do not make it a first-day burden.

## safety contract

- Never delete. Move approved inactive material to a dated archive.
- Never archive the operating layer, owner context, decisions, daily/weekly/monthly record, journal, conversations, or anything living, canonical, or still referenced.
- A file is only an archive candidate when it is done or superseded, old enough to be clearly inactive, unreferenced by current material, and outside protected locations.
- Every move is proposed to the owner first.
- The validator must pass before and after maintenance.

## steps

1. Inspect each declared repository independently, start from clean trees, and run the validator.
2. Run the metadata audit and repair non-meaning-changing problems.
3. Check broken links, missing routes, structure against `os/vault-map.md`, and readme accuracy.
4. Review aging inbox items and name blockers.
5. Present an archive dry run; move only owner-approved candidates.
6. Run the backup-health checklist in `os/recovery.md`, including `origin`/`backup` ref parity and a full-vault restore check.
7. Validate again, publish each changed repository under the GitHub-first law, and report the maintenance date.

## boundaries

- Status or meaning changes require owner confirmation.
- Never mix maintenance moves with unrelated work or combine independent repositories.
- When uncertain, leave the file where it is and explain the uncertainty.
