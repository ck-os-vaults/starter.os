---
type: map
created: 2026-08-11
updated: 2026-08-11
reviewed: 2026-08-11
status: living
authority: canon
source: ai
---

# retrieval

**Bottom line:** Agents find context through routing maps, descriptive filenames, top summaries, and honest freshness/authority metadata—not by scanning the vault or trusting the Obsidian graph.

**When to read this:** Read when finding, ranking, creating, auditing, linking, or resolving conflicts between durable notes.

## retrieval order

1. Start at `os/knowledge-map.md`, then the owning repository's `knowledge-map.md` or folder readme.
2. Narrow by descriptive filename.
3. Read candidate bottom lines and when-to-read triggers.
4. Check status, authority, source, and content dates.
5. Search full text only for what maps miss.
6. Load the smallest set that answers the task.

Wikilinks and the graph help humans navigate; they are not the agent's primary index.

## conflict ranking

1. The owner's current-session words win.
2. Never treat `superseded` or `archived` material as current; follow `superseded_by`.
3. Follow the owning repository's source hierarchy. Approved foundations/specs and current status outrank handoffs and transcripts.
4. `canon` and `spec` outrank `reference`, which outranks `exploratory`.
5. For build behavior, `spec` wins; for principles and owner intent, `canon` wins.
6. Break equal-authority ties with `updated`, falling back to `created`. `reviewed` is an audit date, not content freshness.
7. Prefer `source: owner` over `source: ai` for the owner's intent and decisions.

## metadata schema

Every active durable note uses YAML frontmatter:

```yaml
---
type: note            # note | map | identity | skill | spec | handoff | daily | weekly | monthly | journal | decision-log | history | status
created: YYYY-MM-DD
updated: YYYY-MM-DD    # meaning last changed; omit when unknown
reviewed: YYYY-MM-DD   # currency/metadata last checked
status: living         # living | draft | superseded | done | archived
authority: reference   # canon | spec | reference | exploratory
source: owner          # owner | ai
superseded_by: file.md # required only when superseded
domain: optional
applies_to: optional
related: optional
---
```

- `status` describes lifecycle/currency.
- `authority` describes how strongly the note guides work.
- `source` describes drafter provenance, not factual certainty.
- `updated` changes only when meaning changes.
- `reviewed` changes when currency or metadata is audited.

Never invent dates, approval, authority, or currency. When uncertain, use the safest value and flag it.

Use `type: map` for routing readmes. A reference document uses its structural type; `reference` belongs under authority. Agent-authored canon can coherently remain `source: ai` after owner approval.

## top summary

Durable knowledge, maps, identity, status, and decision files begin after the H1 with:

- **Bottom line:** the core claim or purpose in one to three lines.
- **When to read this:** the task or trigger that makes the file relevant.

Journal entries and simple templates may be exempt.

## records and archives

Archived bodies and permanent historical record bodies are immutable. Broken legacy links may remain inside those originating bodies as receipts, but active readmes and maps must resolve. Current maps never route through archived material as current truth.

Mark replaced files `superseded` with `superseded_by`; move inactive material to the owning archive. Never delete old truth merely because it is old.

## maintenance

- Update maps when files move or source ownership changes.
- Use `updated` for meaning changes and `reviewed` for audits.
- Run `metadata-audit` after bulk changes.
- Do not add a database or heavy retrieval layer until files, maps, search, and long context demonstrably fail at the vault's real scale.
