# Update an existing Starter.OS

> **Audience: Agent only.** The owner normally starts with the public repository link. Read `START-HERE.md`, `QUICK-SETUP.md`, and `GIT-SETUP.md`.

Update the existing system in place without replacing owner information or silently overwriting customization.

## Step 1: confirm source, target, and versions

Verify the public Starter.OS source with:

```sh
ruby setup/scripts/validate-starter-kit.rb
```

Confirm one installed Starter.OS target. Read its `os/release.json` when present. If it is absent, label the installation `unversioned legacy Starter.OS`; do not guess its baseline.

An unversioned installation is a supported guided path, not a reason to reinstall. Keep the interview short: identify the target, inventory the current files, show every conflict, and ask only for decisions that cannot be inferred safely.

## Step 2: discover Git and current protection

Follow the Git discovery in `QUICK-SETUP.md` for every in-scope repository.

Stop before update if there is unexplained divergence, an unsafe detached state, a rebase or merge in progress, or unique uncommitted content without additional recovery coverage. Do not stash, reset, switch, pull, or discard work to make the update easier.

If Git protection is missing, create an initial recovery commit and establish a private hosted primary before applying the update. Guide GitHub account security and private repository setup when no suitable hosted primary exists; preserve an existing suitable GitLab or other hosted primary when the owner prefers it. A local-only recovery point is incomplete protection and does not complete this gate.

## Step 3: create the deterministic plan

Write the plan outside the installed vault:

```sh
ruby setup/scripts/update-vault.rb plan /absolute/path/to/NAME.os /absolute/path/to/update-plan.json
```

Show the owner:

- installed and target versions;
- managed files that will be added or updated;
- owner-owned files that remain untouched;
- local modifications and legacy files that require a choice;
- explicit forks and available upstream changes;
- deprecated files that will be preserved;
- the Git recovery commit and any additional backup coverage;
- exact rollback instructions.

Also summarize new Starter.OS capabilities in plain language. Suggest only options compatible with the owner's verified environment, and separate those suggestions from required file changes.

For each conflict, offer:

- **keep as my fork** — preserve the local file and stop future automatic replacement;
- **replace with Starter.OS** — install the reviewed upstream file;
- **defer** — make no change to that artifact and leave the update incomplete.

Do not select for the owner.

## Step 4: approve one transition

Use the shared approval card. The update approval must name:

- exact target release;
- exact plan file identity;
- every conflict decision;
- files outside recovery coverage;
- Git primary and mirror actions;
- any structural or deprecated behavior;
- the adopt, decline, or defer choice for each compatible recurring workflow suggestion.

Silence is not approval.

## Step 5: apply only the approved plan

The tool rechecks that neither source nor target changed after planning.

For a plan without conflicts:

```sh
ruby setup/scripts/update-vault.rb apply /absolute/path/to/NAME.os /absolute/path/to/update-plan.json
```

For reviewed conflicts, add one option per exact path:

```sh
ruby setup/scripts/update-vault.rb apply /absolute/path/to/NAME.os /absolute/path/to/update-plan.json --keep path/to/local-file --replace path/to/managed-file
```

`--keep` records an explicit owner fork in place. `--replace` installs the upstream managed file. Any conflict without an approved choice stops the apply. The updater never deletes unknown or deprecated owner content.

The protected product manual stays at `os/manual.md`. If its local copy changed and the owner wants to preserve that explanation, use an owner-approved fork destination while restoring the current product manual:

```sh
ruby setup/scripts/update-vault.rb apply /absolute/path/to/NAME.os /absolute/path/to/update-plan.json --fork os/manual.md=life/manual.md
```

Then record the chosen manual fork path in `os/me.md`. The tool refuses `--keep os/manual.md` because leaving a personalized file at the protected product path would make future explanations ambiguous.

## Step 6: validate and verify Git

Run:

```sh
ruby os/validate-starter-os.rb
```

Review the exact diff. Commit only intended update changes to the approved repositories, push only to the primary, and verify every enabled automatic mirror reaches the same commit.

If validation or verification fails, stop and restore the pre-update Git commit before another attempt. Do not stack fixes on an unknown partial state.

## Step 7: guide optional recurring workflows

Audit existing routines by purpose and name. Explain the compatible `Morning Brief`, `News Report`, `System Security Watch`, and `Task Reconciliation` improvements without assuming the owner wants them.

When accepted, update matching routines to the current portable skills and verify their name, schedule, timezone, destination, instructions, access, runtime, active status, and first eligible run. Prefer persistent home-base destinations when supported. Do not create duplicates or new tasks per run. Record declined, deferred, unavailable, or unverified states truthfully.

## Step 8: give the update receipt

Report:

- previous and installed version;
- updated, added, preserved, forked, deferred, deprecated, and unresolved paths;
- validation results;
- local recovery commit;
- primary and mirror commit identities;
- every offered recurring-workflow outcome;
- exact rollback route.

An update is complete only when no artifact remains silently conflicted, the installed vault validates, Git recovery and publication are truthful, enabled mirrors are verified or named as unresolved, and every offered recurring workflow has a recorded outcome.
