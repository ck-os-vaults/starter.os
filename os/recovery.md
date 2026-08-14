---
type: map
created: 2026-08-11
updated: 2026-08-14
reviewed: 2026-08-14
status: draft
authority: canon
source: ai
related:
  - "[[vault-map]]"
  - "[[integrations]]"
---

# recovery

**Bottom line:** Rebuild the plain vault shell, clone each declared repository, restore the one Obsidian configuration and safe ignored files, then prove GitHub/GitLab parity before trusting the result.

**When to read this:** During setup, backup checks, device migration, accidental loss, or a restore test.

## personalized topology

Fill without secrets:

- Local vault path:
- Primary computer:
- Full-vault local backup tool and destination description:
- Encrypted offsite backup/sync and coverage:
- Last successful backup:
- Last tested restore:
- Known exclusions or blockers:
- Optional maintenance agent/application:
- Optional maintenance task name and schedule:
- Maintenance vault-root target:
- Last verified maintenance-task state:

Repository registry:

| local path | purpose | GitHub `origin` | GitLab `backup` | visibility | default branch |
|---|---|---|---|---|---|
| `os/` | shared operating system | fill during setup | fill during setup | private | `main` |
| `life/` | personal context | fill during setup | fill during setup | private | `main` |

Add one row for each real `biz/<business>/`. Never record credentials, embedded-token URLs, recovery codes, private keys, or passwords.

## restore from zero

1. Install Git, Ruby, Obsidian, and the chosen file-capable agent.
2. Create the plain vault shell and `biz/` container. Do not initialize Git at either root.
3. Clone the GitHub `origin` repositories into their exact declared paths.
4. Add each matching GitLab URL as remote `backup`.
5. Restore root `AGENTS.md` and `CLAUDE.md` from `os/templates/` if missing.
6. Restore `.obsidian/`, safe ignored attachments, and other non-Git files from the full-vault backup.
7. Open the vault root in Obsidian.
8. Recreate the one local `Weekly OS maintenance` scheduled task from
   `os/skills/vault-maintenance.md` when it is not restored by the agent
   application. Target the saved vault root, then read the task back and verify
   its weekly schedule, time zone, enabled state, and prompt.
9. Run `ruby os/validate-starter-os.rb` and the verification gates below.

If GitHub is unavailable, clone the verified GitLab mirror, name it `backup`, then add GitHub as `origin` before the next publication. Never use unverified backup divergence to overwrite primary history.

## Git does not restore

- root `.obsidian/` themes, plugins, snippets, hotkeys, and workspace state;
- ignored attachments and safe local app state;
- credentials and environment secrets, which come from the password manager/provider;
- dependencies, caches, and generated build output, which should be regenerated;
- anything never committed or covered by full-vault backup.

## verification gates

- The root and `biz/` have no `.git`.
- `os/`, `life/`, and each declared business have exactly one repository and no nested repositories.
- One `.obsidian/` exists at the root.
- Each working tree is clean and on the intended branch.
- Intended branches and tags match local, GitHub `origin`, and GitLab `backup`.
- `ruby os/validate-starter-os.rb` passes.
- Active navigation resolves without loading archived or setup material as current context.
- Exactly one enabled `Weekly OS maintenance` task targets the vault root and
  follows `os/skills/vault-maintenance.md`.
- A real ignored file can be opened from the full-vault backup.

Standing publication approval: **unconfirmed during starter state**.

An untested backup is a hypothesis. Record the latest scratch-restore result here after testing.
