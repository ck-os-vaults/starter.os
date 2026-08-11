---
type: map
created: 2026-06-19
updated: 2026-08-11
reviewed: 2026-08-11
status: living
authority: canon
source: ai
---

# retrieval

**Bottom line:** Agents find context through task maps, descriptive filenames, short top summaries, and lifecycle/authority metadata. They load the smallest useful set instead of reading the whole vault.

**When to read this:** Read when finding, ranking, creating, auditing, or resolving conflicts between durable notes.

## retrieval order

1. Start at the relevant `knowledge-map.md` or folder readme.
2. Narrow by descriptive filename.
3. Read each candidate's bottom line and when-to-read summary.
4. Check status, authority, source hierarchy, and content date.
5. Search full text only for what the maps miss.
6. Load the smallest set that can answer the task.

Obsidian links and the graph help humans browse; they are not the agent's primary index.

## conflict ranking

1. The owner's current words win.
2. Never treat `superseded` or `archived` material as current; follow `superseded_by`.
3. A current project status or specification outranks an older handoff or transcript.
4. `canon` and `spec` outrank `reference`, which outranks `exploratory`.
5. For build behavior, `spec` wins; for principles and owner intent, `canon` wins.
6. Break equal-authority ties with `updated`, falling back to `created`. `reviewed` is an audit date, not proof of fresh content.
7. Prefer `source: owner` over `source: ai` for facts about the owner's intent and decisions.

## metadata schema

Every active durable note uses YAML frontmatter:

```yaml
---
type: note            # note | map | identity | skill | spec | handoff | daily | weekly | monthly | journal | decision-log | status
created: YYYY-MM-DD
updated: YYYY-MM-DD    # content last changed; omit when unknown
reviewed: YYYY-MM-DD   # currency/metadata last checked
status: living         # living | draft | superseded | done | archived
authority: reference   # canon | spec | reference | exploratory
source: owner          # owner | ai (drafter provenance; ai may become canon after owner approval)
superseded_by: file.md # required only when status is superseded
domain: optional
applies_to: optional
related: optional
---
```

- **status** describes lifecycle and currency.
- **authority** describes how strongly the note should guide work.
- **source** describes authorship/approval, not factual certainty.
- **updated** changes when meaning changes.
- **reviewed** changes when someone audits currency or metadata.

Never invent dates, approval, or authority. When uncertain, use `draft`, `reference`, and `source: ai`.

Use `type: map` for routing readmes. Use `type: note` for ordinary reference and method documents; `reference` belongs under `authority`, and `method` is not a type. `source` records who drafted the words, while `authority` and `status` record approval and currency.

## top summary convention

Durable knowledge, maps, identity, status, and decision files begin after the H1 with:

- **Bottom line:** the core claim or purpose in one to three lines.
- **When to read this:** the task or trigger that makes the file relevant.

Personal journal entries are exempt so private reflection stays frictionless. Templates may also use their own instructional shape.

## task maps

A task map answers: “For this kind of work, which files should the agent read, and in what order?”

- Use one `knowledge-map.md` per substantial business, project, or area when needed.
- Group routes by real tasks, not abstract categories.
- Keep each route narrow—usually four files or fewer.
- Name current sources, optional context, and old or private material that should not load by default.

## maintenance

- Keep maps current when files move or sources are replaced.
- Use `updated` for meaning changes and `reviewed` for audits.
- Mark replaced files `superseded` and point to the successor.
- Run `os/skills/metadata-audit.md` after bulk changes.
- Never delete old truth merely because it is old; archive it outside current startup context.
