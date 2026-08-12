---
type: map
created: 2026-08-11
updated: 2026-08-11
reviewed: 2026-08-11
status: living
authority: canon
source: ai
---

# guided setup runbook

**For: Agent**

**Bottom line:** Build a separate private vault, personalize it only after owner confirmation, create one repository per owner boundary, publish GitHub first and GitLab second, and prove recovery before closing onboarding.

**When to read this:** Read after the owner pastes `PROMPT-01-CREATE-MY-OS.md`. Continue until every gate passes or one honest blocker remains.

## experience standard

- Assume no coding, Git, repository, terminal, or backup knowledge.
- Explain purpose before mechanism and give one human step at a time.
- Perform safe inspection, file changes, validation, and repository work yourself.
- Pause for choices, sign-ins, two-factor enrollment, recovery-code storage, purchases, permissions, and external actions.
- Never request or handle passwords, one-time codes, recovery codes, tokens, API keys, private keys, or credentials.
- Never put credentials in a chat, file, command argument, commit, or Git URL.
- Show the phase marker throughout: “Phase 4 of 10 complete. Next: create the private GitHub repositories.”

## phase 0 — choose the root name

1. Read the files named in `PROMPT-01-CREATE-MY-OS.md`.
2. Confirm the current folder is the public Starter.OS source, not an existing personal vault.
3. Inspect the source Git status and run `ruby scripts/validate-starter-kit.rb`. Separate source defects from environment problems.
4. Ask exactly one question: “What would you like to replace STARTER with in STARTER.os?” Keep the `.os` ending. Do not choose for the owner.
5. After the owner answers, ask where the new `<NAME>.os` folder should live. Explain that it will be private and separate from this public repository.
6. Refuse a destination that is the public source, inside its `.git`, a non-empty unknown folder, a cloud-shared public location, or an existing vault.
7. Ask which file-capable agent surface is in use. Check current official privacy, file-access, and permissions guidance for that exact product and account before importing sensitive material.

## phase 1 — generate and open the vault shell

From the public kit, run:

```sh
ruby scripts/create-vault.rb /absolute/path/to/NAME.os
```

The script must create:

```text
NAME.os/
├── AGENTS.md
├── CLAUDE.md
├── biz/
├── life/
├── os/
└── setup/
```

Then:

1. Confirm `NAME.os` and `NAME.os/biz` contain no `.git`.
2. Confirm no repository exists yet in `os/` or `life/`; initial publication comes only after personalization and security review.
3. Set `os/starter-version.md` onboarding state to `in-progress`.
4. Open `NAME.os` as the agent workspace and as one Obsidian vault. The owner may need to approve folder access or switch workspaces.
5. Confirm exactly one `.obsidian/` folder exists at the vault root after Obsidian opens it.
6. Configure Obsidian's Templates folder as `os/templates` and Daily Notes folder as `life/records/daily`; use `os/templates/daily.md` when the owner wants daily notes.
7. Run `ruby os/validate-starter-os.rb`. Resolve kit-side failures before interviewing.

The root and `biz/` are permanent plain containers. Never initialize Git in either one.

## phase 2 — interview without editing

Follow `ONBOARDING-INTERVIEW.md` one section at a time.

Translate answers into four ownership levels:

- stable identity and shared collaboration preferences -> `os/me.md`
- current personal priorities and constraints -> `life/now.md`
- deeper personal context -> `life/knowledge/people/owner.md`
- business-specific purpose, state, boundaries, decisions, knowledge, and source -> `biz/<business>/`

Use the existing Life lanes before adding subfolders. A business idea, client mention, side interest, or hoped-for future project does not automatically justify a repository.

`biz/business-model/` is a visible generic example. It is not a real business, does not receive owner context, and never receives a Git remote. Keep it intact; the business helper copies it when the owner confirms a real business.

Do not edit during discovery.

## phase 3 — confirm and personalize

Present one plain-language package:

1. Stable identity and collaboration preferences.
2. Current state and important constraints.
3. Privacy, approval, archive, and publication boundaries.
4. Existing Life routes that cover the owner's context.
5. Each business repository that is genuinely needed now.
6. Import inventory and deferred privacy risks.
7. Exact files and repositories that will change.

Wait for the owner to correct the package and explicitly confirm accuracy. Then:

- personalize `os/me.md`, `life/now.md`, `life/knowledge/people/owner.md`, and the two knowledge maps;
- update `os/agent-rules.md`, `os/recovery.md`, and `os/integrations.md` only with confirmed choices;
- create each approved business by running `ruby setup/add-business.rb <lowercase-kebab-name>` from the generated vault root; it copies `biz/business-model/` into the new business;
- personalize that business's `readme.md`, `status.md`, `AGENTS.md`, `decisions.md`, and `knowledge-map.md` without inventing doctrine;
- keep agent-drafted or unconfirmed content `source: ai` and safely marked draft/reference;
- run `ruby os/validate-starter-os.rb` and resolve every failure.

Do not import bulk archives, recordings, exports, or unknown repositories during setup. Produce a later review manifest instead.

## phase 4 — create GitHub primary repositories

Explain that Git records history separately for each owner boundary. GitHub is the primary remote named `origin`.

### account security

Guide the owner through current GitHub account and two-factor authentication screens. The owner privately creates the password, enrolls an authenticator/passkey/security key, stores recovery methods outside the vault, and confirms completion without revealing codes.

Official references:

- https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-new-repository
- https://docs.github.com/en/authentication/securing-your-account-with-two-factor-authentication-2fa/configuring-two-factor-authentication-recovery-methods

### initialize one repository at a time

For `os/`, `life/`, and each approved `biz/<business>/`:

1. Audit the owning `.gitignore` and candidate files.
2. Run the security sweep. A real secret or unexplained private export blocks publication.
3. Initialize Git inside the repository root—not the vault root or `biz/`.
4. Use `main` as the initial branch unless the owner explicitly chooses another standard.
5. Create one clear local foundation commit.
6. Create a blank **private** GitHub repository with a neutral matching name. Do not initialize it with a README, license, or `.gitignore`.
7. Authenticate through the current browser/credential-manager flow; never put a token in a remote URL.
8. Add GitHub as `origin`, push the intended branch and any intended tags, and verify local and GitHub refs match.

Do not publish the next repository until the current repository's primary is verified.

## phase 5 — create GitLab backup mirrors

Explain that GitLab is the exact private ref mirror, not a competing source of truth. Its remote name is always `backup`.

Guide current account security and recovery-code storage privately. GitLab's current documentation may change; use:

- https://docs.gitlab.com/user/project/
- https://docs.gitlab.com/user/profile/account/two_factor_authentication/

For each repository:

1. Create a blank **private** GitLab project with the matching name. Do not initialize it with a README.
2. Add it as a separate remote named `backup`.
3. Confirm `origin` points only to GitHub and `backup` points only to GitLab.
4. Push the intended branch to `backup`, then push intended tags separately when the repository uses tags.
5. Compare local, `origin`, and `backup` branch/tag sets and commit IDs.

Use two remotes, not multiple push URLs on one remote. Git's documentation explicitly recommends separate remotes when fetching from one place and publishing to another: https://git-scm.com/docs/git-remote

## phase 6 — record the standing publication law

Ask whether the owner approves this standing workflow for completed future work:

1. Validate and inspect only the repositories changed by the task.
2. Create a clear commit in each changed repository.
3. Push GitHub `origin` first.
4. Only after GitHub succeeds, push GitLab `backup`.
5. Verify the intended local, GitHub, and GitLab refs match and the working tree is clean.

Record the confirmed rule in `os/agent-rules.md` and `os/recovery.md`.

If GitHub succeeds and GitLab fails, report partial parity as a blocker and retry the missing backup safely. Never call the wrap complete, force-push, rewrite history, delete refs, or use GitLab divergence to overwrite GitHub without explicit owner authorization.

## phase 7 — configure full-vault protection

Git does not protect the root `.obsidian/`, ignored attachments, safe local settings, or other deliberately untracked files. Configure a full-tree backup for the entire vault.

For a Mac, Carbon Copy Cloner or Time Machine can provide local versioned coverage. An encrypted offsite provider may add device-loss protection. The owner approves purchases and signs in privately.

Require:

1. The complete vault root is included—not only `os/` or `life/`.
2. The schedule matches the owner's real device/drive habits.
3. Version or snapshot retention is enabled when supported.
4. The first backup completes.
5. A harmless Markdown file is opened from the backup destination.
6. The tool, source, destination description, schedule, last success, last restore test, and gaps are recorded in `os/recovery.md` without secrets.

If required hardware or offsite access is missing, keep onboarding incomplete and name one next action.

## phase 8 — acceptance and recovery test

Run `ruby os/validate-starter-os.rb`, then verify:

- one Obsidian vault root, one `.obsidian/`, and no root or `biz/` Git repository;
- `os/`, `life/`, and every real business are independent repositories with no nested Git;
- private GitHub `origin` and private GitLab `backup` exist for each repo;
- all intended local, `origin`, and `backup` refs agree;
- working trees are clean;
- the security sweep finds no real secrets or inappropriate personal data in the public kit;
- `os/recovery.md` can rebuild the shell and repository set;
- the full-tree backup opens a real restored file.

For the strongest test, reconstruct the vault in a temporary location from GitHub, add/fetch GitLab backup remotes, restore the root pointers and `.obsidian/` from full-tree backup, run the validator, and compare the declared repository set. Never use the test restore to overwrite the live vault.

Give the owner a one-screen result: complete, incomplete, and one next action.

## phase 9 — tutorial and first real task

Set `os/starter-version.md` to `tutorial-pending`. Point the owner to `PROMPT-02-FIRST-WORKING-SESSION.md` and begin it in a fresh chat.

Do not call onboarding complete until the lessons and one small real task are finished and wrapped through the publication law.

## phase 10 — archive setup scaffolding

Run only when every earlier gate passes.

1. Create `life/records/sessions/YYYY-MM-DD-setup-completion.md` from `os/templates/setup-completion.md`.
2. Record the foundation ID, repositories created, agent surface, security confirmations, parity result, backup/restore result, archive destination, and deferred low-risk follow-ups. Never record credentials or recovery codes.
3. Move the entire root `setup/` folder to `life/archive/setup/YYYY-MM-DD/` without changing its archived contents.
4. Remove active setup routes from root pointers, `os/me.md`, `os/knowledge-map.md`, and `life/knowledge-map.md`.
5. Set `os/starter-version.md` onboarding state to `complete`.
6. Run the validator and security sweep.
7. Publish changed repositories separately: GitHub first, GitLab second.
8. Verify clean trees and exact intended ref parity.

The vault root should then contain only `.obsidian/`, `AGENTS.md`, `CLAUDE.md`, `biz/`, `life/`, and `os/`. The setup history remains preserved inside Life but is no longer current agent context.
