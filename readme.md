# Starter.OS

Starter.OS is a person-agnostic foundation for running a private Chief of Staff system with local files as durable truth and AI tools as replaceable execution layers.

## What it creates

```text
name.os/
├── AGENTS.md
├── CLAUDE.md
├── os/       shared operating context and portable workflows
├── life/     personal context, projects, knowledge, and records
└── biz/      empty until a real business is created
```

The root and `biz/` are plain containers. `os/`, `life/`, and each confirmed `biz/<business>/` are independently owned repositories.

The finished system does not include a catch-all inbox, archive folders, fake businesses, empty asset categories, setup scaffolding, or default automations. Structure is added only when real work needs it.

## Start here

- New system: [`setup/START-HERE.md`](setup/START-HERE.md)
- Existing Starter.OS owner: [`setup/MIGRATE-V1.md`](setup/MIGRATE-V1.md)
- Agent performing setup: [`setup/AGENT-SETUP.md`](setup/AGENT-SETUP.md)
- Contributor: run `ruby scripts/validate-starter-kit.rb`

## Operating model

- A Chief of Staff, referred to as the COS until the owner chooses a name, coordinates the whole system.
- Each substantial project or business task is its operational home base.
- Routine reports, approvals, blockers, and scheduled work stay with their project.
- Only material cross-project context returns to the COS through reconciliation.
- User-visible tasks, structural changes, deletion, publication, and external commitments require clear authority.
- Portable workflows live in `os/skills/`; agent-specific adapters remain outside the vault and point back to those workflows.

## Privacy

This repository is a public blueprint. Never personalize it or add credentials. The setup process creates a separate private vault for its owner.
