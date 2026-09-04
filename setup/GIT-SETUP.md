# Git protection and automatic mirrors

> **Audience: Agent only.** Use this shared contract during setup and update. Explain results to the owner in plain language; do not ask them to run Git commands.

## The simple rule

Each repository has one primary. Agents commit and push only to that primary.

A second Git service is optional. When accepted, configure it as an automatic downstream mirror through the primary host's native mirroring, a narrowly scoped primary-host automation, or another owner-approved one-way mechanism. Do not keep a second routine agent push target.

GitHub is the public home of Starter.OS and the normal guided private primary for a new owner. Preserve an existing suitable GitLab or other hosted primary when the owner prefers it.

## Step 1: discover the existing topology

Inspect read-only:

- repository roots and nested-repository boundaries;
- branches, worktrees, submodules, and uncommitted or untracked work;
- remotes with credential-bearing parts redacted;
- default branches and reachable commit identities;
- hosting providers, repository owners, and visibility where safely verifiable;
- current primary behavior and any direct dual-push automation;
- mirror direction, health, and latest matching commit;
- files not covered by any repository.

Do not infer that a remote named `origin` is truly primary. Determine what the current workflow actually uses. Never expose tokens, embedded credentials, private keys, or secret URLs.

## Step 2: choose the minimum safe topology

Preserve valid existing history. Recommend:

- one working repository for `os/`;
- one working repository for `life/`;
- one repository for each real `biz/<business>/`;
- no repository at the vault root or empty `biz/` container;
- one private hosted primary per repository;
- zero or more automatic downstream mirrors.

The 2.2 updater and validator require this topology. If an existing owner uses a different topology, preserve the complete current state first. Then plan and approve the conversion before setup or update continues. Until conversion is complete, report the Git topology as unresolved. Never create nested Git repositories accidentally.

Whenever `os/scripts/add-business.rb` creates `biz/<business>/`, finish the same approved workflow by making that exact folder an independent Git repository, creating its first recovery commit, connecting and verifying its private hosted primary, and recording it in `os/recovery.md`. Do not call the business created while it remains only a folder. The empty `biz/` container never becomes a repository.

If no suitable hosted primary exists, the normal path is to guide the owner through GitHub account security and private repository creation. The owner handles sign-in, multifactor authentication, recovery codes, and secret values privately. The agent handles repository initialization, connection, validation, commit, and push wherever possible.

Local-only Git may create a temporary recovery point, but record `incomplete; device loss not covered` and do not call the standard setup complete until a private hosted primary is verified. Offer an independent off-device file backup while the gap remains.

## Step 3: preview consequential actions

Show:

- exact repository and local path;
- existing or proposed primary provider and private visibility;
- existing or proposed automatic mirrors and direction;
- history changes, if any;
- initial or recovery commit scope;
- files outside Git coverage;
- credentials or sign-ins the owner must handle privately;
- validation and rollback route.

Wait for approval before initializing Git, changing remotes, creating repositories, publishing commits, changing visibility, configuring mirrors, or adding automation.

## Step 4: create the first working recovery point

Before publication or update:

1. confirm the intended files and privacy boundary;
2. run the owning validator and secret checks;
3. make sure unique work is tracked or separately protected;
4. create the approved commit in the working repository;
5. read back the commit and clean or intentionally dirty state.

Do not call local history a device-loss backup.

## Step 5: connect one primary

Use the provider and account the owner approved. Preserve existing remote names when safe; use `origin` for a new primary by convention.

Never ask the owner to paste a token into chat or store credentials in Starter.OS. Use the provider's normal secure sign-in or an already authorized credential system.

Before the first private push, verify the destination and visibility. Do not use a public fork as the private working repository. Push only the approved branch and read back the primary's commit identity.

## Step 6: convert or add automatic mirrors

If the owner wants a secondary service:

1. compare primary and secondary histories and stop on unexplained divergence;
2. preserve all unique history;
3. configure one-way mirroring from the primary using the primary's native feature or narrowly scoped automation;
4. remove the secondary from routine agent push instructions only after the automatic path is configured;
5. trigger or wait for the mirror;
6. verify the secondary default branch reaches the exact primary commit;
7. record the mechanism without credentials.

If automatic mirroring is unavailable, report `configured but unverified` or `unavailable`. Do not silently restore dual pushes.

## Step 7: verify and record

For each repository, record in `os/recovery.md`:

| Repository | Local path | Primary | Primary commit | Mirror | Mirror commit | Status | Checked |
|---|---|---|---|---|---|---|---|

Use only:

- `verified`;
- `configured but unverified`;
- `incomplete; device loss not covered`;
- `owner declined`;
- `unavailable`.

A repository is fully verified only when the local approved commit is readable, the primary reports the same commit, and every enabled mirror reports the same commit. Otherwise name the exact remaining gap.
