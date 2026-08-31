---
type: skill
created: 2026-08-14
updated: 2026-08-30
reviewed: 2026-08-30
status: living
authority: canon
source: ai
---

# Git sync preflight

## bottom line

Before substantive repository work, identify the declared primary and synchronize only through an unambiguous safe path. Fetch and stop whenever judgment is required.

## trigger

Once per relevant repository per session before its first substantive use. Run again only if repository state or the relevant repository set changes. Do not run on a timer or for conversation that does not depend on repository state.

## discover

For each repository separately:

1. Confirm the exact root, branch, worktree state, operation state, local commit, and untracked work.
2. Read `../recovery.md` and inspect remotes to identify the declared primary. Do not assume a remote name or provider makes it primary.
3. Redact credential-bearing URL parts.
4. Fetch only the primary with pruning.
5. Compare local branch and primary default branch by commit identity.

## safe automatic path

Fast-forward only when all are true:

- the working tree is clean;
- no Git operation is in progress;
- the checkout is the repository's declared default branch;
- local is strictly behind the matching primary branch;
- the update is an unambiguous fast-forward.

Fetch again and verify local and primary resolve to the same commit.

## stop conditions

Fetch and report without pulling, pushing, switching, stashing, merging, or rebasing when:

- the tree is dirty;
- unique untracked work lacks coverage;
- the checkout is not the declared default branch;
- a Git operation is in progress;
- local is ahead or divergent;
- histories or remote roles are unclear;
- the primary remote or credential is unavailable;
- a mirror unexpectedly appears ahead or divergent.

A secondary service is verification-only during normal work. Agents never push to it. After an approved push to the primary, verify every enabled automatic mirror reaches the same commit through its configured mechanism.

## local and cloud boundary

A cloud agent cannot verify a local checkout. A local agent cannot assume the cloud worktree or scheduler is current. After work in either location, report repository, branch, commit, changed paths, primary publication state, mirror state, and any pending synchronization.

Never use silent last-write-wins when the same durable file changed in two places.

## boundaries

- Never stash, reset, force-push, rewrite history, merge, rebase, switch branches, change remotes, configure mirrors, or discard work during preflight.
- Never publish merely because synchronization succeeded.
- If the owner says not to sync, that instruction wins.
