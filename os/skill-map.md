---
type: map
created: 2026-08-29
updated: 2026-08-30
reviewed: 2026-08-30
status: living
authority: canon
source: ai
---

# skill map

**Bottom line:** Starter.OS ships useful portable methods, but a skill runs only when its trigger is real and a schedule exists only after the owner accepts it.

**When to read this:** Read when choosing, adding, updating, scheduling, or auditing a reusable workflow.

## Public skill audit

| Skill | Product role | Trigger | Scheduled recipe |
|---|---|---|---|
| [[git-sync-preflight]] | core portable | before substantive repository work | no |
| [[decision-log]] | core portable | owner confirms a durable decision | no |
| [[security-intake]] | core portable | before a newly sourced artifact is opened or run | no |
| [[security-sweep]] | core portable plus optional scheduled routine | sensitive or public work, explicit security review, or accepted nightly check | Nightly System Security Check |
| [[vault-maintenance]] | core portable | owner-approved structural or routing cleanup | no |
| [[drift-recovery]] | core portable | sources, copies, or routes conflict or drift | no |
| [[distill]] | optional portable | accumulated records contain durable signal worth promoting | no |
| [[metadata-audit]] | optional portable | routing or lifecycle metadata repeatedly drifts | no |
| [[browser-use]] | optional portable | interactive website work | no |
| [[daily-brief]] | optional scheduled routine | start-of-day or priority planning | optional owner-defined |
| [[eod-wrap]] | optional scheduled routine | owner asks to wrap or adopts an end-of-day routine | optional owner-defined |
| [[task-reconciliation]] | optional scheduled routine | cross-project checkpoint or accepted nightly routine | Nightly Chief Reconciliation |

## Adapter and exclusion audit

- **Harness-specific adapters:** root and repository `CLAUDE.md` files are thin pointers. Scheduler-specific or agent-specific adapters may exist outside the portable skill folder and must point back here.
- **CK-only or private:** none are shipped. Private methods stay outside the public repository.
- **Incomplete or unsupported:** none are shipped. A candidate remains outside the release until its trigger, boundaries, dependencies, and validation are clear.

A file appearing in this map does not authorize execution, installation, connection, or scheduling.

## Creation contract

When a broadly reusable workflow is added or materially changed:

1. Keep the canonical intent in `os/skills/`.
2. Register it here with exactly one product role and a real trigger.
3. Keep project-specific or owner-specific methods with their owner.
4. Add a harness adapter only when discovery or tooling needs it.
5. Declare external tools, data exposure, permissions, cost, and a free or already-owned alternative.
6. Keep scheduled use opt-in and give it a clear destination and retirement path.
7. Run `ruby os/validate-starter-os.rb` and validate any adapter.

## Maintenance contract

Audit after a major agent, model, tool, repository, or product update:

1. Every skill file is registered and every registration resolves.
2. Every role and trigger still matches the real workflow.
3. Core skills remain model- and agent-agnostic.
4. Optional integrations remain optional and truthfully available.
5. Scheduled routines have explicit owner acceptance and no duplicates.
6. Stale, private, unsupported, or provider-bound material is removed from the public release or reclassified after approval.
7. Instructions, lifecycle dates, maps, adapters, and validation change together.

Do not create an automation merely because a recipe exists.
