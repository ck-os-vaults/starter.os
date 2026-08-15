---
type: map
created: 2026-08-11
updated: 2026-08-15
reviewed: 2026-08-15
status: living
authority: canon
source: ai
---

# guided setup runbook

**For: Agent**

**Bottom line:** Build a separate private vault, personalize it only after owner confirmation, create one repository per owner boundary, publish under the shared Git publication law, and prove recovery before closing onboarding.

**When to read this:** Read after the owner pastes `PROMPT-01-CREATE-MY-OS.md`. Continue until every gate passes or one honest blocker remains.

## experience standard

- Assume no coding, Git, repository, terminal, or backup knowledge.
- Explain purpose before mechanism and give one human step at a time.
- Perform safe inspection, file changes, validation, and repository work yourself.
- Pause for choices, sign-ins, two-factor enrollment, recovery-code storage, purchases, permissions, and external actions.
- Never request or handle passwords, one-time codes, recovery codes, tokens, API keys, private keys, or credentials.
- Never put credentials in a chat, file, command argument, commit, or Git URL.
- Show the phase marker throughout: “Phase 4 of 11 complete. Next: create the private GitHub repositories.”

## phase 0 — choose the root name

1. Read the files named in `PROMPT-01-CREATE-MY-OS.md`.
2. Confirm the current folder is the public Starter.OS source, not an existing personal vault.
3. Check that Obsidian is installed and run `ruby --version`. If Ruby is missing, explain that it runs the kit's local setup and validation helpers, then guide the owner through the current trusted installation route for their operating system. Do not use an unreviewed installer or elevated permissions without owner approval.
4. Inspect the source Git status and run `ruby scripts/validate-starter-kit.rb`. Separate source defects from environment problems.
5. Ask exactly one question: “What would you like to replace STARTER with in STARTER.os?” Keep the `.os` ending. Do not choose for the owner.
6. After the owner answers, ask where the new `<NAME>.os` folder should live. Explain that it will be private and separate from this public repository.
7. Refuse a destination that is the public source, inside its `.git`, a non-empty unknown folder, a cloud-shared public location, or an existing vault.
8. Ask which file-capable agent surface is in use. Check current official privacy, file-access, and permissions guidance for that exact product and account before importing sensitive material.

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
3. Set `setup/STARTER-VERSION.md` onboarding state to `in-progress`.
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

`biz/business-model/` is the visible first-business model. It is not a real business and does not receive owner context or a Git remote under that generic name. Once the owner confirms the first real business, rename the model before personalizing it.

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
- rename the first confirmed business by running `ruby setup/add-business.rb <lowercase-kebab-name>` from the generated vault root; it renames `biz/business-model/` to `biz/<lowercase-kebab-name>/`;
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

## phase 5 — configure automatic GitLab backup mirrors

Explain that GitHub is canonical and GitLab is its automatic read-only downstream backup for people. Its recovery remote name is `backup`; agents never push to it directly.

Guide current account security and recovery-code storage privately. GitLab's current documentation may change; use:

- https://docs.gitlab.com/user/project/
- https://docs.gitlab.com/user/profile/account/two_factor_authentication/

For each repository:

1. Create a blank **private** GitLab project with the matching name. Do not initialize it with a README.
2. Add it as a separate remote named `backup`.
3. Confirm `origin` points only to GitHub and `backup` points only to GitLab.
4. Add `.github/workflows/gitlab-mirror.yml` using the public Starter.OS workflow as the pattern and replace only the GitLab repository URL.
5. Guide the owner through creating a GitLab project access token with the **Maintainer** role and only the **write_repository** scope. The owner handles the displayed value privately.
6. Guide the owner through saving that value in the matching GitHub repository as the Actions secret `GITLAB_MIRROR_TOKEN`. Never request, view, or handle the token.
7. Run `github-to-gitlab-mirror` manually from GitHub Actions and require its branch-and-tag verification step to succeed.

Use two remotes, not multiple push URLs on one remote. Git's documentation explicitly recommends separate remotes when fetching from one place and publishing to another: https://git-scm.com/docs/git-remote

## phase 6 — record the standing publication law

Ask whether the owner approves this standing workflow for completed future work:

1. Validate and inspect only the repositories changed by the task.
2. Create a clear commit in each changed repository.
3. Push only GitHub `origin`.
4. Confirm the automatic mirror Action succeeds and the working tree is clean.

Record the confirmed rule in `os/agent-rules.md` and `os/recovery.md`.

If the mirror Action fails, report the blocker and repair the workflow, repository-scoped token, or GitLab permission from GitHub. Never bypass it with a direct GitLab push.

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

## phase 9 — verify the everyday Git workflow

1. Read `os/skills/git-sync-preflight.md` and `os/skills/eod-wrap.md`.
2. In one relevant repository, demonstrate a clean start-of-work preflight:
   fetch GitHub and verify local/GitHub parity without changing history.
3. Explain the cloud boundary: a hosted cloud chat may update GitHub, but the
   local pull remains pending until a local session verifies it.
4. Confirm that meaningful completed file changes use repository closeout:
   validate, inspect, commit, follow the shared publication law, and verify a
   clean state. Full personal/project wrap happens only when requested
   or required by project instructions.
5. Ask whether the owner wants recurring vault maintenance. If no, record that
   maintenance is on demand. If yes, create one native scheduled task targeting
   the saved vault root and following `os/skills/vault-maintenance.md`; read the
   saved task back and record its safe configuration in `os/integrations.md`.
6. Do not create cron jobs, background daemons, frequent polling, or duplicate
   reminders.

## phase 10 — tutorial and first real task

Set `setup/STARTER-VERSION.md` to `tutorial-pending`. Point the owner to `PROMPT-02-FIRST-WORKING-SESSION.md` and begin it in a fresh chat.

Do not call onboarding complete until the lessons and one small real task are finished and wrapped through the publication law.

## phase 11 — archive setup scaffolding

Run only when every earlier gate passes.

1. Create `life/records/sessions/YYYY-MM-DD-setup-completion.md` from `setup/SETUP-COMPLETION.md`.
2. Record the foundation ID, repositories created, agent surface, security confirmations, parity result, backup/restore result, archive destination, and deferred low-risk follow-ups. Never record credentials or recovery codes.
3. Set `setup/STARTER-VERSION.md` onboarding state to `complete`.
4. Move the entire root `setup/` folder to `life/archive/setup/YYYY-MM-DD/` without changing its archived contents.
5. Remove active setup routes from root pointers, `os/me.md`, `os/knowledge-map.md`, and `life/knowledge-map.md`.
6. Run the validator and security sweep.
7. Publish changed repositories separately under the shared Git publication law.
8. Verify clean trees and successful publication.

The vault root should then contain only `.obsidian/`, `AGENTS.md`, `CLAUDE.md`, `biz/`, `life/`, and `os/`. The setup history remains preserved inside Life but is no longer current agent context.
