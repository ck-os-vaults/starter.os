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

Infer names, paths, real projects, businesses, repository structure, execution needs, timezone, existing automations, and approval boundaries from current evidence.

Ask one compact group only for material choices that cannot be inferred safely. Usually these are:

- desired vault name and destination;
- optional name for the Chief of Staff;
- confirmation of the setup, migration, or update route;
- the chosen primary Git destination when more than one valid choice exists;
- whether local-only Git is intentional after its device-loss limitation is explained;
- ambiguous file ownership or proposed structural changes;
- local, cloud, on-demand, or hybrid execution needs;
- which compatible recurring workflows, if any, the owner wants to adopt, decline, or defer.

Do not conduct a biography, tool, or future-feature interview.

## 4. Show one approval card

Include only relevant sections:

1. **Route and result** — setup, preserve-first migration, or update; exact source and destination.
2. **Files** — what changes, what remains untouched, and every conflict or unresolved item.
3. **Git and recovery** — repositories, one primary for each, optional automatic mirrors, the recovery point, and uncovered content.
4. **Ownership** — proposed Chief, projects, and businesses only when real work supports them.
5. **Execution** — where the Chief and project work will run, without making a vendor mandatory.
6. **Recurring workflows** — available capabilities, existing equivalents, the owner's choice for each compatible recipe, proposed schedule, destination, access, and likely cost.
7. **Approval boundaries** — exact consequential actions the owner is authorizing.

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
- anything still unverified.

Do not call a route complete while a required check is merely assumed.
