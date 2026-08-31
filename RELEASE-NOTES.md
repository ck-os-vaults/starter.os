# Starter.OS release notes

## 2.0.0 — 2026-08-30

Starter.OS 2.0.0 is the first manifest-managed release.

### What is new

- The public repository link alone starts the guided experience.
- Setup, preserve-first migration, and update have separate step-by-step agent routes.
- Every route discovers existing Git history, remotes, providers, uncommitted work, and recovery coverage before changing anything.
- Each repository uses one chosen primary. Secondary Git services are automatic mirrors, not routine second push targets.
- The installed system includes the protected plain-language manual at `os/manual.md`.
- Every public skill is classified as core portable, optional portable, optional scheduled, adapter, private, or unsupported.
- `Nightly Chief Reconciliation` and `Nightly System Security Check` are guided opt-in automation recipes in all three routes.
- The release manifest records managed and owner-owned artifacts with SHA-256 identities.
- The update tool previews additions, safe managed updates, owner content, forks, conflicts, and deprecated files before applying an approved transition.
- Migration accounts for every source path as preserve, copy, transform, merge, exclude, or unresolved while proving the source remains unchanged.
- Code is MIT licensed. Documentation, the manual, Markdown skills, agent instructions, and templates are CC BY 4.0.

### Starting states

2.0.0 supports:

- a clean first-time installation in an empty destination;
- a preserve-first migration from another file-based personal system through the migration map and verifier;
- a manifest-managed 2.0.0 update;
- a guided update from an unversioned legacy Starter.OS, with every managed file treated as a conflict until the owner explicitly chooses replace, keep as a fork, or defer.

Older or heavily customized systems are never silently treated as matching a known baseline.

### Compatibility

The portable repository contract is model- and agent-agnostic. It can be read by Codex, ChatGPT, Claude, Hermes, Goose, and other file-capable agents. Those names are examples, not required dependencies.

The deterministic release suite validates the repository files and Ruby tools in a local Git workflow. A particular agent, cloud scheduler, connector, operating system, or hosting provider is not called fully supported until its own complete setup, working-task, update, recovery, and restore path has been tested.

### Known limitations

- Scheduled routines require an owner-approved scheduler with access to the named sources. If unavailable, setup records the exact gap.
- Automatic mirror setup depends on capabilities available from the chosen primary and secondary providers.
- Local-only Git does not protect against device loss.
- Git does not include ignored, untracked, hidden, or external content unless separately protected.
- The updater does not silently merge modified managed files. It stops for an owner choice.
- The release does not promise one-to-one support or a response time.

### Update

Paste the public repository link into a file-capable agent. The root `AGENTS.md` routes an existing Starter.OS to `setup/UPDATE.md`.

The update process:

1. audits Git and recovery;
2. creates a file-level plan;
3. shows every conflict and owner choice;
4. requires a verified recovery commit;
5. applies only the approved transition;
6. validates the installed system;
7. commits and pushes only to the primary;
8. verifies enabled mirrors;
9. offers and verifies the two standard automations.

### Rollback

Before apply, record and verify the exact local Git recovery commit for every affected repository and add separate protection for content Git does not cover.

If validation fails, stop. Restore the affected repository from the named pre-update commit, restore uncovered content from its named backup, run `ruby os/validate-starter-os.rb`, and verify the primary and mirrors before resuming work.
