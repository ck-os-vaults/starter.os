---
type: map
created: 2026-06-19
updated: 2026-08-03
reviewed: 2026-08-03
status: living
authority: canon
source: ai
---

# vault map

**Bottom line:** Structural source of truth for the Life OS. The top-level lanes are stable; onboarding fills them with context and adds lower-level folders only when the owner's real work requires them.

**When to read this:** Read before creating, moving, routing, or structurally reorganizing files.

## four layers

1. **OS** — `os/`: identity, rules, current state, structure, retrieval, recovery, and repeatable routines. Small and stable.
2. **Notes** — current, curated context in `knowledge/`, `areas/`, `projects/`, `business/`, and `00_inbox/`.
3. **Log** — `log/`: dated, append-only record. Cold by default; never general startup material.
4. **Tools** — Obsidian, Codex, Claude, and future agents. Replaceable tools that read and write owner-controlled files.

## folder map

- `00_inbox/` — raw or unclear intake; a waiting room, never permanent storage.
- `os/` — permanent living operating and recovery layer.
- `setup/` — temporary onboarding package; archived as one folder after every completion gate passes.
- `knowledge/` — durable reference and people context.
- `areas/` — ongoing responsibilities without a finish line.
- `projects/` — time-bound personal outcomes.
- `business/` — businesses, clients, and optional independently versioned workspaces.
- `log/` — daily, weekly, monthly, personal journal, decisions, conversations, and session handoffs.
- `archive/` — inactive material kept for history but excluded from current truth.
- `agent/` — writing templates and agent-facing support.

## routing rules

Route each item to one primary home:

- durable concept or reference → `knowledge/topics/`
- person context → `knowledge/people/`
- business, client, or venture → `business/<name>/`
- time-bound personal outcome → `projects/<name>/`
- ongoing responsibility → `areas/<name>/`
- short operational day record → `log/daily/YYYY-MM-DD.md`
- owner-authored reflection → `log/journal/YYYY-MM-DD.md`
- weekly or monthly review → `log/weekly/` or `log/monthly/`
- confirmed durable decision → append to `log/decisions.md`
- verbatim owner conversation or transcript → `log/conversations/`
- agent handoff, saved prompt, or session record → `log/sessions/`
- repeatable agent routine → `os/skills/` and register in `os/skill-map.md`
- task-to-context routing → `knowledge-map.md` at the relevant root
- processed original worth preserving → a dated folder in `archive/`
- unclear or blocked → remain in `00_inbox/` with the blocker named

Projects finish; areas continue. Do not turn every interest, source, or imagined agent into a folder.

## record rules

- Current project status and curated knowledge outrank handoffs and transcripts.
- `log/decisions.md` is the one canonical record inside `log/`.
- Owner-authored journal and conversation records are permanent primary sources.
- Agent handoffs are supporting narrative and may be archived after they are replaced.
- Record files are not silently rewritten after the fact; mark lifecycle changes instead.

## naming and links

- Use descriptive lowercase kebab-case names.
- Daily and journal files: `YYYY-MM-DD.md`.
- Weekly: `YYYY-Www.md`; monthly: `YYYY-MM.md`.
- Conversation and session records: `YYYY-MM-DD-topic.md`.
- Wikilinks support human navigation. Agent retrieval uses maps, filenames, summaries, and freshness metadata from `os/retrieval.md`.

## metadata and authorship

The full frontmatter schema and ranking rules live only in `os/retrieval.md`.

Agent drafts remain `source: ai` until the owner approves them. Agents do not silently rewrite owner-authored meaning.

## environment and backup

Personalize during setup:

- local vault path and devices
- capture and sync choices
- GitHub and GitLab private repository URLs or names, never credentials
- local daily backup tool and destination description
- independently versioned nested repositories
- excluded local settings, attachments, media, exports, and credentials

Open the system as one Obsidian vault. Keep core meaning in ordinary Markdown, not in one app's hidden database.

The exact backup topology and restore procedure live in `os/recovery.md`.
