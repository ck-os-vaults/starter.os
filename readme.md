# Starter.OS

Starter.OS is a free repository brain for a private AI Chief of Staff. It starts empty and works for any owner. Your files hold the lasting information. You can change the AI, app, or computer without rebuilding the system.

## Start with one link

Copy this repository link and paste it into a file-capable agent:

**https://github.com/ck-os-vaults/starter-os-public**

That link is the whole starting prompt when the agent can read repository instructions, work in your private files, use Git, and run the included Ruby checking tools. The instructions help the agent determine whether you need:

1. a new Starter.OS setup;
2. a preserve-first migration from another system; or
3. an update to an existing Starter.OS.

The agent follows one simple process: **Protect → Review → Ask → Improve → Prove**. It saves the current state before changing it. It reviews your changes, asks only about real decisions, and checks that nothing was lost. [`setup/START-HERE.md`](setup/START-HERE.md) explains the process.

## What it creates

```text
name.os/
├── AGENTS.md
├── CLAUDE.md
├── os/       shared rules, the manual, skills, maps, and validation
├── life/     private personal context, projects, knowledge, and records
└── biz/      empty until a real business is created
```

The installed system does not include the public `setup/` folder. Ongoing guidance lives where it belongs, including the protected plain-language manual at `os/manual.md`.

The public repository keeps installation routes, release machinery, detailed licenses, and technical scripts together under `setup/`. They support the product but are not part of the owner's three-part working system.

## What the guided process handles

- discovers existing Git history, repositories, remotes, and uncommitted work;
- establishes one private hosted primary Git destination, guiding GitHub setup by default when none exists;
- configures any secondary Git service as an automatic mirror of the primary;
- preserves existing files before reorganizing or updating anything;
- validates the finished system and gives a recovery receipt;
- makes every real business folder its own private Git repository when that business is created;
- explains optional recurring workflows, checks what the owner's tools can actually support, and creates or updates only the routines the owner accepts.

Git is part of the fully protected standard path. GitHub is where Starter.OS is distributed and is the normal guided private primary for a new owner. An existing suitable GitLab or other hosted primary may be preserved when the owner prefers it. Local-only Git is an incomplete recovery state because it does not protect against device loss. Agents handle the technical Git work wherever possible and push only to the chosen primary.

The repository brain can run anywhere a capable agent can reach it. Setup, migration, and update need an environment that can work with files, Git, and the included Ruby tools. A persistent Chief of Staff also needs an always-available agent that can reach the files, schedule, sources, and destination. That agent may run locally or online. Starter.OS checks what the environment can actually do instead of forcing a local, cloud, or hybrid label.

## Agent and model independence

The repository is the product. It contains Markdown instructions, skills, templates, release records, and checking tools. Codex, ChatGPT, Claude, Hermes, Goose, and other file-capable agents can use the same files. Provider-specific files only point back to the shared rules. Owners may customize their private copy.

## Skills and automations

Portable workflows live in `os/skills/` and are classified in `os/skill-map.md`. Skills never run merely because they exist. Starter.OS includes optional recipes for a Morning Brief, a cited News Report, silent security monitoring, and cross-project reconciliation. They remain provider-neutral, require an explicit owner choice, and must be verified after creation or update.

## Privacy

This repository is a public blueprint. Never personalize it or add credentials. The guided process creates a separate private system. Do not use a public fork as the private working repository.

## Licenses

Software and scripts are available under the MIT License in [`setup/legal/LICENSE-CODE`](setup/legal/LICENSE-CODE). Documentation, the manual, Markdown skills, and templates are available under CC BY 4.0 in [`setup/legal/LICENSE-CONTENT`](setup/legal/LICENSE-CONTENT). See [`LICENSE`](LICENSE) for the boundary and attribution.

Permanent version history, current unreleased work, compatibility, limitations, update steps, and rollback guidance are in [`CHANGELOG.md`](CHANGELOG.md).

## Maintainers

Run `ruby setup/scripts/validate-starter-kit.rb` before publication. The release manifest and validators check clean installation, migration accounting, managed-file updates, protected manual behavior, local Git history, and privacy. Hosted primaries and mirrors are checked separately and reported in `os/recovery.md`.
