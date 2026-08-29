---
type: map
created: 2026-08-29
updated: 2026-08-29
reviewed: 2026-08-29
status: living
authority: canon
source: ai
---

# skill map

Portable workflows live in `os/skills/` so they survive changes in model or agent product. Agent-specific packages are thin adapters and must not become a second canonical skill vault.

| Skill | Trigger |
|---|---|
| [[git-sync-preflight]] | before substantive local repository work |
| [[daily-brief]] | start-of-day or priority planning |
| [[eod-wrap]] | owner asks to wrap or project rules require it |
| [[decision-log]] | owner confirms a durable decision |
| [[distill]] | promote durable signal from accumulated records |
| [[project-handoff]] | temporary continuity is genuinely needed |
| [[task-reconciliation]] | material context spans multiple project tasks |
| [[metadata-audit]] | routing or metadata repeatedly drifts |
| [[drift-recovery]] | overwhelm or restart pressure is causing drift |
| [[security-sweep]] | sensitive, public, unknown-origin, or risk-bearing work |
| [[vault-maintenance]] | owner-approved structural or routing cleanup |
| [[browser-use]] | interactive website work |
| [[evidence-research]] | external source-grounded research |
| [[independent-review]] | consequential work benefits from genuine dissent |

## Creation contract

When the owner creates or materially updates a reusable skill:

1. Create or update its canonical portable workflow in `os/skills/` and register it above.
2. Add a harness adapter only when native discovery or tooling requires one.
3. Keep credentials, tools, and harness mechanics in the adapter; keep durable workflow intent here.
4. Validate the workflow and any adapter before calling the skill complete.

Project-specific workflows remain with their project and do not enter this registry unless repeated use proves they are broadly reusable.
