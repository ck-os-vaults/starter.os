---
type: map
created: 2026-06-19
updated: 2026-08-03
reviewed: 2026-08-03
status: living
authority: reference
source: ai
---

# log

**Bottom line:** The chronological record layer: dated operational notes, durable decisions, owner-authored reflection, verbatim conversations, and agent session handoffs. It records what happened without becoming general startup context.

**When to read this:** Read when reconstructing events, checking a confirmed decision, recovering session continuity, or working from the owner's original words.

## streams

- `daily/` — short operational day records.
- `weekly/` — weekly resets and carry-forwards.
- `monthly/` — monthly retrospectives.
- `journal/` — the owner's personal reflection in their own words.
- `decisions.md` — confirmed durable decisions and reasons; the canonical record inside `log/`.
- `conversations/` — verbatim owner transcripts and source conversations.
- `sessions/` — agent handoffs, saved prompts, and operational session records.

## rules

- Cold by default: do not load the whole log at startup.
- Current status files and curated knowledge outrank handoffs and transcripts.
- Journal and conversation records preserve the owner's words; agents do not rewrite them in place.
- Session handoffs are supporting narrative and may be archived after they are replaced.
- Date-prefixed filenames make the record searchable without manually indexing every entry.

## maintenance stamps

- Distilled through: not yet run
- Maintained through: not yet run
