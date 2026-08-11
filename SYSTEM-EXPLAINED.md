---
type: note
created: 2026-06-20
updated: 2026-08-11
reviewed: 2026-08-11
status: living
authority: reference
source: ai
---

# how the system works

**Audience:** Owner
**Lifecycle:** Permanent

**Bottom line:** Starter.OS becomes your private agent context machine: ordinary documents that help different AI agents understand you and your work without depending on one app, one company, or one giant chat history.

**When to read this:** Read before setup when you want the whole idea in simple terms.

## the basic idea

Most AI conversations forget important context. This system stores that context in ordinary files you control.

When an agent starts working, it does not read every note. It follows a few small maps that tell it:

- who you are and how you like to work
- which rules matter
- where the current information lives
- which old information should not be treated as current

Think of it as a labeled filing cabinet, a table of contents, and a short instruction manual for your collaborator.

You are not expected to organize everything yourself. You can talk naturally, put uncertain material in the inbox, and let the agent follow the maps.

## how information moves

1. **Capture:** Put a thought in the inbox when you do not know where it belongs.
2. **Place:** Move useful information to one clear permanent home.
3. **Label:** Mark whether it is current, unfinished, replaced, completed, or historical.
4. **Route:** Add important files to a small map so agents can find them quickly.
5. **Review:** Check occasionally that the file is still true.
6. **Archive:** Keep old material for history without letting it override current truth.

## why the small labels matter

The labels at the top of a note prevent common AI mistakes.

- `status` says whether the note is still active.
- `authority` says whether it is a rule, reference, or idea.
- `source` says whether you approved it or an agent drafted it.
- `updated` says when the information itself changed.
- `reviewed` says when someone last checked it.

This means an old brainstorm cannot quietly outrank a newer decision.

## why there are maps instead of hundreds of tags

Tags can describe a note, but they do not always tell an agent which note to trust or read first. A map gives direct instructions for a real task.

For example: when preparing a weekly review, read these two or three files in this order.

The system uses only enough labels to identify truth and freshness. More tags can be added later when they solve a repeated search problem. They are not added just because more organization feels safer.

## what the agent does

The agent acts like a librarian and collaborator. It can:

- find the right context before answering
- help organize new information
- draft plans, notes, reviews, and decisions
- warn when two files disagree
- test links, labels, and folder indexes
- leave a clear handoff for the next agent

The owner still approves identity, important rules, real-world actions, publishing, and other meaningful commitments.

## why the AI tool can change

Claude, Codex, or another file-capable agent can follow the same instructions because the memory lives in Markdown files, not inside one model's private chat history.

The agent is replaceable. Your files are the lasting system.

## why current context and history are separate

Current status, decisions, and curated knowledge should guide today's work. Old conversations and session records still matter, but they should not silently override newer truth.

The `log/` folder preserves dated records, confirmed decisions, your own reflections, original conversations, and agent handoffs. Agents load only the relevant part when history matters.

## what the three backups add

Git records changes over time. If something is edited incorrectly, an earlier version can be restored.

- GitHub holds one private online history.
- GitLab holds a matching private online history with a different provider.
- A daily local backup such as Carbon Copy Cloner protects the whole vault folder, including safe files intentionally excluded from Git.

Two-factor authentication protects both online accounts. Passwords and recovery codes never belong in the vault.

## what success looks like

The system is working when:

- you can capture something without stopping to organize it
- an agent finds the right information without scanning everything
- current decisions outrank old notes
- another agent can continue without a long explanation from you
- the structure stays small enough that you understand it
- the two private online histories match and the local backup can open a real file

The goal is not a perfect library. The goal is dependable memory with less effort.
