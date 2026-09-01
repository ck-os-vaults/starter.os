---
type: recovery
created: 2026-08-29
updated: 2026-09-01
reviewed: 2026-09-01
status: draft
authority: canon
source: ai
---

# recovery

**Bottom line:** Git history is required protection for normal changes; an off-device primary and independent backup close different recovery gaps.

**When to read this:** Before setup, migration, update, structural change, publication, device replacement, or restore work.

## Repository protection

| Repository | Local path | Primary | Primary commit | Mirror | Mirror commit | Status | Checked |
|---|---|---|---|---|---|---|---|

Each repository has one primary. Agents push only to it. A secondary Git service is an automatic downstream mirror of the primary and is verified only when it reaches the same commit.

Use:

- `verified`;
- `configured but unverified`;
- `incomplete; device loss not covered`;
- `owner declined`;
- `unavailable`.

GitHub is the normal guided primary for new owners. An existing suitable GitLab or other hosted primary may be preserved when the owner prefers it. Local-only Git is an incomplete recovery state, not a completed standard setup. Do not record credential-bearing URLs.

## Additional recovery layers

| Layer | Scope | Location | State | Last restore proof | Checked |
|---|---|---|---|---|---|
| Git working history | tracked files in each repository | repositories above | unverified |  |  |
| Off-device primary | committed repository content | providers above | unverified |  |  |
| Automatic Git mirror | second committed copy | providers above | unverified |  |  |
| Full-file backup | untracked, ignored, hidden, and non-repository content | confirm during setup | unverified |  |  |
| Credential recovery | access needed to restore services | approved credential manager | unverified |  |  |

A planned layer is not a working backup. A successful upload is not a restore test. Say exactly what is uncovered.

## Before a meaningful change

1. Run repository preflight.
2. Identify tracked, untracked, ignored, hidden, and external content.
3. Create and read back the approved commit in the working repository.
4. Verify the primary has that commit when one exists.
5. Verify every enabled mirror has the same commit.
6. Add a separate recovery point for anything the Git commit does not cover.
7. Explain the exact restore route before mutation.

## Restore order

1. Stop writes and identify the exact failed change.
2. Preserve the current failed state for inspection when safe.
3. Restore the affected repository from the named pre-change commit.
4. Restore uncovered content from the named full-file backup.
5. Recover service access through the credential manager, never from the vault.
6. Run `validate-starter-os.rb`.
7. Verify the primary and mirrors again before resuming work.

Never claim recovery is complete from a clean current folder alone.
