---
type: skill
created: 2026-06-20
updated: 2026-08-03
reviewed: 2026-08-03
status: living
authority: canon
source: ai
---

# system setup

## purpose

Turn an owner-confirmed context summary into a small, personalized, validated agent context system without redesigning the baseline structure by default.

## trigger

Run after the owner explicitly approves the interview blueprint, or approves a major redesign.

## inputs

- `setup/ONBOARDING-INTERVIEW.md`
- owner-confirmed context summary and corrections
- `os/now.md`
- `os/recovery.md`
- `os/retrieval.md`
- `os/vault-map.md`
- starter files and templates

## steps

1. Restate the approved scope and exact files/folders to change.
2. Update `os/me.md` with short stable identity and collaboration context.
3. Put changing priorities and constraints in `os/now.md`.
4. Put deeper approved context in `knowledge/people/owner.md` only when useful.
5. Preserve the baked-in agent rules unless the approved context explicitly changes them.
6. Personalize permissions, environment, capture, privacy, and repository boundaries where approved.
7. Use existing top-level lanes. Create lower-level folders only when a real routing need cannot fit without them.
8. Update root/local maps and readmes with task-based routes.
9. Activate only approved skills; leave uncertain routines draft.
10. Mark owner-approved content `source: owner`; keep unapproved drafts `source: ai`.
11. Run the validator and resolve every failure.
12. Explain what changed in everyday language and list remaining owner decisions.

## boundaries

- Do not build before the owner confirms the context summary is accurate.
- Do not invent personal facts, routines, projects, or privacy preferences.
- Do not copy another person's identity, businesses, journal, or knowledge.
- Do not weaken the default response style, truthfulness, scope-control, edit-boundary, or privacy rules unless the owner approved the exact change.
- Do not create folders merely to make the system look complete.
- Do not create online repositories or push until the separate setup-runbook phase is approved.
