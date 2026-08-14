---
type: skill
created: 2026-08-14
updated: 2026-08-14
reviewed: 2026-08-14
status: living
authority: canon
source: ai
---

# git sync preflight

## bottom line

Before substantive local repository work, synchronize only the relevant repositories through the safe path: GitHub `origin` → clean local `main` → GitLab `backup`. Repair unambiguous fast-forward gaps automatically; stop when judgment is required.

## trigger

Once per relevant repository per chat, before its first substantive local use. If another repository becomes relevant later, run preflight once for that repository before using it. Do not run on a timer or for read-only conversation that does not depend on repository state.

## steps

For each relevant repository separately:

1. Confirm the repository, branch, working tree, remotes, and local commit.
2. Fetch `origin` and `backup` with pruning.
3. If the tree is clean, the branch is `main`, and local `main` is strictly behind `origin/main`, fast-forward local from GitHub only.
4. Once local equals `origin/main`, mirror `main` to `backup` only when GitLab is strictly behind and safely fast-forwardable.
5. Fetch again and verify local, GitHub, and GitLab resolve to the same commit.

## stop conditions

Fetch and report without pulling or pushing when the tree is dirty, the checkout is not `main`, a Git operation is in progress, local is ahead or divergent, GitLab is ahead or divergent, or a required remote or credential is unavailable.

## cloud boundary

A hosted cloud chat cannot verify the owner's local checkout or GitLab mirror. After a cloud write, report the repository, branch, GitHub commit, and changed paths; label local pull and GitLab parity as pending.

## boundaries

- GitHub remains primary; never use GitLab-first state to overwrite it.
- Never stash, reset, force-push, rewrite history, merge, rebase, switch branches, or discard work during preflight.
- If the owner says not to sync, that instruction wins.
