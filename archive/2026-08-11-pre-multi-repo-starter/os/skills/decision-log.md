---
type: skill
created: 2026-08-03
reviewed: 2026-08-03
status: draft
authority: exploratory
source: ai
---

# decision log

## purpose

Preserve a durable owner-confirmed choice and its reason so future sessions build on it instead of reopening it without new evidence.

## trigger

The owner makes or explicitly confirms a choice that should still guide work later.

## steps

1. Confirm it is a decision, not exploration, mood, or an agent recommendation.
2. Choose one decision log: the local project's decision file when it has one, otherwise `log/decisions.md`.
3. Match the existing format and append a dated entry with Decision, Why, and an optional Revisit condition.
4. Name what it supersedes when relevant.
5. List downstream files the decision may require; do not silently expand scope.
6. Tell the owner exactly what was recorded.

## boundaries

- Never log an unconfirmed agent opinion as the owner's decision.
- Decision records are append-only; newer entries supersede older ones.
- Summarize sensitive details and reference their private source.
