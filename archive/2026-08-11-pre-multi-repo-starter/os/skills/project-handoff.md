---
type: skill
created: 2026-06-20
updated: 2026-08-03
reviewed: 2026-08-03
status: draft
authority: exploratory
source: ai
---

# project handoff

## purpose

Preserve continuity when work pauses, context grows long, or another agent must resume.

## trigger

Stopping midstream, meaningful session end, context loss risk, or owner request.

## steps

1. State the goal and current state.
2. Separate completed and incomplete work.
3. List changed/key files and validation results.
4. Record owner decisions and rationale.
5. Name blockers and the exact next action.
6. Reference sensitive context rather than copying it broadly.
7. Save the handoff as `log/sessions/YYYY-MM-DD-topic.md` unless the project has an approved local handoff location.

## boundaries

- Update real project files first; handoffs are not alternate sources of truth.
- Do not mark unfinished work complete.
- Current status/specs outrank old handoffs.
- Verbatim owner transcripts belong in `log/conversations/`, not in an agent handoff.
