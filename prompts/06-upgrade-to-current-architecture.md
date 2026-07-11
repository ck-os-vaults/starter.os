---
type: note
created: 2026-07-11
reviewed: 2026-07-11
status: living
authority: canon
source: ai
---

# prompt 6 — upgrade to the current architecture

**Bottom line:** Brings a vault built from the starter up to the current life.os architecture: a unified `log/` record layer, layered personal context, a deduplicated OS with a lean trigger-based startup chain, a backup recovery runbook, and five newer skills — migrated in approval-gated phases that never delete anything.

**When to read this:** Use after initial setup (prompts 1–4) and some real use, when the vault owner wants the improvements made to the source system since this starter was cut. Paste the block below into Claude (or any agent) inside the vault.

```text
Upgrade this vault to the current life.os architecture. This vault was built
from a starter snapshot, and the source system has evolved since. You cannot
see the source repo: this prompt is the complete specification of the target
state. Migrate my STRUCTURE toward the spec; all content stays mine and gets
adapted, never replaced.

Ground rules for the entire migration:
- Work in phases, in order. Before each phase, show a short plan of the exact
  file changes and wait for my approval.
- Never delete anything. Replaced or inactive material moves to a dated folder
  in archive/; replaced files that stay in place get frontmatter
  status: superseded plus superseded_by pointing at their successor.
- One git commit per phase, so each phase can be reverted independently. Run
  os/validate-life-os.rb before every commit, and update that validator in the
  same phase whenever structure or schema changes — the validator and the
  vault must never disagree.
- Never silently rewrite text I authored (source: owner). My words survive
  every move; only location and metadata may change without approval.
- Where this spec says something personal is "built from the owner," build my
  version from my content and my answers — import nothing about anyone else.

PHASE 0 — ORIENT AND INTERVIEW
Read os/me.md and follow its startup instructions, plus os/retrieval.md.
Then ask me, in one batch:
1. Do I write (or want to write) personal reflective journal entries, as
   distinct from the agent-written daily records?
2. Do I have transcripts or interview material worth keeping verbatim as a
   long-term personal corpus?
3. What is my real backup situation today (cloud sync, external drive,
   private GitHub, nothing)?
4. Are any independently versioned repos nested inside this vault?
5. Since onboarding, where has personal information about me accumulated,
   and is os/me.md still accurate?
Use the answers to tailor everything below. If a phase clearly does not apply
to me, say so and propose skipping it.

PHASE 1 — THE RECORD LAYER: journal/ BECOMES log/
Target: one top-level log/ layer holding the chronological record — raw,
append-only, never startup material.
- log/daily/, log/weekly/, log/monthly/ — agent-written records of what
  happened (move the existing journal/ streams here with git mv).
- log/decisions.md — the decision log (move journal/decisions.md).
- log/journal/ — MY reflective writing, verbatim, kept forever. Create only if
  I said yes in Phase 0, and add a `journal` entry to the frontmatter type
  vocabulary in os/retrieval.md and the validator.
- log/conversations/ — verbatim transcripts of me, the forever corpus
  (create only if applicable).
- log/sessions/ — session handoffs and saved prompts, named
  YYYY-MM-DD-topic.md. This is the only prune-able stream in log/.
- Dissolve os/history/: route each file to log/sessions/ or archive/ by what
  it actually is. Afterwards os/ holds only the living operating layer.
Write a short log/readme.md with the layer's rules: append-only; record files
are never rewritten after the fact — only frontmatter markings change
(status, superseded_by, reviewed); sessions/ alone may be pruned. Update
vault-map.md, routing rules, templates, and knowledge-map.md from journal/ to
log/. Update the validator. Commit.

PHASE 2 — PERSONAL CONTEXT IN LAYERS
Target: identity is layered so sessions load only what they need.
- os/me.md stays the short portable identity: who I am, how to work with me,
  operating principles, boundaries. Nothing that changes weekly.
- os/now.md (new, type: status): my current state — at most 3 active
  priorities; open decisions, each with the named condition that will resolve
  it; key constraints I choose to track; upcoming calendar anchors. Kept
  current by eod-wrap and weekly-review; read for planning and check-ins.
  Draft it by interviewing me briefly; I approve it before it is saved.
- knowledge/people/owner.md stays the deeper dossier, loaded on demand only.
  If Phase 0 found personal information scattered elsewhere, consolidate it
  here (or into now.md if it is current-state), with my approval.
- Optional — only if I have real interview material and want it: an os/
  playbook file of behavioral protocols (how the agent should respond to my
  recurring states and patterns), distilled from my own words, approved by me
  line by line, and held as guidelines I can revise — not laws. Skip entirely
  if I do not want it.
Commit.

PHASE 3 — THE LEAN OS: EVERY RULE GETS EXACTLY ONE HOME
The core optimization. Principle: state each instruction exactly once; other
files point, never copy. Audit every os/*.md for duplicated rules and
consolidate to these homes:
- os/me.md — identity and my personal preferences only.
- os/agent-rules.md — behavior, truthfulness, work style, response style,
  edit boundaries, file rules.
- os/vault-map.md — structure, routing, and conventions only.
- os/retrieval.md — the single retrieval standard: the index, retrieval
  steps, conflict ranking, the full frontmatter schema, and the TL;DR
  convention. The schema appears ONLY here; vault-map points to it.
Replace any accumulated brevity rules with one concrete response-style rule
in agent-rules.md: "Lead with the conclusion, the risk, or the next action.
Keep necessary evidence, material caveats, decisions, and next actions; trim
introductions, repetition, reassurance, and optional background first.
Expand only when the task needs it or I ask."
Then replace os/me.md § startup with this boot chain, defined once, there:
  Always read once:
  - os/agent-rules.md — working rules, edit boundaries, and response style.
  - os/skill-map.md — trigger table for repeatable routines.
  For substantial project work, read the relevant current status file first.
  Load a matching living handoff from log/sessions/ only when it adds useful
  continuity — status is current truth; handoffs are supporting narrative.
  Then state the working context in at most 3 bullets and name the next
  action before doing anything substantive.
  Read on trigger, not by default:
  - os/vault-map.md — before creating, moving, routing, or structurally
    reorganizing files.
  - os/retrieval.md — for knowledge retrieval, ranking, or metadata
    decisions.
  - os/now.md (plus the playbook, if it exists) — for life planning,
    priority setting, personal reviews, check-ins, or when my state
    materially matters; not for technical or repository reviews.
Supersede os/skills/agent-startup.md (status: superseded, superseded_by:
../me.md) — the boot chain replaces it — and de-register it from skill-map.
Slim skill-map.md to the trigger table plus a few framing lines; it stays
always-loaded, because behavior-triggered skills can only fire if their
trigger table is already in context. Commit.

PHASE 4 — RECOVERY RUNBOOK
Create os/recovery.md from my Phase 0 backup answers: what copies exist,
step-by-step how to rebuild this vault from zero on a new machine, what git
will NOT restore (gitignored files), and a periodic backup-health checklist
ending with "test a real restore once a year — an untested backup is a
hypothesis." If my backups do not satisfy 3-2-1 (multiple copies, more than
one medium, one offsite), say so plainly and recommend the smallest fix — but
write the runbook for what exists today. Credentials never appear in the
vault: the runbook names where they live (password manager), never values.
Commit.

PHASE 5 — NEW SKILLS
Draft these five as os/skills/ files (status: draft, matching the existing
skill body format) and register each in skill-map with trigger and output:
- decision-log — trigger: I make or confirm a durable decision → a dated
  entry (decision, why, optional revisit) appended to log/decisions.md.
  Updates only for decisions I actually made or confirmed.
- drift-recovery — trigger: overwhelm produces a restart-everything urge →
  recenter on the existing plan and one next action. The existing plan wins
  by default until a change is defended calmly, outside the overwhelm.
- distill — trigger: monthly, on the first weekly review of the month →
  harvest durable signal from log/ since the last run into the curated files
  (me.md, now.md, the dossier, knowledge/), at most ~5 promotions per run,
  each linking back to its source entries; prune stale sessions/ exhaust
  only, nothing else.
- vault-maintenance — trigger: monthly → validator, metadata freshness, link
  integrity, structure-vs-map agreement, readme currency, archive sweep,
  backup health. It carries the archive safety contract: never delete, only
  move to dated archive/ folders (git-reversible); a hard firewall around
  the corpus and identity (all log/ record streams, log/decisions.md,
  knowledge/people/, all of os/) — never archive-eligible; everything else
  must be superseded-or-done AND older than 90 days AND unreferenced before
  a move is even proposed; auto-fix only reversible metadata, propose all
  moves for my approval.
- security-sweep — trigger: before any commit containing unreviewed or
  imported material, and before anything public → check the diff for
  secrets, private-data leaks, and scope creep.
Commit.

PHASE 6 — VERIFY AND CLOSE
Run a metadata audit across every changed file and run the validator. Do a
before/after inventory of the os/ rules proving each old rule survived to
exactly one home. Record the migration as one entry in log/decisions.md
(decision, why, and per-phase rollback: which commit to revert for which
symptom). Then give me a plain-language summary: what moved, what is new,
and what to watch during a one-week trial — the failure mode to watch is a
session that creates or misroutes a file without having loaded vault-map;
if that happens, revert only the Phase 3 commit. Final commit and push.
```
