---
type: note
created: 2026-08-11
updated: 2026-08-11
reviewed: 2026-08-11
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
- GitLab `backup` is the exact private mirror, updated only after GitHub succeeds.
- A full-vault backup protects `.obsidian/`, ignored attachments, and other safe files Git intentionally excludes.

Passwords, codes, and secret keys belong in the password manager or provider—not the vault.

## how weekly maintenance works

Setup creates one scheduled weekly maintenance task. Before it cleans anything,
the agent validates every repository, saves completed work to GitHub, mirrors it
to GitLab, and confirms both copies match.

It then checks current facts, old instructions, unfinished documents, metadata,
maps, and links. Clearly inactive material moves into a dated archive with a
manifest showing where it came from and what replaced it. Unclear material stays
active with a visible review note. The agent validates and saves everything
again before reporting completion.

## what success looks like

- You can talk naturally and capture without organizing first.
- The agent finds current context without scanning everything.
- Current foundations and status outrank old notes.
- Personal and business histories remain cleanly separated.
- Another agent can continue without a giant chat recap.
- A tested recovery can rebuild the system.

The goal is dependable context with less effort, not a perfect library.
