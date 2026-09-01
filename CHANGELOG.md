# Changelog

All notable Starter.OS changes are recorded here.

Starter.OS follows semantic versioning: major versions may require an owner-visible migration or change the operating contract, minor versions add backward-compatible capability, and patch versions correct behavior or documentation without changing that contract.

Changes being developed belong under **Unreleased**. When a release is approved, those entries move into a dated version section. Starter.OS history before 2.0.0 was unversioned.

## [Unreleased]

## [2.1.0] - 2026-08-31

Starter.OS 2.1.0 refines recurring work around persistent home bases while preserving the 2.0 structure and update contract.

### Added

- A single canonical changelog for permanent, version-by-version product history.
- A portable `News Report` recipe for owner-selected sources, citations, plain-language relevance, and `adopt`, `test`, `watch`, or `ignore` recommendations.
- Explicit update coverage for both manifest-managed 2.0 installations and the original unversioned Starter.OS.

### Changed

- Release history now uses an `Unreleased` section and semantic-version categories instead of a separate release-notes file.
- The recurring-work model now centers one persistent Chief of Staff home base and one persistent home base per real project when the execution environment supports them.
- `Morning Brief` is the suggested front-page workflow. It checks authorized calendar, task, project, and week-ahead context, then returns the owner's short check-in to the Chief of Staff home base.
- Task reconciliation now feeds the Morning Brief or an explicit checkpoint instead of producing a separate user-facing report by default.
- The security recipe is now a silent, read-only `System Security Watch` that reports only material findings or incomplete coverage.
- Setup, migration, and update detect available capabilities before suggesting recurring workflows. Owners may adopt, decline, or defer each compatible option, and no provider, source, model, or fixed schedule is required.
- Recurring output prefers an existing persistent destination instead of creating a new task for every run.

### Compatibility

- The 2.1 update path preserves unknown files and owner customizations from 2.0 and unversioned legacy installations. Managed-file conflicts still require an explicit replace, fork, or defer choice.

### Security

- The updater now rejects installed versions not declared by the target release instead of attempting an untested transition.

## [2.0.0] - 2026-08-30

Starter.OS 2.0.0 is the first formally versioned and manifest-managed release.

### Added

- Separate, step-by-step routes for first-time setup, preserve-first migration, and non-destructive update.
- A protected plain-language manual at `os/manual.md` for owners and agents.
- A release manifest that identifies managed and owner-owned artifacts with SHA-256 checksums.
- A deterministic update tool that previews additions, safe managed updates, owner content, forks, conflicts, and deprecated files before applying an approved transition.
- Migration accounting that classifies every source path as preserve, copy, transform, merge, exclude, or unresolved while proving the source remains unchanged.
- Portable skill classifications covering core, optional, scheduled, adapter, private, incomplete, and unsupported material.
- Guided opt-in recipes for `Nightly Chief Reconciliation` and `Nightly System Security Check` in all three owner routes.
- MIT licensing for code and CC BY 4.0 licensing for documentation, the manual, Markdown skills, agent instructions, and templates.

### Changed

- The public repository link alone now starts the guided owner experience.
- Every route discovers existing Git history, remotes, providers, uncommitted work, and recovery coverage before changing anything.
- Each repository uses one chosen primary. Secondary Git services are automatic mirrors, not routine second push targets.
- The portable repository is model- and agent-agnostic. Codex, ChatGPT, Claude, Hermes, Goose, and other file-capable agents are interchangeable execution layers rather than product dependencies.
- Older or heavily customized systems are treated conservatively and never silently assumed to match a trusted baseline.

### Security

- Added a reusable security-intake workflow that keeps newly sourced artifacts inert, treats embedded instructions as data, and protects private files from unapproved public scanning.
- Added read-only, fail-closed guidance for the optional nightly security check.
- Update plans are reconstructed and compared with the current source and target before apply, preventing edited plan actions from bypassing owner-content protections.
- Installation, update, release-building, and installed validation reject unsafe symbolic-link roots and path crossings.
- Public distribution inventory, secret-pattern checks, privacy checks, and source-integrity checks are deterministic release gates.

### Compatibility

2.0.0 supports:

- a clean first-time installation in an empty destination;
- a preserve-first migration from another file-based personal system through the migration map and verifier;
- a manifest-managed 2.0.0 update; and
- a guided update from an unversioned legacy Starter.OS, with every managed file treated as a conflict until the owner explicitly chooses replace, fork, or defer.

The repository contract is portable across file-capable agents. A particular agent, cloud scheduler, connector, operating system, or hosting provider is not called fully supported until its complete setup, working-task, update, recovery, and restore path has been tested.

### Known limitations

- Scheduled routines require an owner-approved scheduler with access to the named sources. If unavailable, setup records the exact gap.
- Automatic mirror setup depends on capabilities available from the chosen primary and secondary providers.
- Local-only Git does not protect against device loss.
- Git does not include ignored, untracked, hidden, or external content unless separately protected.
- The updater stops for an owner choice instead of silently merging modified managed files.
- The free product does not promise one-to-one support or a response time.

### Updating

Paste the public repository link into a file-capable agent. The root `AGENTS.md` routes an existing Starter.OS to `setup/UPDATE.md`.

The update process audits Git and recovery, creates a file-level plan, shows every conflict and owner choice, requires a verified recovery commit, applies only the approved transition, validates the result, commits and pushes only to the primary, verifies enabled mirrors, and offers the two standard automations.

### Rollback

Before apply, record and verify the exact local Git recovery commit for every affected repository and separately protect content Git does not cover.

If validation fails, stop. Restore the affected repository from the named pre-update commit, restore uncovered content from its named backup, run `ruby os/validate-starter-os.rb`, and verify the primary and mirrors before resuming work.

[Unreleased]: https://github.com/ck-os-vaults/starter.os/compare/v2.1.0...HEAD
[2.1.0]: https://github.com/ck-os-vaults/starter.os/compare/bb7d3c744348c933b03181a7dffa0b6a8c8701ca...v2.1.0
[2.0.0]: https://github.com/ck-os-vaults/starter.os/commit/bb7d3c744348c933b03181a7dffa0b6a8c8701ca
