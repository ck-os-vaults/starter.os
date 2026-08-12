# Starter.OS agent entry

This repository is the public Starter.OS installation kit. It is not a person's live vault and must never receive private owner context.

Read `readme.md`, then follow the route that matches the task:

- installing or personalizing a new vault: `setup/README.md` -> `setup/SETUP-STATUS.md` -> `setup/AGENT-RUNBOOK.md`
- maintaining the public kit: `readme.md` -> `scripts/validate-starter-kit.rb`
- migrating a version 1 personal edition: `migration-v1.md`

The generated vault has its own root `AGENTS.md` and operating chain. Never treat files under `template/` as the current owner's identity. Preserve the public/private boundary, never copy personal data back into this repository, and never place credentials in either location.

When this repository is checked out inside a larger operating system with an owning repository contract, follow that contract first; this file adds only Starter.OS-specific boundaries.
