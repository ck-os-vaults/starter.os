# Copy and paste into your agent to migrate an existing vault

**For: Existing User**

```text
Migrate my existing vault completely into the current Starter.OS structure.

Use the current Starter.OS repository as the structural and operating source:
https://github.com/ck-os-vaults/starter.os

Assume I am not technical. Handle the entire migration yourself and keep me
informed with short phase updates. Do not ask for approval, confirmation, or
routine decisions. Infer names and destinations from the existing vault, make
the safest conservative choice when something is unclear, record that choice,
and continue until the migration is completely finished. Pause only when an
external sign-in or credential entry physically requires me; ask for that one
action without requesting or exposing the credential, then resume immediately.

This prompt file is also the migration runbook. Keep
`setup/PROMPT-03-MIGRATE-OLD-VAULT.md` available in the new vault throughout
the work. Re-read it before every phase, after any context reset or agent
handoff, and before declaring completion. Track every numbered requirement in
`setup/MIGRATION-RECEIPT.md`; do not rely on chat memory.

The finished private vault must use this structure:

<NAME>.os/
├── AGENTS.md
├── CLAUDE.md
├── biz/
│   └── <first-business>/
├── life/
├── os/
└── .obsidian/

The root and `biz/` are plain containers, never Git repositories. `os/`,
`life/`, and each real `biz/<business>/` are separate private repositories.
GitHub `origin` is primary. GitLab `backup` is the identical mirror. Setup and
migration files are temporary and must be archived together when complete.

Every phase has the same completion gate: perform the phase, inspect the actual
result, run the relevant checks, fix every failure, repeat the checks, and write
the evidence to `setup/MIGRATION-RECEIPT.md`. Do not start the next phase until
the current phase passes. After all phases, perform the independent final
review required below.

Non-negotiable safety rules:

- Do not migrate destructively in place. Build a clean sibling `<NAME>.os`
  vault. The untouched original vault becomes the complete dated archive of
  the previous structure, including hidden files, Git history, ignored files,
  attachments, and `.obsidian/` state.
- Never use reset, clean, force-push, history rewriting, or bulk deletion.
- Never discard dirty, untracked, ignored, hidden, or conflicting files.
- Never edit an archive after it is created.
- Never ask for or store passwords, one-time codes, recovery codes, tokens,
  API keys, private keys, seed phrases, or credentials.
- Create only private repositories. Use an already authenticated GitHub/GitLab
  session when available; if authentication is required, ask me only to sign
  in and then continue without another approval gate.
- Never copy my private information back into the public Starter.OS source.
- Treat current facts, decisions, and owner-written meaning separately from
  agent inference. Do not invent missing context or promote drafts as truth.
- Questionable, stale, duplicated, or unclear material goes to review or a
  dated archive; it is not silently deleted or left in active routes.

Follow every phase below. Keep all migration work products inside the new
vault's `setup/` folder so they archive together at the end.

PHASE 1 — orient and protect the source

1. Confirm the root of my existing vault. Read its AGENTS.md, CLAUDE.md,
   readmes, maps, current-state files, and nearest repository instructions.
2. Inspect before writing:
   - Git status, branch, commit, remotes, tags, worktrees, submodules, and
     nested `.git` folders;
   - tracked, untracked, ignored, hidden, and symlinked files;
   - `.obsidian/`, plugins, attachments, media, scripts, exports, and large
     files;
   - all Markdown files, frontmatter, tags/properties, links, and wikilinks.
3. Do not stash, clean, reset, checkout, commit, move, rename, or delete yet.
4. Identify any secrets, credential-shaped text, public/private exposure, or
   files that should never be copied or published. Report blockers without
   printing secret values.
5. Record the source Git state and a full file inventory in
   `setup/MIGRATION-MANIFEST.md` in the new vault once it exists.

PHASE 2 — obtain and verify the current Starter.OS source

1. If a clean current Starter.OS checkout containing this prompt is already
   available, use it. Otherwise download or clone the repository above into a
   temporary folder outside my old vault.
2. Do not personalize or commit to the public Starter.OS checkout.
3. Read its AGENTS.md, readme.md, setup/AGENT-RUNBOOK.md,
   setup/ONBOARDING-INTERVIEW.md, os/agent-rules.md, os/retrieval.md,
   os/vault-map.md, and os/knowledge-map.md.
4. Run `ruby scripts/validate-starter-kit.rb`. Do not use the source kit until
   it passes. Refresh the checkout, diagnose the failure, and fix or replace the
   temporary source copy as needed; do not merely report the failure and stop.
5. Determine what replaces `STARTER` from the existing vault name and current
   owner context. Preserve a clear existing name; otherwise choose a concise
   descriptive name. Keep the `.os` suffix. Record the choice and continue.

PHASE 3 — create the autonomous migration manifest

Create one complete manifest before reorganizing content. For every source
file or coherent folder, record:

- current path and file type;
- proposed new owner and destination;
- action: keep, update, archive, review, or exclude;
- whether it is current, historical, duplicated, stale, generated, sensitive,
  or uncertain;
- authority/source when known;
- important links or dependents;
- reason and confidence;
- uncertainty level and the conservative disposition used.

Audit specifically for:

- contradictory current facts, expired priorities, old dates presented as
  current, abandoned projects, obsolete instructions, and stale status files;
- duplicate notes, near-duplicate names, conflicting foundations, orphaned
  files, broken routes, empty placeholders, and files that no map can reach;
- personal material inside business files, business material inside personal
  files, and reusable OS rules mixed into either one;
- old folder names, inconsistent capitalization, ambiguous wikilink targets,
  invalid frontmatter, uncontrolled tags, and stale metadata values;
- attachments or exports whose privacy, ownership, or usefulness is unclear.

Write one concise review package inside the manifest containing:

1. confirmed root name;
2. proposed businesses and the first business name;
3. keep/update/archive/review/exclude totals;
4. sensitive or external-action blockers;
5. every conservative judgment the agent made for unclear material;
6. the exact new repository boundaries;
7. the rollback plan.

Do not ask for approval of the manifest or stop for unresolved organizational
choices. Resolve each item conservatively: preserve rather than delete, archive
rather than promote uncertain material, keep owner-written meaning separate
from inference, and prefer the current Starter.OS rules when old operating
instructions conflict. Record the reasoning, verify manifest coverage, and
continue.

PHASE 4 — create rollback checkpoints

After the manifest passes its phase review and before changing any source:

1. Preserve the existing vault exactly as found. Do not reorganize it. If the
   migration requires touching it, first create a byte-for-byte dated sibling
   snapshot and work only from the snapshot or a separate copy.
2. Give the untouched source a dated archival identity such as
   `<OLD-NAME>-pre-starter-os-archive-YYYY-MM-DD`. Rename it only after the new
   vault passes final verification; until then, record that final archive name
   in the manifest.
3. Preserve its complete directory tree, hidden files, `.git` history,
   branches, tags, untracked and ignored files, attachments, and `.obsidian/`
   state. Keep secrets local and excluded from any new commit or remote.
4. Do not add a commit, tag, stash, or other mutation to the old vault. Record
   its existing Git state and use the unchanged filesystem archive, verified by
   hashes and counts, as the rollback checkpoint.
5. Record the archive path, original path, existing commit/tags, remotes,
   file counts, hashes, sensitive exclusions, and tested restore steps in the
   migration manifest.
6. Never nest this full old-vault archive inside `os/`, `life/`, or a business
   repository. It is the preserved historical structure, not active context.

PHASE 5 — build the clean target shell

1. Use the verified Starter.OS generator to create a new sibling `<NAME>.os`
   folder. Refuse any non-empty destination.
2. Confirm the root contains `biz/`, `life/`, `os/`, and temporary `setup/`.
3. Confirm the root and `biz/` do not contain `.git`.
4. Open only the new root as the Obsidian vault and agent workspace.
5. Preserve one root `.obsidian/`. Review old Obsidian settings and plugins;
   carry forward only understood, safe, useful settings. Do not blindly copy
   stale plugin state, workspace history, caches, or secrets.
6. Set `setup/STARTER-VERSION.md` to `in-progress`.
7. Add `setup/MIGRATION-MANIFEST.md`, `setup/MIGRATION-RECEIPT.md`, and any
   temporary review lists. These must remain inside `setup/`.

PHASE 6 — rebuild structure and migrate content

Use the current `os/vault-map.md` and `os/retrieval.md`, not the old layout, as
the destination rules. Typical old routes may map as follows, but inspect the
actual meaning before moving anything:

- old inbox/capture -> `life/00_inbox/`;
- old areas -> `life/areas/`;
- old personal projects -> `life/projects/`;
- old personal knowledge -> `life/knowledge/`;
- old logs, journal, conversations, decisions, and sessions -> matching
  `life/records/` lanes;
- old current personal state -> `life/now.md`;
- shared identity, agent behavior, retrieval, recovery, maps, templates, and
  reusable routines -> reviewed current files in `os/`;
- each real business -> its own `biz/<business>/` repository;
- inactive or superseded material -> a dated archive owned by `life/` or the
  relevant business;
- uncertain material -> a dated review folder referenced by the manifest.

For the first confirmed business, rename `biz/business-model/` by running
`ruby setup/add-business.rb <lowercase-kebab-name>`. Then personalize its
foundations from confirmed source material. Do not leave `business-model/`
active after the first business is named. Create additional business folders
only for real confirmed businesses, using the same foundation shape.

Do not copy old OS files wholesale over the new OS. Compare rule by rule. Keep
valuable owner preferences and proven routines, adopt the current Starter.OS
structure and safety boundaries, resolve conflicts explicitly, and archive the
superseded originals.

Copy first, verify, then retire old locations. Do not remove the preserved
source vault during this migration.

PHASE 7 — normalize every active file and retrieval route

Perform a complete metadata and retrieval audit across every active Markdown
file:

1. Apply the schema and allowed values in `os/retrieval.md`.
2. Check every frontmatter key, tag/property, date, status, authority, source,
   supersession pointer, and archive marker.
3. Preserve a reliable original creation date. If it is unknown, use the
   migration date and record that provenance in the manifest rather than
   pretending the date is original.
4. Use one clear H1. For routed notes that require them, include one
   `Bottom line` and one `When to read this` before the first H2.
5. Normalize ordinary filenames and folders to lowercase kebab-case. Keep dated
   records in `YYYY-MM-DD` form. Fix case-sensitive paths and references.
6. Resolve every Markdown link and wikilink. Check anchors, relative paths,
   renamed files, duplicate basenames, and links into archives.
7. Ensure maps and readmes route only to current useful sources. Historical or
   review material must not outrank or masquerade as current truth.
8. Reconcile duplicate and conflicting facts. Keep one current owner; preserve
   meaningful history in records/archive; add receipts where a move or merge
   would otherwise be hard to trace.
9. Review every current claim in `os/me.md`, `life/now.md`, business readmes,
   business status files, decisions, recovery, integrations, and maps. Resolve
   stale facts from the strongest current evidence. If evidence is insufficient,
   mark a visible currency gap, keep the uncertain claim out of current truth,
   record the disposition, and continue. Do not silently guess.
10. Remove empty generated placeholders only when their route is unnecessary
    and the manifest records the action. Keep the four generic Life area
    starters unless the source clearly establishes a different current set; in
    that case, migrate the evidenced set and record the change.

PHASE 8 — privacy, security, and file audit

1. Scan active and proposed committed files for secrets, private keys, tokens,
   credentials, recovery codes, environment files, embedded-token URLs, private
   exports, and accidental public data.
2. Audit `.gitignore` in `os/`, `life/`, and every business before Git setup.
3. Inspect attachments, media, binary files, symlinks, scripts, dependencies,
   generated output, and files above normal size. Keep only intentional items.
4. Confirm no real private data entered the public Starter.OS checkout.
5. Report findings by exact path without exposing secret contents.

PHASE 9 — create the new repository and backup topology

Only after content, metadata, and privacy reviews pass:

1. Audit and retire the old Git process in active documentation, scripts,
   automations, hooks, and recovery instructions. Preserve the old root
   repository and its complete history only inside the dated old-vault archive.
2. Confirm the new repository set is exactly `os/`, `life/`, and one repository
   for each real `biz/<business>/`. Never initialize Git at the vault root or
   `biz/`, and never leave a business as a nested repository or submodule.
3. Initialize each new repository independently and create a clear foundation
   commit. Do not mix OS, Life, or business histories. Do not copy an old root
   `.git` directory into the new vault.
4. Use an authenticated session to create a private GitHub repository for each
   new repository. Configure GitHub as remote `origin`, make it the primary
   source of truth, and push it first.
5. Create a corresponding private GitLab repository for each one. Configure it
   as remote `backup` and mirror the complete intended GitHub ref state to it
   only after the GitHub push succeeds.
6. Mirror every intended branch, tag, update, and deletion. GitLab must contain
   no independent commits or GitLab-only refs. For every repository, compare
   local, GitHub, and GitLab branch/tag sets and commit IDs and require exact
   equality. If GitLab differs, repair the mirror from GitHub and recheck.
7. Update all active Git instructions, maps, agent rules, recovery files, and
   automation references so they describe only this process: work in the
   owning repository, commit separately, push GitHub `origin` first, mirror
   GitLab `backup` second, verify identical refs, and finish with a clean tree.
8. Never use multiple push URLs as a substitute for the two named remotes.
   Never use GitLab-first state to overwrite GitHub.
9. Configure full-vault protection for root `.obsidian/`, ignored safe
   attachments, the preserved old-vault archive, and every other file Git
   intentionally excludes. Complete a harmless restore test.
10. Record the complete repository map, GitHub/GitLab remote names, backup
    schedule, last successful mirror check, full-vault backup, and last restore
    test in `os/recovery.md` without credentials.

PHASE 10 — triple verification

Run three independent passes. A pass must be repeated after any fix.

PASS A — mechanical and structural

- Run `ruby os/validate-starter-os.rb` and every relevant repository-specific
  validator/test.
- Recheck required paths, lowercase names, frontmatter, tags/properties, dates,
  one-H1 rules, summaries, broken Markdown links, unresolved/ambiguous
  wikilinks, stale old routes, secret patterns, ignore rules, `.obsidian/`
  placement, nested Git, and repository boundaries.
- Confirm working trees contain only intentional changes.

PASS B — semantic and source-to-target reconciliation

- Reconcile every source file against `setup/MIGRATION-MANIFEST.md`; no file may
  be missing, silently dropped, or counted twice.
- Compare source and target counts and hashes where appropriate.
- Open representative files from identity, current state, each area, projects,
  knowledge, every record lane, every business, archives, attachments, and
  Obsidian configuration.
- Re-read all maps, status files, foundations, decisions, agent rules,
  retrieval rules, recovery instructions, and integration records for stale,
  contradictory, duplicated, overbroad, or invented content.
- Confirm archives are preserved, read-only, and absent from current startup
  routes.

PASS C — clean-room recovery and publication parity

- Reconstruct the new vault in a temporary location from the private GitHub
  repositories, attach/fetch the GitLab backup remotes, and restore the root
  pointers plus safe non-Git files from full-vault backup.
- Run the installed validator in the reconstructed vault.
- Compare the declared repository set, intended branches/tags, commit IDs, and
  a representative restored file with the live target.
- Confirm GitHub and GitLab match exactly and every live working tree is clean.

PHASE 11 — final independent review, cleanup, and archive

1. Independently review the entire result from the new root without relying on
   the earlier phase conclusions. Fix every issue and rerun the affected phase
   gate plus all three verification passes.
2. Prepare a compact final report:
   - what moved and changed;
   - what was archived or excluded;
   - stale or conflicting information resolved;
   - unresolved review items and residual risks;
   - validation, restore, and remote-parity results;
   - old-vault rollback location;
   - exact final root structure.
3. Open and inspect representative files from every repository and perform one
   real retrieval task from the root to prove that routing works.
4. Complete `life/records/sessions/YYYY-MM-DD-setup-completion.md` from
   `setup/SETUP-COMPLETION.md` and complete `setup/MIGRATION-RECEIPT.md`.
5. Replace root AGENTS.md and CLAUDE.md with the permanent pointers from
   `os/templates/root-AGENTS.txt` and `os/templates/root-CLAUDE.txt`.
6. Remove every active setup/migration route from permanent OS, Life, business,
   and root files.
7. Set `setup/STARTER-VERSION.md` to `complete`.
8. Move the entire `setup/` folder unchanged to
   `life/archive/setup/YYYY-MM-DD/`. Do not leave tutorial, migration, manifest,
   helper, state, or setup files active outside that archive.
9. Run all three verification passes again after archival and cleanup.
10. Publish only the repositories changed by cleanup: GitHub first, GitLab
   second. Verify exact parity and clean trees.
11. Rename the untouched original vault to its dated
    `<OLD-NAME>-pre-starter-os-archive-YYYY-MM-DD` path, mark it retired and
    read-only where practical, and verify its counts/hashes against the source
    inventory. Do not delete it. Include explicit restore instructions and a
    later review date in the final report.
12. Deliver the final report only after all work, publication, mirroring,
    archival, cleanup, and verification are complete. Do not ask for a final
    approval to perform any remaining migration task.

Final acceptance requires all of the following:

- the new root contains only `.obsidian/`, AGENTS.md, CLAUDE.md, `biz/`,
  `life/`, and `os/`;
- the first business model has been renamed to the confirmed first business;
- every source item has a manifest disposition and every active item has one
  clear owner;
- all active metadata, retrieval properties, links, routes, names, current
  claims, decisions, and maps have been reviewed;
- questionable and historical material is preserved outside active context;
- validators, security checks, source reconciliation, and clean-room recovery
  all pass;
- GitHub and GitLab refs match for every intended repository;
- active Git documentation and automation use GitHub first and an identical
  GitLab mirror for `os/`, `life/`, and every individual business;
- full-vault backup and restore are proven;
- working trees are clean;
- setup is archived and the everyday vault opens in a fresh, minimal state;
- the complete previous structure is preserved as a dated, tested, recoverable
  old-vault archive.

Start now. Give one short phase update, inspect the existing vault read-only,
and continue through every phase to completion. Do not ask for approval. Ask
only for an unavoidable external sign-in action, then resume immediately.
```
