# Protect, review, ask, improve, prove

> **Audience: Agent only.** Use this shared process for setup, migration, and update. Keep explanations short and use ordinary language.

## 1. Protect

Inspect read-only before creating, moving, replacing, publishing, scheduling, or deleting anything.

Choose the route:

- **Setup.** There are no existing personal files or system to preserve.
- **Migration.** Existing personal files or another system must be preserved.
- **Update.** An existing Starter.OS is changing to a newer version.

For migration and update, no mutation is allowed until the complete current state has a usable recovery route. Identify:

- every in-scope file, repository, remote, mirror, uncommitted change, and existing routine;
- tracked, untracked, ignored, hidden, and externally stored content;
- one readable Git recovery commit for each repository;
- matching commits at the verified private primary and enabled mirrors;
- a separate local recovery copy outside the working OS for anything Git does not cover;
- the exact restore steps.

For migration, snapshot the source and leave it untouched. For update, keep the recovery copy until validation succeeds and the owner accepts the result. Do not call the state fully protected while anything needed for restoration remains unverified.

## 2. Review

Critically compare the current system with the proposed result. Decide routine, reversible improvements from evidence instead of interviewing the owner about every file.

Classify every relevant path as unchanged, owner-owned, safe managed update, customized, new, moved with reason, excluded with reason, or unresolved. Unknown files are owner-owned.

Give special care to large or customized `AGENTS.md`, `CLAUDE.md`, and other instruction files:

1. preserve the complete original in the recovery state;
2. identify shared operating rules, owner facts, integrations, project or business rules, stale duplicates, and possible secrets;
3. keep current Starter.OS entry and safety rules at their managed paths;
4. place useful owner information in its proper `os/`, `life/`, project, or business home;
5. never replace the original with a summary unless that transformation is shown and approved;
6. surface only real conflicts or uncertain meaning for an owner decision.

Review existing Git topology and the environment's repository, persistence, scheduler, source-access, delivery, and Git-verification capabilities. Each real `biz/<business>/` must finish as its own independent Git repository. The vault root and empty `biz/` container are not repositories.

## 3. Ask

Infer what is safe from the evidence. Ask one compact group of questions only for choices that materially change the result, such as:

- an unresolved conflict or unclear personal instruction;
- the destination or name when it cannot be inferred safely;
- a structural change, deletion, publication, account, repository, or privacy choice;
- missing recovery coverage;
- which compatible optional routines the owner wants to adopt, decline, or defer.

Then show one short approval card:

1. result and exact locations;
2. protection and restore route;
3. changes, preserved work, and unresolved items;
4. Git primaries and optional automatic mirrors;
5. optional routines and source cleanup;
6. exact consequential actions being approved.

Wait for approval. Silence is not approval.

## 4. Improve

Apply only the reviewed and approved plan using the matching route instructions.

- Preserve owner-owned and unknown content.
- Replace managed files only when their installed identity is known and unchanged.
- Reconcile customized instruction files; do not overwrite or keep a stale controlling file blindly.
- Push only to each repository's chosen primary. Secondary services are automatic mirrors.
- A new business is incomplete until `biz/<business>/` has its own verified Git history and private hosted primary.
- Suggest only optional routines supported by the owner's verified tools. Let the owner adopt, decline, or defer each one. Update equivalents instead of creating duplicates, prefer an existing persistent home-base destination, and do not create a new task for every run.

## 5. Prove

Run the route-specific tools and full installed validation. Compare the finished state with the protected starting inventory and prove:

- the migration source content and recorded Git state stayed unchanged or every updated path has an exact disposition;
- no owner file or instruction disappeared silently;
- intended changes are the only changes;
- every affected repository has a readable local recovery commit;
- every private primary and enabled mirror reaches the expected commit;
- every real business is its own repository;
- optional routines are verified, declined, deferred, unavailable, or clearly unverified;
- the exact rollback route still works.

Give one short receipt: version, result, preserved work, unresolved items, local Git proof, hosted-primary and mirror proof, uncovered-file backup, validation, and rollback. State which checks were automated and which were verified separately. Do not call the route complete while a required check is assumed.

## After success: clean up the public source

The installed private system never keeps `setup/`. Future updates use a fresh current source from the canonical public repository link.

- **Remote-only access.** Nothing local needs cleanup.
- **Temporary checkout or download.** Remove the whole copy only when the exact path and deletion were approved. First prove that it contains no owner files, credentials, unique work, or uncommitted changes.
- **Intentional maintainer or product checkout.** Leave it intact.
- **Pre-existing or uncertain folder.** Leave it intact and report why.

Never delete individual setup files, a recovery copy, or the owner's old migration source as installer cleanup.
