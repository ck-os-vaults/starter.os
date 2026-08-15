---
type: skill
created: 2026-06-20
updated: 2026-08-15
reviewed: 2026-08-15
status: draft
authority: exploratory
source: ai
---

# eod wrap

## bottom line

Close work in one of two modes: ordinary repository closeout after meaningful file changes, or a full personal/project wrap when the owner asks or project rules require it.

## purpose

Repository closeout validates and synchronizes changed repositories. A full wrap also preserves useful continuity and the next starting point.

## trigger

- **Repository closeout:** meaningful file-changing work is complete.
- **Full wrap:** the owner asks to wrap, or the owning project expressly requires it.

## steps

### repository closeout

1. Inspect each affected repository separately: branch, tree, diff, and intended scope.
2. Run the owning validator. Run [[security-sweep]] only for risk-bearing changes.
3. Commit only intended completed work when the standing publication workflow is approved.
4. Follow the Git publication law in `os/agent-rules.md`.

### full wrap

1. Summarize what moved and what remains unresolved.
2. Record only confirmed decisions the active wrap is authorized to log.
3. Set at most three next priorities, each with an obvious first action, and append a short daily record only when worth preserving.
4. Update status only when project instructions require it. Create a handoff only when authorized midstream continuity is needed.
5. Run repository closeout for every changed repository.

## outputs

- Repository closeout: validation, commit, changed files, and publication status.
- Full wrap: concise record, next priorities, required status or handoff updates, and repository closeout.

## boundaries

- Do not fabricate progress or make empty commits.
- Do not stage unrelated changes.
- Do not create planning, decision, handoff, or status records during routine repository closeout.
- The vault root and `biz/` are never repositories; `os/`, `life/`, and each business remain independent.
- A current instruction not to commit/push always wins.
