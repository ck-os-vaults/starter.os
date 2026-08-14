---
type: skill
created: 2026-06-20
updated: 2026-08-14
reviewed: 2026-08-14
status: draft
authority: exploratory
source: ai
---

# project handoff

## purpose

Preserve continuity when work pauses, context grows long, or another agent must resume.

## trigger

The owner asks for a handoff, or an explicitly triggered [[eod-wrap]] requires one because authorized work is stopping midstream.

## steps

1. Confirm the handoff is requested or required by the active wrap. Otherwise ask once before writing it.
2. State the goal and current state.
3. Separate completed and incomplete work.
4. List changed/key files and validation results.
5. Record owner decisions and rationale.
6. Name blockers and the exact next action.
7. Reference sensitive context rather than copying it broadly.
8. Save a personal handoff as `life/records/sessions/YYYY-MM-DD-topic.md`; a business may own a local handoff when its repository contract says so.

## boundaries

- Update real project files first; handoffs are not alternate sources of truth.
- Do not mark unfinished work complete.
- Current status/specs outrank old handoffs.
- Verbatim owner transcripts belong in `life/records/conversations/`, not in an agent handoff.
