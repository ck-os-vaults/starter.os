---
type: skill
created: 2026-06-20
reviewed: 2026-06-20
status: draft
authority: exploratory
source: ai
---

# read-first code review

## purpose

Review code with high confidence by inspecting relevant files and definitions before making claims.

## trigger

Review, audit, bug hunt, security pass, or sanity check.

## steps

1. Confirm whether the review is read-only.
2. Read the requested scope fully when required.
3. Inspect local types, tests, routes, and protocol definitions.
4. Prioritize bugs, regressions, security risks, and missing tests.
5. Tie findings to inspected files/lines.
6. Separate findings from optional polish.

## boundaries

- Do not edit during a read-only review.
- Do not invent line references or protocol behavior.
- Do not present style preference as a bug.
