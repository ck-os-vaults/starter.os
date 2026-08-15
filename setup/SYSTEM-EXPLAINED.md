---
type: note
created: 2026-08-11
updated: 2026-08-15
reviewed: 2026-08-15
status: living
authority: reference
source: ai
---

# how the system works

**For: New User**

**Bottom line:** Your system is one private folder of readable files. Agents use a few maps to find the right context, while separate repositories keep shared rules, personal life, and businesses from overwriting one another.

**When to read this:** Read when you want the plain-English model of the finished system.

## the three parts

1. **os:** who you are, how agents should work, where information belongs, and how the system recovers.
2. **life:** current personal state, responsibilities, projects, knowledge, and records.
3. **biz:** one separate workspace for each real business, including its own status, decisions, knowledge, rules, and source.

Obsidian opens all three as one vault. Agents begin with small routing files and load only what a task needs.

## why repositories are separate

A repository is a versioned history. Separate histories keep personal material out of business commits and prevent one business change from touching everything else.

The vault root and `biz/` are simple containers. `os/`, `life/`, and each business own their own histories.

## how information moves

1. Capture uncertain personal material in `life/00_inbox/`.
2. Route it to one clear owner.
3. Mark whether it is current, draft, replaced, completed, or archived.
4. Add durable sources to a small map when agents will need them again.
5. Preserve old material without letting it override current truth.

## how backups work

- GitHub `origin` is the primary version history for each repository.
- GitLab is the exact private downstream mirror, updated automatically by GitHub Actions after GitHub changes.
- A full-vault backup protects `.obsidian/`, ignored attachments, and other safe files Git intentionally excludes.

Passwords, codes, and secret keys belong in the password manager or provider—not the vault.

## how everyday synchronization works

At the start of substantive local repository work, the agent checks only the
relevant repositories and safely brings a clean local `main` forward from
GitHub. At closeout, completed changes are validated, committed, and pushed only
to GitHub. GitHub Actions updates GitLab automatically, and agents verify that
workflow instead of pushing GitLab directly.

Hosted cloud work can update GitHub but cannot prove that a local checkout is
current. It reports the local pull as pending for the next local session.

Vault maintenance checks current facts, routes, metadata, and archive
candidates. It runs on request or on an optional owner-approved schedule; the
system does not require constant background polling.

## what success looks like

- You can talk naturally and capture without organizing first.
- The agent finds current context without scanning everything.
- Current foundations and status outrank old notes.
- Personal and business histories remain cleanly separated.
- Another agent can continue without a giant chat recap.
- A tested recovery can rebuild the system.

The goal is dependable context with less effort, not a perfect library.
