---
type: map
created: 2026-08-11
updated: 2026-08-14
reviewed: 2026-08-14
status: living
authority: canon
source: ai
---

# Starter.OS

**Bottom line:** This repository shows the finished vault structure directly. `STARTER.os` is the example root name; setup asks what the owner wants to replace `STARTER` with before creating the private vault.

**When to read this:** New owners start at [`setup/README.md`](setup/README.md). Agents and setup helpers use [`setup/AGENT-RUNBOOK.md`](setup/AGENT-RUNBOOK.md).

## the structure

```text
STARTER.os/                one Obsidian vault; choose the STARTER name during setup
├── biz/                   business vaults
│   ├── business-model/    generic first-business model; renamed during setup
│   └── <business>/        one repository for each confirmed real business
├── life/                  private personal vault and repository
├── os/                    shared operating vault and repository
└── setup/                 temporary onboarding files
```

The public repository is arranged the same way so the system is understandable at a glance. During setup, the agent creates a separate private copy with the owner's chosen root name. The private root and `biz/` are plain containers; `os/`, `life/`, and every real business inside `biz/` have independent Git histories.

## begin

- New user: [`setup/README.md`](setup/README.md) -> [`setup/PROMPT-01-CREATE-MY-OS.md`](setup/PROMPT-01-CREATE-MY-OS.md)
- Existing vault: [`starter-os-migration-guide.html`](starter-os-migration-guide.html) for the visual guide, then
  [`setup/PROMPT-03-MIGRATE-OLD-VAULT.md`](setup/PROMPT-03-MIGRATE-OLD-VAULT.md) for the complete migration prompt
- Agent: [`setup/AGENT-RUNBOOK.md`](setup/AGENT-RUNBOOK.md)
- Contributor: run `ruby scripts/validate-starter-kit.rb`

## ownership

- `os/` owns identity, agent rules, routing, retrieval, recovery, templates, and reusable routines.
- `life/` owns current personal state, areas, projects, knowledge, and records.
- `biz/<business>/` owns that business's foundations, decisions, knowledge, status, and implementation source.
- `biz/business-model/` shows the first-business structure. During setup, rename it to the owner's first confirmed business before personalizing it.

Each intended repository uses private GitHub `origin` as primary and private
GitLab `backup` as an identical mirror. Publication goes to GitHub first, then
GitLab. The root and `biz/` never become repositories; `os/`, `life/`, and each
individual business are independently versioned.

## privacy boundary

This public source contains no owner's personal context. Never personalize the public checkout or commit credentials. The agent creates and personalizes a separate private vault.
