---
type: note
created: 2026-07-11
updated: 2026-07-11
reviewed: 2026-07-11
status: living
authority: canon
source: ai
---

# prompt 6 — upgrade to the current architecture

**Bottom line:** Brings a vault built from the starter up to the current life.os architecture — a unified `log/` record layer, layered personal context, a deduplicated OS with a lean startup chain, and five newer skills — then sets up private GitHub backup with full hand-holding and wires it into the wrap ritual. Runs autonomously: the owner pastes it and the agent does the work, no approval gates.

**When to read this:** Use after initial setup and some real use, when the owner wants the source system's later improvements. Includes private-GitHub setup, so it also covers vaults that skipped prompt 04. Paste the block below into Claude (or any agent) inside the vault.

```text
Upgrade this vault to the current life.os architecture, then set up my GitHub
backup. This vault was built from a starter snapshot and the source system has
evolved since. You cannot see the source repo: this prompt is the complete
specification of the target state. Migrate my STRUCTURE toward the spec; all
content stays mine and gets adapted, never replaced.

This prompt is my explicit permission to edit the protected os/ files and
restructure the vault. Do the work autonomously, phase by phase, without
stopping for approvals. The only questions you may ask are the small set
listed in Phase 2 and whatever Phase 6 genuinely needs from me — nothing else.

Hard rules for the entire job:
- Never delete anything. Replaced or inactive material moves to a dated folder
  in archive/; files replaced in place get frontmatter status: superseded plus
  superseded_by pointing at their successor.
- Never rewrite text I authored (source: owner). My words survive every move;
  only location and metadata may change.
- One git commit per phase (local commits are fine — the remote comes in
  Phase 6), so any phase can be reverted on its own.
- Run ruby os/validate-life-os.rb before every commit, and update the
  validator in the same phase whenever structure or schema changes. The
  validator and the vault must never disagree. If the validator crashes with
  an encoding error, add these two lines after its require statements and
  rerun:  Encoding.default_external = Encoding::UTF_8  and
  Encoding.default_internal = Encoding::UTF_8
- Talk to me in plain, non-technical language the whole way. I am not a
  developer. Explain what you did in each phase in one or two friendly
  sentences, not in jargon.

PHASE 0 — ORIENT AND SCAN
Read os/me.md and follow its startup instructions, plus os/retrieval.md.
Scan the vault: where personal information about me has accumulated since
onboarding, whether os/me.md still matches it, and whether any folder inside
this vault is its own independent git repository (if one is, leave its
insides alone and make sure the main repo ignores it). Decide everything else
in this job with sensible defaults instead of asking me.

PHASE 1 — THE RECORD LAYER: journal/ BECOMES log/
Target: one top-level log/ layer holding the chronological record — raw,
append-only, never startup material.
- log/daily/, log/weekly/, log/monthly/ — agent-written records of what
  happened (move the existing journal/ streams here with git mv).
- log/decisions.md — the decision log (move journal/decisions.md).
- log/journal/ — MY own reflective writing, verbatim, kept forever. Create it
  with a short readme even if empty, and add a `journal` entry to the
  frontmatter type vocabulary in os/retrieval.md and the validator.
- log/conversations/ — verbatim transcripts of me, the long-term corpus.
  Create with a short readme even if empty.
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
  priorities; open decisions, each with the condition that will resolve it;
  key constraints worth tracking; upcoming calendar anchors. Kept current by
  eod-wrap and weekly-review; read for planning and check-ins. Draft it from
  what the vault already shows. If my current priorities are genuinely not
  discoverable, ask me up to 3 quick questions to fill the gaps — these are
  the only questions allowed in Phases 0–5. Mark the file source: ai so I
  know to refine it as we work together.
- knowledge/people/owner.md stays the deeper dossier, loaded on demand only.
  Consolidate scattered personal information found in Phase 0 into it (or
  into now.md if it is current-state).
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
  - os/now.md — for life planning, priority setting, personal reviews,
    check-ins, or when my state materially matters; not for technical or
    repository reviews.
Supersede os/skills/agent-startup.md (status: superseded, superseded_by:
../me.md) — the boot chain replaces it — and de-register it from skill-map.
Slim skill-map.md to the trigger table plus a few framing lines; it stays
always-loaded, because behavior-triggered skills can only fire if their
trigger table is already in context. Commit.

PHASE 4 — NEW SKILLS
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
  a move happens; fix only reversible metadata automatically.
- security-sweep — trigger: before any commit containing unreviewed or
  imported material, and before anything public → check the changes for
  secrets, private-data leaks, and scope creep.
Commit.

PHASE 5 — VERIFY THE MIGRATION
Run a metadata audit across every changed file and run the validator. Do a
before/after inventory of the os/ rules proving each old rule survived to
exactly one home. Record the migration as one entry in log/decisions.md
(what changed, why, and which commit to revert for which symptom). Commit.

PHASE 6 — SET UP MY GITHUB BACKUP (I AM NOT TECHNICAL — HOLD MY HAND)
Goal: my whole vault privately backed up to GitHub, verified working, so
every wrap-up can save a copy off this computer. GitHub is my only backup
layer for now — do not ask me about, recommend, or set up any other backup.

First, in one short friendly paragraph, tell me what GitHub is (a service
that keeps a private, dated copy of my files off my computer, with the
ability to see the version history of every file) and what we are about
to do.

Do as much as possible yourself. Before anything leaves this computer:
- Make sure local git is initialized and all phase commits exist.
- Audit .gitignore: local app/agent state (.obsidian/, .claude/, .trash/),
  temporary attachments, and any independently versioned nested folder must
  be excluded. Scan the tracked files for anything credential-shaped without
  printing values. Run the security-sweep skill. Fix problems before pushing.
- Explain to me in one plain sentence what will and will not be backed up.

Then get me onto GitHub, adapting to what my machine actually has:
- If I do not have a GitHub account: walk me through creating one at
  github.com step by tiny step — what to click, what to type where, in
  plain words. Tell me to choose a strong password and save it in the
  password manager or notes app I already use, and to write down my
  username. Wait while I do it and ask me to tell you when I am done.
  You must never ask for or handle my password — account creation and
  sign-in are always mine to do in the browser.
- Check whether the GitHub command-line tool (gh) is installed. If not, try
  to install it yourself (for example with Homebrew if present). If you
  cannot install tools on this machine, switch to instructor mode: give me
  the exact steps to do it, one small step at a time, waiting for my "done"
  after each.
- Connect this computer to my account with gh auth login using the browser
  option. Explain what will happen: a code appears here, a page opens in my
  browser, I type the code and click approve. That approval step is mine —
  guide me through it and check afterwards that it worked.
- Create the private repository and push: gh repo create with a sensible
  name, PRIVATE (never public — state this explicitly and verify it
  afterwards with gh repo view), connected to this folder, then push all
  commits. If any step fails, read the error, fix or instruct, and retry
  until the push succeeds — do not leave this phase half done.
Verify together: confirm the local and remote latest commits match, then
show me how to see my backup with my own eyes — go to github.com, log in,
open the repository, see my files and the list of saved versions. Make sure
the repository page says Private.

PHASE 7 — MAKE BACKUP PART OF EVERY WRAP, THEN CLOSE
Update os/skills/eod-wrap.md and, if needed, the commit rule in
os/agent-rules.md so that every wrap-up validates, commits, and pushes to
GitHub — with judgment: meaningful changes get committed and pushed with a
clear plain-language message; read-only sessions and trivial noise do not.
Create os/recovery.md: what the backup is (the private GitHub repository),
how to get everything back on a new computer with an agent's help (install
git, sign into GitHub, clone the repository, open it in Obsidian), what git
does NOT restore (the ignored local app files — they rebuild themselves or
can be reconfigured), and a note that a second backup layer is planned
later. No credentials ever appear in the vault; the runbook says where they
live (my password manager), never the values.
Final commit and push. Then give me a plain-language summary: what my vault
looks like now, what happens automatically at every wrap-up from now on, how
to check my backup anytime, and the one thing to watch during the first week
(a session that creates or misplaces a file without checking the vault map —
if that happens, tell my agent to look at the Phase 3 commit).
```
