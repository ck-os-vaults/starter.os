---
type: skill
created: 2026-08-03
updated: 2026-08-15
reviewed: 2026-08-15
status: living
authority: canon
source: ai
---

# vault maintenance

## purpose

Prevent stale information and abandoned documents from accumulating while
keeping retrieval, archives, and every repository recoverable.

## trigger

Run from an owner-approved schedule, on explicit request, after a bulk import or
major reorganization, or when routing repeatedly fails. Scheduling is optional;
do not create a recurring task unless the owner wants one.

## required inputs

- Vault root and current date.
- `os/agent-rules.md`, `os/vault-map.md`, `os/retrieval.md`,
  `os/recovery.md`, and the nearest repository instructions.
- Declared repositories: `os/`, `life/`, and every real
  `biz/<business>/`.

## hard safety gates

- Never begin cleanup until the pre-maintenance Git checkpoint passes for every
  declared repository.
- Never delete. Archive only inside the owning repository.
- Never edit material after it enters an archive.
- Never archive current operating rules, owner context, canonical foundations,
  current status, active projects, decisions, journal, conversations,
  daily/weekly/monthly records, or anything still required by an active route.
- Age alone never proves staleness. Use current status, decisions, replacements,
  owner evidence, links, and repository instructions.
- Never invent current truth to make an audit pass. Mark a visible currency gap
  when evidence is insufficient.
- Never mix repositories in one commit or include unrelated work.
- If `setup/` is still active, report that onboarding is incomplete and skip
  maintenance without changing files.

## phase 1 — create the pre-maintenance Git checkpoint

For every declared repository, independently:

1. Inspect the branch, status, untracked files, remotes, and existing work.
2. Run the installed validator and security sweep before saving anything.
3. If completed intentional work is unsaved, review its exact scope, commit it
   in its owning repository, and follow the Git publication law in
   `os/agent-rules.md`.
4. Do not absorb unknown, unfinished, sensitive, or unrelated changes into the
   checkpoint. Resolve them safely or exclude that repository from maintenance
   and report the blocker; do not clean around them.
5. Require a clean working tree and record the published GitHub commit.
6. Record the verified pre-maintenance commit ID for each repository in the
   run report.

Do not continue to cleanup unless every repository has a recoverable,
privacy-safe starting point on GitHub.

## phase 2 — audit active truth and retrieval

Review active files only, loading archived bodies solely when provenance is
needed:

1. Check `life/now.md`, project and business status files, current priorities,
   operating instructions, integrations, recovery details, and time-sensitive
   claims for stale or contradictory information.
2. Search for abandoned drafts, obsolete instructions, old TODOs, unchecked
   tasks, expired dates, placeholder language, duplicated documents, and
   superseded workflows still presented as current.
3. Apply `os/retrieval.md`: verify lifecycle, authority, source, dates,
   `superseded_by`, filenames, summaries, tags/properties, links, and wikilinks.
4. Ensure knowledge maps and readmes route to one current authoritative source,
   use path-qualified links when names are ambiguous, and never route through
   archived material as current truth.
5. Find orphaned active notes, broken links, missing destinations, duplicate
   basenames, and files whose owner is unclear. Flag aging inbox material for
   [[inbox-triage]] rather than triaging it here.
6. Update confirmed current facts and routes. Mark unresolved currency gaps
   visibly rather than guessing.
7. Run the validator. Fix and repeat until the active system passes before any
   archive move.

## phase 3 — archive safely

An archive candidate must satisfy every canonical eligibility test:

1. explicit evidence that it is done, superseded, duplicated by a named current source, or an obsolete setup/export artifact
2. one clear owning repository
3. no active dependency
4. a recorded current replacement or disposition

Age alone never proves staleness. Other skills may nominate candidates but must not restate these tests or move them.

For each archive candidate:

1. Identify its owning repository and current replacement, if any.
2. Confirm no active map, startup file, status, or unresolved dependency still
   requires the old path.
3. Before moving it, set honest lifecycle metadata such as `status: archived`
   or `status: superseded` plus `superseded_by` when a replacement exists.
4. Update active maps and links to the current source. Preserve an archive link
   only when it is useful historical evidence.
5. Move the file without rewriting its body into
   `<owning-repository>/archive/YYYY-MM-DD-weekly-maintenance/`, preserving a
   meaningful relative structure when needed to avoid ambiguity.
6. Create one `manifest.md` in that dated archive containing the
   pre-maintenance commit, old path, archive path, replacement, reason, and link
   updates for every move. Finalize the manifest after all moves, then treat the
   entire dated archive as immutable.

When evidence is insufficient, keep the file active, mark the currency gap,
and list it in the report. Never create `_review`, `maybe-delete`, or parallel
holding systems.

## phase 4 — final verification and publication

1. Re-run metadata, retrieval, link, privacy, repository-boundary, and installed
   validator checks across the active vault.
2. Reconcile every planned edit and archive move against the actual filesystem.
3. Inspect the staged diff for accidental content loss, invented facts,
   unrelated changes, archive edits, secrets, and stale routes.
4. For each changed repository, commit only its maintenance work with a clear
   message. Skip unchanged repositories and never create empty commits.
5. Follow the Git publication law in `os/agent-rules.md`.
6. Require clean working trees.
7. If a check fails, fix it and repeat this phase.

## output

Return one concise report containing:

- pre-maintenance commit ID for every repository;
- files updated, archived, or left as currency gaps;
- archive manifest paths and current replacements;
- validation and security results;
- final commit IDs for changed repositories;
- publication and clean-tree status;
- at most three follow-ups that genuinely require the owner.

## boundaries

- Follow the standing publication approval recorded during setup. If it is not
  active, do not push; report the missing prerequisite.
- Do not reinterpret owner-authored meaning, alter protected doctrine, or make
  high-impact decisions under the label of maintenance.
- Do not rewrite Git history, force-push, or delete remote refs.
- [[distill]] owns content promotion. This routine owns currentness, routing,
  archive decisions, approved structural remediation, and backup health.
  [[security-sweep]] owns targeted defensive privacy and repository-hygiene detection.
