# Redesign an existing system

> **Audience: Agent only.** The owner starts in `START-HERE.md` and gives the agent the migration prompt. Do not ask the owner to execute this procedure.

Treat migration as a complete system redesign built beside the existing vault. The goal is a clean, current COS system without losing or deleting anything.

## Non-negotiable safety rule

The existing vault remains untouched. Do not delete, overwrite, rename, or move anything inside it. Build the redesigned system in a separate location and copy material into it. Every existing content path must be classified exactly once in the migration map as `copy`, `exclude as obsolete scaffolding`, or `unresolved`. Repository internals under `.git/` are recorded separately as repository state rather than copied path by path. Unresolved material stays safely in the original vault until the owner decides where it belongs.

## 1. Understand the current system

If the owner did not supply the current vault path, search likely local workspace locations read-only and identify the strongest candidate. Show the exact path and wait for the owner's confirmation before treating it as the migration source. Never guess, inspect multiple private candidates broadly, or begin the inventory before confirmation.

Read the current rules, maps, repository state, and actual files. Infer the owner's identity, current work, project boundaries, businesses, preferences, and existing COS-like role from evidence. Do not ask the owner to explain information already present.

Inventory all content paths, system scaffolding, repositories, untracked files, external integrations, and recovery coverage without changing anything. Record counts and paths without exposing sensitive contents. Create the source snapshot outside both vaults:

```sh
ruby scripts/verify-migration.rb snapshot /absolute/path/to/OLD.os /absolute/path/to/source-snapshot.json
```

## 2. Design the replacement

Design the entire Starter.OS 2 structure around the owner's real material:

- propose the vault name;
- refer to the coordinating role as the Chief of Staff or COS until the owner names it;
- propose concise names for every personal project and business;
- classify every existing content path exactly once as copied to a proposed owner, excluded as obsolete scaffolding with a reason, or unresolved with a reason;
- separate current truth, supporting knowledge, records, documents, implementation, and system rules;
- exclude obsolete system scaffolding from the new active system while preserving it untouched in the original vault.

Do not preserve an old folder merely because it existed. Reorganize its contents according to the new ownership model.

Use a tab-separated migration map with this exact header:

```text
source_path	disposition	destination_path	reason
```

Use `copy`, `exclude`, or `unresolved` as the disposition. A copied path requires its new relative destination. Excluded and unresolved paths require a reason and no destination.

## 3. Ask only essential questions

Ask one compact group of questions only for choices that cannot be inferred safely. Usually this is limited to the vault name, optional COS name, ambiguous file ownership, and confirmation or correction of proposed project and business names.

Do not conduct a biography, workflow, tool, or life-history interview. Do not ask one question at a time when a short approval card will resolve everything faster.

## 4. Get naming and structure approval

Show one concise approval card:

1. Proposed vault and optional COS name.
2. Proposed projects and businesses, with the current files assigned to each.
3. Wiki, Records, Documents, and OS material.
4. Unresolved files or sensitive boundaries.
5. New repository and recovery map, following `GITHUB-SETUP.md` and labeling each layer `verified`, `configured but unverified`, or `owner declined`.

Make every proposed name visibly editable. Wait for the owner to approve or rename the COS, projects, businesses, and vault before building the preview.

## 5. Build the redesigned preview

Do not use the original vault as the writable workspace. Generate the separate Starter.OS 2 vault preview with the same clean generator used for a first-time install:

```sh
ruby scripts/create-vault.rb /absolute/path/to/NEW.os
```

The initial preview must contain only root pointers, `os/`, `life/`, and an empty `biz/` container. It must not contain `setup/`, imported `.git/` data, or obsolete empty scaffolding. Never initialize Git at the new vault root or at `biz/`.

Show the generated root tree, the exhaustive migration map, and the exact destination writes. Ask for one final confirmation before copying or personalizing. This is an adoption gate, not another interview.

After approval, copy every path classified as `copy` into its approved new location without changing the original. Preserve original file contents unless the owner explicitly approves consolidation or rewriting. Record one source and destination for every copied file. Keep a reason for every excluded or unresolved path.

Do not create a catch-all archive or import obsolete empty scaffolding into the new active system. Anything unresolved remains listed and safe in the untouched original vault.

## 6. Validate and hand back control

Run the installed-vault validator, repository checks, link checks, and the executable migration proof:

```sh
ruby scripts/verify-migration.rb verify /absolute/path/to/OLD.os /absolute/path/to/NEW.os /absolute/path/to/source-snapshot.json /absolute/path/to/migration-map.tsv
```

The verifier must confirm that the original content snapshot is byte-for-byte unchanged, every original content path is classified exactly once, every copied destination exists with matching bytes, excluded and unresolved paths have reasons, and the destination keeps the clean Starter.OS tree and Git boundaries.

Present the redesigned preview, the migration map, verifier result, and any unresolved items. Using the new vault, publishing repositories, or changing automations requires owner approval. Deleting the old vault is never part of migration.

Finish with this short orientation, personalized only where useful:

> Your COS is your main home base. Tell it the outcome you want in plain language; it will use the right project context, show a short plan before consequential work, and ask only when your decision or approval is truly needed. Project tasks keep their own routine work and reports, while your COS brings together only what affects the bigger picture. You can now return to your next real task.

Do not add a tutorial course, exercises, or a required first task.
