---
type: map
created: 2026-08-11
updated: 2026-08-11
reviewed: 2026-08-11
status: living
authority: canon
source: ai
---

# Starter.OS

**Bottom line:** Starter.OS is a public installation kit for creating a private, owner-controlled context system. The finished system is one Obsidian vault with separate Git repositories for shared operating rules, personal life, and each real business.

**When to read this:** Read for the product overview. New owners start at `setup/README.md`; operators start at `setup/OPERATOR-GUIDE.md`.

## the important distinction

This public repository is the **kit**, not the owner's vault. Do not use GitHub's **Use this template** button to create a personal edition: one template repository cannot reproduce the required repository boundaries.

The setup agent creates a separate private vault from `template/`:

```text
owner.os/                  one Obsidian vault; never a Git repository
├── os/                    shared operating repository
├── life/                  private personal repository
└── biz/                   plain container; never a Git repository
    └── <business>/        one repository for each real business
```

The vault root contains only one `.obsidian/` folder, thin `AGENTS.md` and `CLAUDE.md` pointers, and temporary `setup/` material during onboarding.

## begin

- New user: `setup/README.md` -> `setup/PROMPT-01-CREATE-MY-OS.md`
- Setup helper: `setup/OPERATOR-GUIDE.md`
- Existing version 1 owner: `migration-v1.md`
- Contributor: run `ruby scripts/validate-starter-kit.rb`

## operating model

- `os/` owns identity, shared rules, maps, retrieval, recovery, templates, and routines.
- `life/` owns current personal state, areas, projects, knowledge, and the permanent record.
- `biz/<business>/` owns that business's documents, decisions, status, knowledge, and implementation source.
- The root and `biz/` are containers, never repositories.

Every intended repository uses GitHub `origin` as primary and GitLab `backup` as an exact private ref mirror. Publication goes to GitHub first, then GitLab. A wrap is complete only when the changed repository is clean and local, GitHub, and GitLab refs agree.

## privacy boundary

The reusable kit contains no owner's personal context. Each installed edition belongs in private repositories. Never merge private identity, health, financial, client, family, credential, or business information back into this public repository.
