---
type: map
created: 2026-08-29
updated: 2026-08-29
reviewed: 2026-08-29
status: living
authority: canon
source: ai
---

# vault map

**Bottom line:** One Obsidian vault contains shared operating context in `os/`, the owner's personal world in `life/`, and independently owned businesses in `biz/`.

**When to read this:** Read before creating, moving, renaming, removing, or changing a repository boundary.

```text
name.os/                 plain vault container; never a Git repository
├── os/                  shared OS repository
├── life/                personal repository
└── biz/                 plain container; never a Git repository
    └── <business>/      one repository for each confirmed real business
```

The root also contains `.obsidian/` when used with Obsidian and thin `AGENTS.md` and `CLAUDE.md` pointers.

## Routing

| Material | Owner |
|---|---|
| shared operating context or portable workflow | `os/` |
| current personal state | `life/now.md` |
| durable personal knowledge | `life/wiki/` |
| active personal work | `life/projects/<project>/` |
| retained personal document without a project or business owner | `life/documents/` |
| durable personal decision | `life/records/decisions.md` |
| business material and implementation | `biz/<business>/` |
| obsolete material | remove after approval and verified recovery |

Do not create a catch-all inbox. If ownership is unclear, ask whether the item belongs to an existing project, a new project, Wiki, Documents, or a business. Do not create empty categories for possible future material.
