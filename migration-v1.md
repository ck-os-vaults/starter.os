---
type: note
created: 2026-08-11
updated: 2026-08-11
reviewed: 2026-08-11
status: living
authority: reference
source: ai
---

# migrate a version 1 edition

**Bottom line:** Version 1 is a single-repository vault. Version 2 changes ownership and backup boundaries, so migration must be reviewed and performed as a controlled move—not installed over the old vault.

**When to read this:** Read when an existing personal edition has `areas/`, `projects/`, `knowledge/`, `log/`, and `business/` at its root.

## target mapping

| version 1 | version 2 |
|---|---|
| `00_inbox/` | `life/00_inbox/` |
| `areas/` | `life/areas/` |
| `projects/` | `life/projects/` |
| `knowledge/` | `life/knowledge/` |
| `log/` | `life/records/` |
| `os/now.md` | `life/now.md` |
| `business/<name>/` | `biz/<name>/` as its own repository |
| `agent/templates/` | `os/templates/` |

## safe migration sequence

1. Stop normal edits and confirm the old repository is clean, private, pushed, and recoverable.
2. Run its existing validator and security sweep. Record failures before moving anything.
3. Create a new vault beside the old one with the current Starter.OS setup process.
4. Interview the owner only for changed or missing context. Do not overwrite approved identity with generic templates.
5. Produce one exact move manifest covering every active file, excluded file, business, archive, attachment folder, and unresolved item.
6. Obtain owner approval for the complete manifest.
7. Move approved material into the new ownership boundaries. Preserve the old edition unchanged as the rollback source.
8. Initialize and publish each new repository independently: GitHub `origin` first, GitLab `backup` second.
9. Restore the root `.obsidian/` configuration and other safe ignored files through the full-vault backup.
10. Run the new validator, open the vault in Obsidian, test a real restore, and verify ref parity before retiring the old working copy.

Do not automatically split an unknown personal vault. Ambiguous files stay in the old edition or enter a review manifest; they are never deleted.
