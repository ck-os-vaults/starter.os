# Two guided paths

> **Audience: Agent only.** Keep the owner-facing explanation short and use ordinary language.

Starter.OS supports two paths:

- **New installation.** Create a new private OS in an empty location.
- **Update.** Improve an existing Starter.OS without losing owner work.

Use Update only when `os/release.json` or clear Starter.OS evidence identifies the existing system. An unrelated repository is not a legacy Starter.OS and must not be converted in place.

## New installation

Follow `AGENT-SETUP.md` and use five simple steps:

1. **Name.** Confirm the private system name and empty destination.
2. **Protect.** Validate the public source and keep any existing personal repository safe and separate.
3. **Create.** Build the new system and establish private Git protection.
4. **Personalize.** Add only confirmed owner context and accepted optional routines.
5. **Prove.** Validate the system, verify protection, and give the owner a short orientation.

The installed root `AGENTS.md` belongs to the owner. Generate it from the approved system name. It must route agents to `os/AGENTS.md`, `os/me.md`, and the nearest project or business instructions without making Starter.OS the identity of the private system. Keep it short. Put lasting owner facts and rules in a Git-protected home, and cover the non-repository root entry files with the full-file backup.

## Update

Follow `UPDATE.md` and use **Protect → Review → Ask → Improve → Prove**.

### 1. Protect

Inspect read-only before moving, replacing, publishing, scheduling, or deleting anything. No mutation is allowed until the complete current state has a usable recovery route. Identify:

- every in-scope file, repository, remote, mirror, uncommitted change, and existing routine;
- tracked, untracked, ignored, hidden, and externally stored content;
- one readable Git recovery commit for each repository;
- matching commits at the verified private primary and enabled mirrors;
- a separate local recovery copy outside the working OS for anything Git does not cover, including a new updater-created root-entry backup folder;
- the exact restore steps.

Keep the recovery copy until validation succeeds and the owner accepts the result. Do not call the state fully protected while anything needed for restoration remains unverified.

### 2. Review

Critically compare the current system with the proposed result. Decide routine, reversible improvements from evidence instead of interviewing the owner about every file.

Classify every relevant path as unchanged, owner-owned, safe managed update, customized, new, deprecated, or unresolved. Unknown files are owner-owned.

Give special care to large or customized `AGENTS.md`, `CLAUDE.md`, and other instruction files:

1. preserve the complete original in the recovery state;
2. identify shared operating rules, owner facts, integrations, project or business rules, stale duplicates, and possible secrets;
3. keep portable Starter.OS rules in their managed `os/` homes;
4. keep the root `AGENTS.md` owner-owned and specific to the private system;
5. place useful owner information in its proper `os/`, `life/`, project, or business home;
6. never replace an owner-customized file with a summary;
7. surface only real conflicts or uncertain meaning for an owner decision.

An untouched root entry from an older Starter.OS may receive the one-time ownership transfer. A customized root entry must remain byte-for-byte unchanged unless the owner approves a specific reconciliation. If it contains lasting owner meaning, preserve that meaning and offer to place it in `os/me.md` or the correct Git-protected home; do not silently move or delete it.

Review existing Git topology and the environment's repository, persistence, scheduler, source-access, delivery, and Git-verification capabilities. Each real `biz/<business>/` must finish as its own independent Git repository. The vault root and empty `biz/` container are not repositories.

### 3. Ask

Ask one compact group of questions only for choices that materially change the result, such as:

- an unresolved conflict or unclear personal instruction;
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

### 4. Improve

Apply only the reviewed and approved plan.

- Preserve owner-owned and unknown content.
- Replace managed files only when their installed identity is known and unchanged.
- Reconcile customized instruction files only through an approved, recoverable change.
- Give update apply a new root-backup folder outside the private OS and public source. Do not proceed unless the updater copies and reads back the root entry files there.
- Push only to each repository's chosen primary. Secondary services are automatic mirrors.
- A new business is incomplete until `biz/<business>/` has its own verified Git history and private hosted primary.
- Suggest only optional routines supported by the owner's verified tools. Let the owner adopt, decline, or defer each one. Update equivalents instead of creating duplicates, prefer an existing persistent home-base destination, and do not create a new task for every run.

### 5. Prove

Run the update checks and full installed validation. Compare the finished state with the protected starting inventory and prove:

- no owner file or instruction disappeared silently;
- intended changes are the only changes;
- the owner-owned root instructions still route correctly;
- every affected repository has a readable local recovery commit;
- every private primary and enabled mirror reaches the expected commit;
- every real business is its own repository;
- optional routines are verified, declined, deferred, unavailable, or clearly unverified;
- the exact rollback route still works.

Give one short receipt: version, result, preserved work, unresolved items, local Git proof, hosted-primary and mirror proof, uncovered-file backup, validation, and rollback. State which checks were automated and which were verified separately.

## Optional: bring over what matters

This is owner work after a new installation, not a Starter.OS conversion path.

1. Leave the old repository unchanged and confirm its backup.
2. Review it read-only with the owner.
3. Copy only selected useful context into the proper owner-owned home.
4. Reconcile old agent instructions by meaning. Never install an old root instruction file over the new private OS entry.
5. Validate the new system after the selected material is added.
6. Keep the old repository as an archive until the owner separately approves any deletion.

## After success: clean up the public source

The installed private system never keeps `setup/`. Future updates use a fresh current source from the canonical public repository link.

- **Remote-only access.** Nothing local needs cleanup.
- **Temporary checkout or download.** Remove the whole copy only when the exact path and deletion were approved. First prove that it contains no owner files, credentials, unique work, or uncommitted changes.
- **Intentional maintainer or product checkout.** Leave it intact.
- **Pre-existing or uncertain folder.** Leave it intact and report why.

Never delete individual setup files, a recovery copy, or an owner's old repository as installer cleanup.
