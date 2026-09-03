# Preserve and migrate an existing system

> **Audience: Agent only.** Read `START-HERE.md`, `QUICK-SETUP.md`, and `GIT-SETUP.md`. Keep the owner-facing explanation to **Protect → Review → Ask → Improve → Prove**.

## 1. Protect

Confirm one exact source. If the owner did not provide it, search only likely workspace locations read-only and ask one plain question if needed.

Confirm the public Starter.OS copy is complete:

```sh
ruby setup/scripts/validate-source.rb
```

Discover Git, recovery coverage, external content, and existing routines before mutation. Never initialize, move, rename, delete, pull, or reconfigure the source.

Create a content and Git-state snapshot outside both systems:

```sh
ruby setup/scripts/verify-migration.rb snapshot /absolute/path/to/OLD.os /absolute/path/to/source-snapshot.json
```

The snapshot records file bytes, file modes, directories, and important Git state without exposing remote URLs. The untouched old system is the primary local recovery copy. Add separate protection for anything external or at risk. Record the exact restore route before continuing.

## 2. Review

Read the source entry instructions, maps, files, repositories, integrations, and routines. Follow the critical review and customized-instruction process in `QUICK-SETUP.md`.

Classify every source path exactly once:

```text
source_path	disposition	destination_path	reason	approved_destination_sha256
```

Use:

- `preserve`: copy unchanged, normally to the same path;
- `copy`: copy unchanged to another approved path;
- `transform`: create an approved rewritten destination;
- `merge`: combine material into an approved destination;
- `exclude`: leave only in the untouched source;
- `unresolved`: keep safe until the owner decides.

Every transform, merge, exclude, or unresolved item needs a reason. Symbolic links must be reviewed and then transformed into a safe regular file or left unresolved. Never copy a link automatically.

For every transformed or merged file, review the finished destination and record `approved:<sha256>` in the last column. For `AGENTS.md` or `CLAUDE.md`, first account for every useful rule as retained, relocated, intentionally retired, conflicting, or unresolved. After approval, record `instruction-review:<sha256>`. Leave the last column blank for every other disposition. A disposition never authorizes source deletion. Unknown files are owner-owned.

## 3. Ask

Default to preserve-first. Reorganize only where the value is clear. Ask the owner only about genuine conflicts, unclear meaning, optional redesign, privacy, repository choices, and compatible optional routines.

Show the shared approval card with the source, separate destination, recovery route, disposition counts, instruction-file reconciliation, Git topology, unresolved items, and proposed changes. Wait for approval.

## 4. Improve

Create a separate clean preview:

```sh
ruby setup/scripts/create-vault.rb /absolute/path/to/NEW.os
```

Do not use the source as the writable workspace and do not import `.git/` internals or `setup/`. Execute only the approved map. Preserve bytes and file modes for `preserve` and `copy`. For `transform` and `merge`, retain the source, destination, method, reason, reviewed destination digest, and instruction accounting when required.

After preview approval, follow `GIT-SETUP.md`. Preserve existing history, create independent repositories for `os/`, `life/`, and every real `biz/<business>/`, push only to each chosen private primary, and make secondary services automatic mirrors. Suggest only compatible recurring routines, let the owner adopt, decline, or defer each one, and update equivalents instead of duplicating them.

## 5. Prove

Run:

```sh
ruby setup/scripts/verify-migration.rb verify /absolute/path/to/OLD.os /absolute/path/to/NEW.os /absolute/path/to/source-snapshot.json /absolute/path/to/migration-map.tsv
ruby os/validate-starter-os.rb
```

The migration verifier proves that snapshotted content, directories, and recorded Git state stayed unchanged; every source path is accounted for; copied bytes and modes match; approved destinations still match their reviewed digest; unsafe links did not cross into the destination; and destination boundaries are valid.

Separately confirm by review that no personal instruction disappeared, every repository and mirror is verified, and the rollback route remains usable. Do not call these external or meaning-based checks automated. A failed check stops migration.

Give the short shared receipt. Deleting or retiring the old system is never part of migration. Apply the cleanup rules in `QUICK-SETUP.md` only to an approved temporary public installer, never to the recovery source.
