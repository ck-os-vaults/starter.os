# Improve an existing Starter.OS

> **Audience: Agent only.** Read `START-HERE.md`, `QUICK-SETUP.md`, and `GIT-SETUP.md`. Keep the owner-facing explanation to **Protect → Review → Ask → Improve → Prove**.

## 1. Protect

Validate the public source:

```sh
ruby setup/scripts/validate-source.rb
```

Confirm one installed target and read `os/release.json`. If it is absent, label the target `unversioned legacy Starter.OS`; never guess its baseline.

Updates require independent Git repositories for `os/` and `life/`, with no repository at the vault root or empty `biz/` container. If the owner uses another topology, preserve it first, then plan and approve the conversion before continuing.

Discover Git and protection for every in-scope repository. Inspect tracked, untracked, ignored, hidden, and external content. Stop for divergence, an unfinished Git operation, or unique unprotected work.

Before planning any mutation:

- create and read back a recovery commit in every affected repository;
- verify each private hosted primary and enabled automatic mirror reaches that commit;
- create a separate local recovery copy outside the working OS for anything Git does not cover;
- record the exact restore route.

Do not proceed until the complete current state is recoverable.

## 2. Review

Create the deterministic plan outside the installed system:

```sh
ruby setup/scripts/update-vault.rb plan /absolute/path/to/NAME.os /absolute/path/to/update-plan.json
```

Critically review every proposed change and local customization. Follow the customized-instruction process in `QUICK-SETUP.md`, especially for large `AGENTS.md`, `CLAUDE.md`, or other controlling files.

Classify the plan in plain language:

- safe managed updates;
- owner-owned and unknown files that remain untouched;
- local customizations that need reconciliation;
- new, moved, forked, deprecated, or unresolved material;
- optional capabilities the owner's verified environment can support.

## 3. Ask

Resolve routine safe changes from evidence. Ask only about genuine conflicts, unclear personal meaning, structural changes, missing protection, or optional routines.

For a managed-file conflict, offer:

- **Reconcile.** Keep the useful personal meaning in the correct owner-controlled home and install the current Starter.OS file.
- **Keep my version.** Preserve the local file in place and stop future automatic replacement.
- **Replace with Starter.OS.** Install the reviewed Starter.OS file.
- **Wait.** Leave the update incomplete.

Do not select a meaningful conflict for the owner. Show one shared approval card naming the target release, plan identity, protection, changes, conflict decisions, Git actions, routines, and cleanup. Wait for approval.

## 4. Improve

Apply only the approved plan. The updater rechecks the source, target, and plan before writing.

```sh
ruby setup/scripts/update-vault.rb apply /absolute/path/to/NAME.os /absolute/path/to/update-plan.json
```

Use one exact option for each approved conflict:

```sh
ruby setup/scripts/update-vault.rb apply /absolute/path/to/NAME.os /absolute/path/to/update-plan.json --keep path/to/local-file --replace path/to/managed-file
```

`--keep` records a fork. `--replace` installs the current managed file. `--fork SOURCE=DESTINATION` preserves a reviewed local version at an owner-controlled destination before restoring the managed source.

The protected manual may not remain as an in-place fork. If the owner wants its local explanation, use an approved destination such as:

```sh
ruby setup/scripts/update-vault.rb apply /absolute/path/to/NAME.os /absolute/path/to/update-plan.json --fork os/manual.md=life/manual.md
```

Record the chosen manual fork in `os/me.md`. Never delete unknown or deprecated owner content. Push only to each primary; verify automatic mirrors. Suggest only compatible recurring routines, let the owner adopt, decline, or defer each one, and never duplicate an equivalent.

## 5. Prove

Run:

```sh
ruby os/validate-starter-os.rb
```

Compare the result with the protected inventory. The validator proves local structure, release identity, and readable local Git history. Separately verify and record each hosted primary, enabled mirror, uncovered-file backup, and rollback route. Confirm by review that no owner file or instruction disappeared. If any check fails, stop and restore before another attempt.

Give one short receipt: previous and installed version, result, preserved and unresolved work, protection status, validation, optional routine outcomes, cleanup status, and rollback route. Keep the recovery copy until the owner accepts the result. Apply the public-source cleanup rules in `QUICK-SETUP.md` only after success.
