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
| [[metadata-audit]] | routing or metadata repeatedly drifts |
| [[security-sweep]] | sensitive, public, unknown-origin, or risk-bearing work |
| [[vault-maintenance]] | owner-approved structural or routing cleanup |
| [[browser-use]] | interactive website work; native browser first |

## Creation contract

When the owner creates or materially updates a reusable skill:

1. Create or update the canonical portable workflow in `os/skills/`. A skill that exists only inside an agent product, local cache, plugin, or profile is incomplete.
2. Register the workflow above in the same change. The file and registry must always agree.
3. Add a harness adapter only when native discovery or tooling requires one. Keep credentials and harness mechanics there; keep durable workflow intent in `os/skills/`.
4. Do not add a shared skill that assumes an unavailable model, browser, API, connector, credential, or application. Either document and validate the required integration during setup or keep that workflow outside the starter skill vault.
5. Run `ruby os/validate-starter-os.rb` and validate any adapter before calling the skill complete.

Project-specific workflows remain with their project and do not enter this registry unless repeated use proves they are broadly reusable.

## Maintenance contract

Review the skill vault during quarterly vault maintenance and after a major agent, model, tool, or repository migration. The audit must:

1. Confirm every file in `os/skills/` is registered and every registered skill exists.
2. Confirm each skill remains useful, current, model-agnostic, and executable with the owner's actual local capabilities.
3. Update instructions, lifecycle dates, maps, and adapters together when behavior changes.
4. Flag obsolete, duplicate, unclear, or unavailable-tool workflows for owner approval before removal.
5. Run validation and report what was kept, updated, removed, or left unresolved.

Do not create a scheduled automation merely to satisfy this review cadence; include it in the owner's existing maintenance rhythm unless they explicitly want automation.
