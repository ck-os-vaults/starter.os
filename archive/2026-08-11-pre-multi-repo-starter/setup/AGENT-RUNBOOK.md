---
type: map
created: 2026-08-03
updated: 2026-08-11
reviewed: 2026-08-11
status: living
authority: canon
source: ai
---

# guided setup runbook

**Audience:** Agents
**Lifecycle:** Setup only — archive with the entire `setup/` folder after onboarding.

**Bottom line:** Agent-only instructions for taking a nontechnical owner from an empty starter to a personalized, validated, secure, redundantly backed-up context system. The owner speaks naturally and completes private browser steps; the agent handles the machinery.

**When to read this:** Read after the owner pastes the prompt from `setup/FIRST-CHAT.md`. Continue until every completion gate is satisfied or one physical blocker is named honestly.

## experience standard

- Assume zero coding, Git, terminal, repository, or backup knowledge.
- Explain the purpose before the mechanism: “private online history,” not “remote ref,” unless the owner asks.
- Give one small human step at a time. Wait after sign-in, two-factor, recovery-code, purchase, or browser-approval steps.
- Perform safe commands, file edits, validation, and diagnostics yourself.
- Do not dump command output or jargon on the owner. Translate the result.
- Never request or handle passwords, one-time authentication codes, recovery codes, secret keys, or private tokens.
- Never put credentials in the vault, chat, commit, shell history, or remote URL.
- Do not weaken privacy to make setup easier.
- Keep a visible phase marker: “Phase 3 of 8 complete. Next: secure GitHub.”

## phase 0 — orient and check

1. Read the startup and setup files named in `setup/FIRST-CHAT.md`.
2. Set the onboarding state in `os/starter-version.md` to `in-progress` after the owner confirms setup should begin.
3. Confirm this is the intended vault root and inspect whether Git already exists, whether a remote exists, whether there are uncommitted files, and whether any nested folder is an independent repository.
4. Run `ruby os/validate-starter-os.rb`. Separate starter defects from owner-created material.
5. Ask what agent surface the owner is using: Codex, Claude Code, Claude Cowork, or another file-capable agent. Do not require them to understand the distinction yet.
6. Explain that different agent products may process files locally, remotely, or both. Before importing sensitive material, check the current official privacy and data-handling guidance for the exact product and account plan being used. Do not guess from an older interface or product name.
7. Check whether Obsidian is installed, whether the folder opens as one vault, and whether the owner has a password manager or another secure recovery-code location.
8. Ask whether an external backup drive is available. Record the answer; do not derail the interview.

Explain the system in under two minutes: these files are durable context; the agent reads only what the task needs; GitHub and GitLab keep two locked online histories; a daily drive backup protects files that are intentionally excluded from Git.

## phase 1 — interview for context

Follow `setup/ONBOARDING-INTERVIEW.md` one section at a time.

The goal is to fill the existing context system, not redesign it. Translate answers into four levels:

- stable identity and collaboration preferences → `os/me.md`
- current priorities, constraints, decisions, and anchors → `os/now.md`
- deeper personal or professional background → `knowledge/people/owner.md`
- task-to-context routes → `knowledge-map.md`

Use the existing `areas/`, `projects/`, `business/`, and `knowledge/` lanes. Add a folder only when a real recurring responsibility, business, time-bound project, or knowledge domain cannot be routed clearly without it. Do not create a folder for every interest, document source, or imagined future agent.

Do not edit during the interview.

## phase 2 — confirm and personalize

Present a plain-language context summary containing:

1. Who the owner is and what they want help with.
2. How the agent should collaborate with them.
3. Current priorities and important constraints.
4. Privacy, permission, and high-stakes boundaries.
5. The existing folders that will hold their work.
6. Any truly necessary structural adjustment, with one-sentence reasoning.
7. The exact files that will change.

Ask the owner to correct the summary and say when it is accurate. After approval:

- personalize `os/me.md`, `os/now.md`, `knowledge/people/owner.md`, and `knowledge-map.md`;
- update environment and backup choices in `os/vault-map.md` and `os/recovery.md`;
- create only justified project, area, business, or topic folders;
- leave unconfirmed statements `source: ai` and `status: draft`;
- mark owner-confirmed context with the owner source value;
- run the validator and resolve every starter-side failure.

## phase 3 — secure the GitHub copy

Describe GitHub as the first private online history: it stores the safe tracked portion of the vault off the computer and makes earlier versions recoverable.

### account and two-factor security

If the owner needs an account, guide the current GitHub browser flow one click at a time. The owner creates the password and keeps it private.

Guide the owner to GitHub **Settings → Password and authentication** and:

- enable two-factor authentication using an authenticator app, passkey, or security key;
- add a second authentication method when practical;
- save recovery codes in the password manager and, ideally, one secure offline location;
- confirm completion without revealing any code.

Do not proceed to upload until the owner confirms the repository will be private and recovery codes are stored outside the vault.

### repository setup

1. Audit `.gitignore` and the exact candidate files. Exclude credentials, account-recovery files, local app state, caches, transient attachments, large recordings, and independent nested repositories.
2. Run `security-sweep` and the validator. A real secret blocks the upload.
3. If this is already the owner's private template repository, verify ownership and visibility. If not, create a new **private** repository with a neutral name. Do not initialize a conflicting README when importing an existing history.
4. Prefer browser-based authentication through the official GitHub CLI or the system credential manager. The owner completes browser approval; never ask for a token in chat.
5. Preserve existing starter history, create one clear personalization checkpoint, connect GitHub as the fetch source, and push the current branch.
6. Verify the remote says Private and that its branch points to the same commit as the local vault.

## phase 4 — secure the GitLab copy and make both pushes travel together

Describe GitLab as the second locked online history, hosted by a different company. Its purpose is redundancy, not a second working location.

### account and two-factor security

Guide the owner through the current GitLab.com account flow. Under **Edit profile → Access → Password and authentication**:

- configure an authenticator or WebAuthn/passkey-capable device;
- save the one-time recovery codes in the password manager and a secure offline location;
- confirm completion without sharing codes.

### matching private repository

1. Create a blank **private** GitLab project with the same neutral repository name. Do not add a README, license, or starter commit.
2. Authenticate through SSH, OAuth credential management, or the official GitLab CLI—whichever is already available and safest on the machine. Keep tokens out of files, chat, command arguments, and remote URLs.
3. Keep GitHub as the normal fetch location. Configure the existing Git remote with two push URLs: one for GitHub and one for GitLab. Git supports multiple push URLs; an ordinary push to that remote then goes to both services.
4. Inspect existing push URLs before changing them and avoid duplicates. Do not use destructive mirror pushes.
5. Push the current branch and relevant tags. Verify local, GitHub, and GitLab branch commit IDs are identical.
6. Ask whether the owner approves this standing rule: after meaningful completed work, the agent validates, creates a clear checkpoint, and pushes once so both online histories stay synchronized. Record the answer in `os/agent-rules.md` and `os/recovery.md`.

### agent implementation note

Do not make the owner type these commands. Adapt and run them only after checking the existing remote configuration and replacing the examples with the two verified private repository URLs:

```sh
git remote -v
git config --get-all remote.origin.pushurl
git remote set-url --add --push origin <github-repository-url>
git remote set-url --add --push origin <gitlab-repository-url>
git config --get-all remote.origin.pushurl
git push origin <current-branch>
```

Keep GitHub as `remote.origin.url` for ordinary fetching. Add the two push URLs only when they are absent; repeated `--add` commands create duplicates. Do not put access tokens in either URL. After pushing, verify the current branch commit independently on both services. Push tags separately only when the repository actually uses tags.

If one service accepts a push and the other fails, say plainly that the backups are temporarily out of sync. Diagnose the failure, retry the missing destination, and re-check all three commit IDs before calling the wrap complete.

## phase 5 — configure the daily local backup

Explain that GitHub and GitLab protect document history, but they deliberately omit passwords, local app settings, transient attachments, and large media. A daily local backup covers the whole vault folder.

On a Mac, recommend Carbon Copy Cloner as the guided example; Time Machine or another reputable local backup tool is acceptable when it meets the same result.

The owner must approve any purchase. Then guide them to:

1. Connect a dedicated external drive with enough space.
2. Create a task that includes the entire Starter.OS vault folder.
3. Set it to run daily, or when the destination drive reconnects if that is more reliable for their routine.
4. Enable snapshot/version retention when the destination and tool support it.
5. Run the first backup now.
6. Open a harmless copied Markdown file from the destination to prove the backup is readable.
7. Record the tool, source, destination description, schedule, last successful test date, and recovery steps in `os/recovery.md`—never a drive-encryption password or account credential.

If no drive is available, finish the context and online-history phases but label local backup **incomplete**. Give one next action: obtain or choose the drive. Do not describe the full backup system as complete.

## phase 6 — acceptance test

Verify all of the following:

- The owner can explain that the vault is their durable context and the agent is a replaceable tool.
- `ruby os/validate-starter-os.rb` passes.
- No starter owner names, unconfirmed claims, credentials, or recovery codes are tracked.
- The local working tree is clean after the approved checkpoint.
- GitHub is private and two-factor authentication is confirmed.
- GitLab is private and two-factor authentication is confirmed.
- Local, GitHub, and GitLab show the same current branch commit.
- A normal approved wrap pushes to both destinations.
- The local daily backup completed and a file was opened from it, or the physical blocker is named as incomplete.
- `os/recovery.md` accurately distinguishes tracked files from full-folder backup coverage.

Give the owner a one-screen result: complete, incomplete, and the one next action if anything remains.

## phase 7 — hand off to learning and real use

Point the owner to `setup/POST-SETUP-TUTORIAL.md`. Offer to start it in a fresh chat so setup mechanics do not consume the tutorial's context.

Before handing off, set the onboarding state in `os/starter-version.md` to `tutorial-pending`. The tutorial is part of onboarding; do not call the entire process finished yet.

End with three everyday facts:

1. Put uncertain material in `00_inbox/`.
2. Start with a conversation about the problem instead of chasing a perfect prompt.
3. Ask the agent to wrap meaningful work so the context and both online histories stay current.

## phase 8 — remove the setup scaffolding

Run this phase only after all security and backup completion gates pass, the owner has completed the post-setup tutorial, and the tutorial's small real task has been wrapped successfully. If GitHub and GitLab are out of sync, the local backup remains incomplete, or the tutorial is unfinished, leave the setup documents active and state the one next action.

The purpose is to keep future agents focused on the owner's real context. Archiving preserves history; it does not delete it.

### create the completion record first

Create `log/setup-completion.md` from `agent/templates/setup-completion.md`. Record only:

- completion date;
- foundation ID and private edition name;
- chosen agent application;
- whether GitHub, GitLab, two-factor security, dual-push synchronization, daily local backup, and restore test passed;
- the dated archive location;
- any intentionally deferred import or low-risk follow-up.

Do not record account recovery codes, credentials, private repository tokens, drive passwords, or unnecessary account identifiers.

### archive the temporary folder

Move the entire `setup/` folder to `archive/setup/YYYY-MM-DD/`. Keep its internal filenames and structure intact so the initialization history remains understandable. Do not copy individual setup documents back into active folders.

Keep `SYSTEM-EXPLAINED.md`, `os/starter-version.md`, `os/recovery.md`, and the reusable operating rules active. They still help with everyday understanding, upgrades, and recovery.

### remove obsolete active routes

Before this runbook moves itself:

1. Replace the starter-focused root `readme.md` with a short owner-focused map of the active Starter.OS system and remove its link to `setup/`.
2. Remove the first-setup and post-setup-learning routes from `knowledge-map.md`; add `log/setup-completion.md` only as a historical setup route.
3. Remove the temporary setup-folder entry from `os/readme.md`.
4. Update `AGENTS.md`, `CLAUDE.md`, and the startup note in `os/me.md` so they say onboarding is complete and do not point future agents to active setup files.
5. Remove any remaining active links to `setup/`.
6. Set both the frontmatter `onboarding` value and visible onboarding state in `os/starter-version.md` to `complete`.
7. Add `log/setup-completion.md` to `log/readme.md`.

Then move the entire folder, run `ruby os/validate-starter-os.rb`, run the security sweep, and confirm active maps contain no `setup/` routes. Create the approved final checkpoint and verify both online histories reached it.

Give the owner a short closing message: onboarding is complete, setup materials were preserved in the dated archive, where the completion record lives, and what file future agents read first. Do not ask the owner to manage or delete the archived files.

## official references for current UI and behavior

- GitHub two-factor recovery: https://docs.github.com/en/authentication/securing-your-account-with-two-factor-authentication-2fa/configuring-two-factor-authentication-recovery-methods
- GitHub private repository creation: https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-new-repository
- GitLab two-factor authentication: https://docs.gitlab.com/user/profile/account/two_factor_authentication/
- Git multiple push URLs: https://git-scm.com/docs/git-config#Documentation/git-config.txt-remoteltnamegtpushurl
- Carbon Copy Cloner scheduling: https://support.bombich.com/hc/en-us/articles/20686449773847-How-to-schedule-a-backup
- OpenAI prompt guidance: https://developers.openai.com/api/docs/guides/prompt-guidance-gpt-5p6
- Claude Code best practices: https://code.claude.com/docs/en/best-practices
- Claude Code model configuration: https://code.claude.com/docs/en/model-config
- Claude Cowork getting started: https://support.claude.com/en/articles/13345190-get-started-with-claude-cowork

Interfaces change. If a current screen differs, use the current official documentation and explain the updated path instead of guessing.
