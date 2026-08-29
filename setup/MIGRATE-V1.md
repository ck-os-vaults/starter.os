# Migrate an existing system

Migration is a controlled redesign, not an automated cleanup. Keep the existing system intact until the replacement is proven.

## Agent contract

1. Read the current system's `AGENTS.md` files and repository status.
2. Inventory all active files, repositories, untracked material, external integrations, and recovery coverage without changing anything.
3. Classify each item as current truth, durable history, project-owned material, retained document, obsolete scaffolding, duplicate, secret risk, or unresolved.
4. Map current truth into the Starter.OS 2 structure.
5. Flag older Starter.OS conventions including `00_inbox`, `areas`, internal archives, session handoffs, generic business models, copied setup folders, default maintenance schedules, and duplicated skills.
6. Present an exact keep, move, combine, create, and remove plan. Include recovery evidence and unresolved items. Wait for approval.
7. Generate a separate 2.0 preview. Never overwrite the live vault.
8. Migrate only approved material. Do not invent current facts or business doctrine.
9. Run both the installed-vault validator and repository checks. Compare the preview against the approved manifest.
10. Present the validated preview and remaining gaps. Cutover, deletion, repository publication, and automation changes are separate approvals.

## Default mapping

| Earlier location | Starter.OS 2 destination |
|---|---|
| current personal priorities | `life/now.md` |
| durable owner background | `life/wiki/<owner>.md` |
| active personal work | `life/projects/<project>/<project>.md` |
| retained unowned document | `life/documents/` only when one actually exists |
| durable personal decision | `life/records/decisions.md` |
| real business | independent `biz/<business>/` repository |
| obsolete or duplicated material | remove only after approval and verified recovery |

Do not create an archive inside the new system merely to preserve the old layout. The untouched original, Git history, and verified backup provide migration recovery.
