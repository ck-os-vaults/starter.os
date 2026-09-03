# Shared guided setup protocol

> **Audience: Agent only.** Use this from setup, migration, or update. The owner normally provides only the public repository link.

## 1. Determine the route read-only

Inspect only enough to distinguish:

- **setup** — no existing personal system to preserve;
- **migration** — another personal system exists;
- **update** — an existing Starter.OS exists.

Do not mutate, install, authenticate, clone over an existing folder, or inspect unrelated private locations. If the route remains genuinely ambiguous, ask one plain question.

## 2. Discover Git before proposing changes

For every in-scope repository or proposed repository, determine without exposing credentials:

- exact local path and whether it is a Git repository;
- current branch, working-tree state, untracked work, and last commit;
- configured remotes, provider, default branch, and reachable commit identity;
- which remote currently acts as primary;
- whether another service receives direct pushes or automatic mirroring;
- visibility when it can be verified safely;
- whether local history, the primary, and every mirror agree;
- which unique files are outside Git coverage.

Do not pull, merge, switch, stash, rewrite, initialize, create a remote, or change configuration during discovery. Preserve existing history.

## 3. Infer first, ask once

Infer names, paths, real projects, businesses, repository structure, execution capabilities, timezone, existing automations, and approval boundaries from current evidence.

Ask one compact group only for material choices that cannot be inferred safely. Usually these are:

- desired vault name and destination;
- optional name for the Chief of Staff;
- confirmation of the setup, migration, or update route;
- the chosen hosted primary when an existing suitable service should be preserved instead of the default guided GitHub path;
- whether the owner can complete private GitHub account and repository setup when no suitable hosted primary exists;
- ambiguous file ownership or proposed structural changes;
- any missing repository, persistence, scheduler, source-access, delivery, or Git-verification capability that changes which workflows can operate;
- which compatible recurring workflows, if any, the owner wants to adopt, decline, or defer.

Do not conduct a biography, tool, or future-feature interview.

## 4. Show one approval card

Include only relevant sections:

1. **Route and result** — setup, preserve-first migration, or update; exact source and destination.
2. **Files** — what changes, what remains untouched, and every conflict or unresolved item.
3. **Git and recovery** — repositories, one primary for each, optional automatic mirrors, the recovery point, and uncovered content.
4. **Ownership** — proposed Chief, projects, and businesses only when real work supports them.
5. **Execution** — verified repository, persistence, scheduler, source-access, delivery, and Git capabilities; name where work will run only when useful, without making a vendor mandatory.
6. **Recurring workflows** — available capabilities, existing equivalents, the owner's choice for each compatible recipe, proposed schedule, destination, access, and likely cost.
7. **Source cleanup** — whether the public Starter.OS source is remote-only, a temporary checkout or download, or an intentional maintainer checkout; name the exact temporary path proposed for removal.
8. **Approval boundaries** — exact consequential actions the owner is authorizing, including any temporary-source deletion.

Wait for approval. Silence is not approval.

## 5. Recurring workflow choice contract

First verify the available scheduler, persistent task destinations, source access, permissions, existing routines, and meaningful owner customizations. Then explain only compatible recipes in plain language:

- `Morning Brief`: calendar, tasks, project state, week ahead, and a short owner check-in delivered to the persistent Chief of Staff home base.
- `News Report`: owner-selected sources, citations, layman's summaries, relevance, and `adopt`, `test`, `watch`, or `ignore` recommendations.
- `System Security Watch`: deterministic checks first, read-only and fail-closed, silent after complete clean coverage, and visible only for material risk or incomplete coverage.
- `Task Reconciliation`: internal input to the Morning Brief or an explicit checkpoint, not a separate owner-facing report by default.

Let the owner adopt, decline, or defer each compatible recipe. When accepted, locate equivalent existing routines by purpose as well as name, update instead of duplicate, use the available owner-approved scheduler, and point the instructions to the matching portable skill. Prefer a persistent home-base destination when supported and do not create a new task per run. No particular model, agent, provider, source, or fixed schedule is required.

Verify name, schedule, timezone, destination, instructions, source access, runtime or model, active status, and first eligible run. Report `verified`, `configured but unverified`, `unavailable`, or `owner declined`.

## 6. Finish with proof

Run the route-specific tools and full installed validation. Return a concise receipt containing:

- installed or target version;
- files changed, preserved, forked, deferred, or unresolved;
- Git primary and mirror commit identities;
- recovery point and exact rollback route;
- recurring workflow status;
- validation results;
- distribution-source cleanup status;
- anything still unverified.

Do not call a route complete while a required check is merely assumed.

## 7. Clean up the distribution source

The installed private system never keeps `setup/`. Future updates use a fresh current source from the canonical public repository link.

After the private system validates and its hosted Git primary is verified, classify the public distribution source:

- **Remote-only access** — nothing local needs cleanup.
- **Temporary checkout or download created only for this route** — verify the exact folder contains no owner files, credentials, unique work, or uncommitted changes. Remove the whole temporary source only when its exact path and deletion were approved in the approval card; otherwise report the path and offer cleanup.
- **Intentional maintainer or product checkout** — leave it intact with `setup/`, even when the route is complete.
- **Pre-existing or changed folder with uncertain ownership** — leave it intact and report why it was not removed.

Never delete individual setup files from a public source, never remove a source merely because it looks stale, and never treat the owner's old personal system in a migration as temporary distribution material. Report the cleanup result in the final receipt.
