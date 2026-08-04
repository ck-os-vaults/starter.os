---
type: map
created: 2026-06-19
updated: 2026-08-03
reviewed: 2026-08-03
status: draft
authority: canon
source: ai
---

# knowledge map

**Audience:** Agents
**Lifecycle:** Permanent

**Bottom line:** Root task-to-context router. Core system routes are ready; personal, business, project, and area routes are added only from the owner's confirmed context and real recurring work.

**When to read this:** Read when a task needs context and the correct current source is not already obvious.

## core routes

### first setup

Read `setup/README.md` → `setup/FIRST-CHAT.md` → `setup/SETUP-STATUS.md` → `setup/AGENT-RUNBOOK.md`.

### post-setup learning

Read `setup/POST-SETUP-TUTORIAL.md`, then `os/me.md` and `os/now.md` to personalize the exercises.

After the tutorial and first real task, Phase 8 of `setup/AGENT-RUNBOOK.md` removes both setup routes, archives the entire `setup/` folder, and preserves one completion record in `log/`.

### owner orientation or collaboration

Read `os/me.md` and `os/agent-rules.md`. Add `os/now.md` only for planning, priorities, or check-ins. Load `knowledge/people/owner.md` only when deeper context materially helps.

### structure, retrieval, or metadata

Structure: `os/vault-map.md`. Retrieval and metadata: `os/retrieval.md`. Audit: `os/skills/metadata-audit.md`.

### security, backup, or recovery

Read `os/recovery.md` → `os/agent-rules.md` → `os/skills/security-sweep.md`. During initial setup, also read `setup/AGENT-RUNBOOK.md`.

### inbox

Start at `00_inbox/readme.md`, then use `os/skills/inbox-triage.md`.

### durable knowledge

Start at `knowledge/readme.md`. Use `knowledge/people/owner.md` only for relevant deeper owner context.

### projects, areas, or business

Personal projects: `projects/readme.md`. Ongoing responsibilities: `areas/readme.md`. Businesses or clients: `business/readme.md`.

### chronology or decisions

Start at `log/readme.md`; confirmed decisions live in `log/decisions.md`.

### saved continuity or original words

Agent handoffs: `log/sessions/readme.md`. Owner transcripts: `log/conversations/readme.md`. Personal reflection: `log/journal/readme.md`. Read current status before any handoff.

### templates

Start at `agent/templates/readme.md`.

## personalized routes

Add routes here after onboarding identifies real recurring tasks. Keep each route narrow and task-based, usually four files or fewer.

## source hierarchy

1. The owner's current words.
2. `os/me.md`, `os/agent-rules.md`, and relevant current operating files.
3. Current project, business, or area status/specification files.
4. `log/decisions.md`.
5. Living reference notes.
6. Draft or exploratory notes.
7. Session records, transcripts, superseded files, and archives for supporting history only.

## maintenance

Update this map when a recurring task or current source changes. Run `ruby os/validate-life-os.rb` afterward.
