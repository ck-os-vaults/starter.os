---
type: skill
created: 2026-06-20
updated: 2026-08-11
reviewed: 2026-08-11
status: draft
authority: exploratory
source: ai
---

# end-of-day wrap

## purpose

Close work cleanly, preserve decisions/state, seed the next action, and checkpoint changed repositories.

## trigger

End of work block/day, or when the owner asks to wrap.

## steps

1. Summarize actual movement in plain language.
2. Route confirmed durable decisions through `decision-log.md` into the owning decision log.
3. List blockers and the next action.
4. Update current status/handoff files only when their instructions require it.
5. Identify each Git repository changed.
6. For each changed repo: validate, inspect scope, run the security sweep, and commit only completed in-scope work.
7. Under the approved standing workflow, push GitHub `origin` first, then GitLab `backup`.
8. Verify the intended local, `origin`, and `backup` refs match and the working tree is clean. Treat partial parity as a blocker.
9. Skip unchanged and read-only repos.

## outputs

- concise wrap
- optional daily/status/handoff update
- commit IDs and push state for changed repositories

## boundaries

- Do not fabricate progress or make empty commits.
- Do not stage unrelated changes.
- The vault root and `biz/` are never repositories; `os/`, `life/`, and each business remain independent.
- A current instruction not to commit/push always wins.
- Never describe GitHub and GitLab as synchronized without checking. Never use backup-first state to overwrite primary history.
