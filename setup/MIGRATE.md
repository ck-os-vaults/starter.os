# Preserve an existing system

> **Audience: Agent only.** The owner normally starts with the public repository link. Read `START-HERE.md`, `QUICK-SETUP.md`, and `GIT-SETUP.md`.

Migration preserves first. A clean redesign is optional and requires its own approval.

## Step 1: confirm one source

If the owner did not provide a path, search likely workspace locations read-only and identify the strongest candidate. Show the exact path and wait for confirmation before treating it as the source.

Do not inspect multiple private candidates broadly. Never delete, overwrite, rename, move, initialize, pull, or reconfigure the source during discovery.

## Step 2: inventory files, Git, recovery, and routines

Read the source's entry instructions, maps, actual files, repository state, integrations, and existing scheduled routines. Follow the Git discovery in `QUICK-SETUP.md`.

Create a content snapshot outside both systems:

```sh
ruby scripts/verify-migration.rb snapshot /absolute/path/to/OLD.os /absolute/path/to/source-snapshot.json
```

Record counts and paths without exposing sensitive contents.

## Step 3: choose preserve-first or optional redesign

Default to **preserve-first**:

- keep names and structure when they remain understandable;
- copy bytes unchanged into the separate preview;
- add only the minimum Starter.OS routing and safety foundation;
- avoid moving a file merely to make the result look cleaner.

Offer **redesign** only when the owner wants it and the value is clear. Redesign may reorganize copies in the preview; it never changes the source.

Classify every source content path exactly once in a tab-separated migration map:

```text
source_path	disposition	destination_path	reason
```

Allowed dispositions:

- `preserve` — copy unchanged, normally to the same relative path;
- `copy` — copy unchanged to a different approved path;
- `transform` — create an approved rewritten destination; reason required;
- `merge` — combine into an approved destination; reason required;
- `exclude` — leave only in the untouched source; reason required;
- `unresolved` — leave safe in the source until the owner decides; reason required.

A disposition never authorizes source deletion. Unknown files are owner-owned.

## Step 4: show the shared approval card

Include:

- confirmed source and separate destination;
- preserve-first or redesign mode;
- complete disposition counts and all transform, merge, exclude, and unresolved items;
- proposed names and ownership only where real evidence supports them;
- existing and proposed Git topology;
- exact recovery point and rollback route;
- available recurring-workflow capabilities, existing equivalents, and the owner's adopt, decline, or defer choice for each compatible suggestion.

Wait for approval before building the preview.

## Step 5: build the separate preview

Create the clean foundation:

```sh
ruby scripts/create-vault.rb /absolute/path/to/NEW.os
```

Do not use the source as the writable workspace. Do not import `.git/` internals or `setup/`.

Show the preview tree, migration map, and exact writes. Ask for final adoption approval before copying or personalizing.

After approval, execute only the approved map. Preserve source bytes for `preserve` and `copy`. For `transform` and `merge`, retain the source, destination, method, and owner-approved reason. Keep excluded and unresolved content untouched in the source.

## Step 6: prove preservation

Run:

```sh
ruby scripts/verify-migration.rb verify /absolute/path/to/OLD.os /absolute/path/to/NEW.os /absolute/path/to/source-snapshot.json /absolute/path/to/migration-map.tsv
```

The verifier must prove:

- the source is byte-for-byte unchanged;
- every source path appears exactly once;
- preserved and copied bytes match;
- transformed and merged destinations exist and have reasons;
- excluded and unresolved paths have reasons;
- the destination keeps safe Starter.OS boundaries.

A failed check stops migration.

## Step 7: protect and cut over

Follow `GIT-SETUP.md`. Preserve existing histories; do not copy `.git/` folders. Establish the approved working repositories, private hosted primaries, automatic mirrors, and recovery commit. Guide GitHub setup when no suitable hosted primary exists. Verify privacy and commit parity.

Cutover requires explicit owner approval after the preview and proof are shown. Deleting or retiring the old system is never part of migration.

## Step 8: guide optional recurring workflows

Use `QUICK-SETUP.md`. Suggest only compatible recipes, update equivalent routines instead of duplicating them, and prefer persistent home-base destinations when supported. Verify accepted routines and record declined, deferred, or unavailable status.

## Step 9: validate and hand back control

Run `ruby os/validate-starter-os.rb` in the adopted vault. Give the shared completion receipt, including all unresolved content and the rollback path.

Finish with the short orientation from `AGENT-SETUP.md`. Do not turn migration into a course or delete the source.
