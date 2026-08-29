---
type: map
created: 2026-08-29
updated: 2026-08-29
reviewed: 2026-08-29
status: draft
authority: canon
source: ai
---

# recovery

**Bottom line:** Rebuild the plain vault shell, restore each declared repository, restore safe non-Git files from backup, and verify the result.

**When to read this:** During setup, backup checks, device migration, loss, or a restore test.

## Topology

- Local vault path: confirm during onboarding
- Primary computer: confirm during onboarding
- Full-vault backup: confirm during onboarding
- Last restore test: unverified

| Local path | Purpose | Primary remote | Optional mirror | Visibility |
|---|---|---|---|---|
| `os/` | shared operating system | confirm | optional | private |
| `life/` | personal context | confirm | optional | private |

Add one row for every real `biz/<business>/`. Never record secrets or embedded-token URLs.

## Restore

1. Create the plain vault root and `biz/` container without Git.
2. Restore or clone each declared repository into its exact path.
3. Restore root pointers, `.obsidian/`, and safe ignored files from the full-vault backup.
4. Open the vault and run `ruby os/validate-starter-os.rb`.
5. Verify every configured remote and backup layer from actual state.

Git does not protect ignored files, local app state, credentials, caches, or anything never committed. A recovery layer is not trusted until a harmless restore succeeds.
