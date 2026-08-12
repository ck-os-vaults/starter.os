---
type: map
created: 2026-08-11
updated: 2026-08-11
reviewed: 2026-08-11
status: living
authority: canon
source: ai
---

# life

**Bottom line:** The owner's private personal repository: current life context, responsibilities, personal projects, durable knowledge, and historical record. Businesses and shared agent rules live elsewhere.

**When to read this:** Read for personal orientation; use `knowledge-map.md` for task routing and `../os/vault-map.md` for placement rules.

## structure

- `00_inbox/` — raw capture waiting to be routed.
- `now.md` — last confirmed personal state and explicit currency gaps.
- `areas/` — ongoing personal responsibilities.
- `projects/` — time-bound personal work outside a business.
- `knowledge/` — durable people and topic context.
- `records/` — daily, weekly, monthly, journal, conversations, sessions, and decisions.
- `archive/` — inactive personal material retained for history.

Agents enter through `AGENTS.md`, inherit shared rules from `../os/`, and load only the personal context a task needs.

## version control

This folder is one private repository. GitHub `origin` is primary; GitLab `backup` is its exact private ref mirror. Businesses are never committed here.

`.obsidian/`, application state, credentials, and raw generated artifacts remain outside this repository. Ignored safe attachments are protected by the full-vault backups described in `../os/recovery.md`.
