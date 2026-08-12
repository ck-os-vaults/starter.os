---
type: map
created: 2026-08-03
updated: 2026-08-11
reviewed: 2026-08-11
status: draft
authority: canon
source: ai
---

# recovery

**Bottom line:** Personalized during setup, this file explains the three-layer backup system and how the owner or a future agent can restore Starter.OS without storing any passwords or recovery codes here.

**When to read this:** Read for account setup, backup checks, a new computer, accidental loss, or a restore test.

## backup layers

Fill during setup:

1. **Working copy:** local Starter.OS vault path and primary computer.
2. **Private online history 1:** GitHub private repository name or URL.
3. **Private online history 2:** GitLab private repository name or URL, synchronized from the same approved push.
4. **Daily local backup:** tool, destination description, schedule, and last successful restore test.

Do not store passwords, two-factor codes, recovery codes, tokens, private keys, or drive-encryption passwords here. State that they live in the owner's password manager without naming their values.

## what the online histories protect

GitHub and GitLab protect tracked Markdown and other approved repository files, including version history. They do not automatically include files excluded by `.gitignore`.

Expected exclusions include:

- local Obsidian and agent application state
- credentials, environment files, keys, tokens, and recovery-code downloads
- transient inbox attachments
- large recordings and external corpus media
- temporary and operating-system files
- independently versioned nested repositories, which need their own remote backup

The daily local backup should cover the entire vault folder, including safe files intentionally excluded from Git. Credentials should still live in a password manager, not ordinary backup folders.

## restore from a new computer

Personalize exact names and paths during setup:

1. Install Git, Obsidian, and the owner's chosen agent application.
2. Sign in to GitHub using the owner's private recovery methods.
3. Clone the private GitHub repository to the chosen vault location.
4. If GitHub is unavailable, clone the matching GitLab repository instead.
5. Restore excluded safe files and local app settings from the daily local backup when needed.
6. Restore any independently versioned nested repositories separately.
7. Open the Starter.OS root as one Obsidian vault.
8. Run `ruby os/validate-starter-os.rb` and open `os/me.md` to verify the startup chain.

## synchronization check

At each meaningful approved wrap:

- validate the vault;
- inspect the changes;
- create one clear local checkpoint;
- push through the configured dual-destination remote;
- verify GitHub and GitLab reached the same commit when a push reports any error.

Record whether the owner approved this as a standing workflow:

- Standing dual-push approval: **unconfirmed during starter state**

## backup-health check

- [ ] GitHub repository is private and current.
- [ ] GitLab repository is private and at the same commit.
- [ ] Two-factor authentication remains enabled on both accounts.
- [ ] Recovery methods are accessible outside this vault.
- [ ] Daily local backup is running.
- [ ] The latest backup can open a real Markdown file.
- [ ] A full test restore has been completed within the owner's chosen interval.

## current setup record

To be filled without secrets:

- Local vault:
- GitHub repository:
- GitLab repository:
- Local backup tool:
- Backup destination description:
- Schedule:
- Last successful backup:
- Last restore test:
- Known exclusions or incomplete steps:
