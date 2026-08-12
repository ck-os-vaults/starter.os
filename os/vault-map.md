---
type: map
created: 2026-08-11
updated: 2026-08-11
reviewed: 2026-08-11
status: living
authority: canon
source: ai
---

# vault map

**Bottom line:** One `<NAME>.os` root contains three top-level vaults: businesses in `biz/`, personal context in `life/`, and shared operating context in `os/`.

**When to read this:** Read before creating, moving, routing, renaming, archiving, or changing a repository boundary.

## visible structure

```text
STARTER.os/                example root; replace STARTER during setup
├── biz/                   business vaults; the container is not a repository
│   ├── business-model/    generic first-business model; renamed during setup
│   └── <business>/        one repository per confirmed real business
├── life/                  personal vault and repository
└── os/                    shared operating vault and repository
```

The vault root contains one `.obsidian/` configuration plus thin `AGENTS.md` and `CLAUDE.md` pointers. During onboarding only, it also contains temporary `setup/` material.

## repository boundaries

- `os/` owns shared identity, rules, maps, recovery, integrations, templates, and routines.
- `life/` owns personal knowledge, responsibilities, projects, current state, and records.
- `biz/<business>/` owns that business's documents, status, decisions, knowledge, applications, and source.
- `biz/business-model/` is the first-business starting structure. During setup, rename it to a confirmed `biz/<business>/` before adding owner context or Git.
- The root and `biz/` never own Git history.
- No repository contains another repository or submodule.

Create a business repository only when a real business needs independent current state, boundaries, decisions, or source. Do not create decorative placeholders.

## life map

- `life/00_inbox/` — raw or unclear capture waiting to be routed.
- `life/now.md` — last confirmed current personal state and currency gaps.
- `life/areas/` — ongoing responsibilities without a finish line.
- `life/areas/health/`, `life/areas/home/`, `life/areas/relationships/`, and `life/areas/finances/` — generic starter areas; not current owner claims.
- `life/projects/` — time-bound personal work outside a business.
- `life/knowledge/` — durable personal reference and people context.
- `life/records/` — daily, weekly, monthly, journal, conversations, sessions, and decisions.
- `life/archive/` — inactive personal material retained for history.

Journal, conversations, decisions, daily, weekly, and monthly records are permanent history. They are never startup material and never archive-eligible.

## routing rules

- unclear personal capture -> `life/00_inbox/`
- durable personal reference -> `life/knowledge/topics/`
- person context -> `life/knowledge/people/`
- ongoing personal responsibility -> `life/areas/<area>/`
- time-bound personal work -> `life/projects/<project>/`
- personal daily record -> `life/records/daily/YYYY-MM-DD.md`
- owner-authored reflection -> `life/records/journal/YYYY-MM-DD.md`
- durable personal decision -> append to `life/records/decisions.md`
- session continuity -> `life/records/sessions/`
- business material -> its owning `biz/<business>/`
- reusable shared routine -> `os/skills/` plus `os/skill-map.md`
- inactive material -> the owning repository's dated `archive/`

Raw media, exports, build output, dependency folders, credentials, and secret values do not belong in the vault's Git repositories.

## navigation and metadata

- `os/knowledge-map.md` routes to the owning repository.
- Each repository's `knowledge-map.md` routes only within that repository.
- `os/retrieval.md` owns metadata, ranking, conflict handling, and link rules.
- Wikilinks support navigation; they are not the authority index.
- Archived material never outranks current files.

New ordinary files use lowercase kebab-case. Dated records use `YYYY-MM-DD.md`. Every active note uses the frontmatter schema in `retrieval.md`; agent-drafted content remains `source: ai` until confirmed.

## environment and backups

Open only the vault root in Obsidian. `.obsidian/` remains at the root and is protected by full-vault backup, not Git.

Every repository uses GitHub `origin` as primary and GitLab `backup` as exact private mirror. The personalized repository and recovery map lives in `recovery.md`.
