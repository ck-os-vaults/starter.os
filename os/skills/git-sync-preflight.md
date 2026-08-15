---
type: skill
created: 2026-08-14
updated: 2026-08-15
reviewed: 2026-08-15
status: living
authority: canon
source: ai
---

# git sync preflight

## bottom line

Before substantive local repository work, synchronize only the relevant repositories through the safe path: GitHub `origin` → clean local `main`. Repair unambiguous fast-forward gaps automatically; stop when judgment is required.

## trigger

Once per relevant repository per chat, before its first substantive local use. If another repository becomes relevant later, run preflight once for that repository before using it. Do not run on a timer or for read-only conversation that does not depend on repository state.

## steps

For each relevant repository separately:

1. Confirm the repository, branch, working tree, `origin`, and local commit.
2. Fetch `origin` with pruning.
3. If the tree is clean, the branch is `main`, and local `main` is strictly behind `origin/main`, fast-forward local from GitHub only.
4. Fetch again and verify local and GitHub resolve to the same commit.

## stop conditions

Fetch and report without pulling or pushing when the tree is dirty, the checkout is not `main`, a Git operation is in progress, local is ahead or divergent, or a required GitHub remote or credential is unavailable.

## cloud boundary

A hosted cloud chat cannot verify the owner's local checkout. After a cloud write, report the repository, branch, GitHub commit, and changed paths; label the local pull as pending.

## boundaries

- Never stash, reset, force-push, rewrite history, merge, rebase, switch branches, or discard work during preflight.
- If the owner says not to sync, that instruction wins.
