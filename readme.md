# Starter.OS

Starter.OS is a free, person-agnostic repository brain for a private AI Chief of Staff. Your files are the durable source of truth. Models, agents, apps, and computers are replaceable ways to work with them.

## Start with one link

Copy this repository link and paste it into a file-capable agent:

**https://github.com/ck-os-vaults/starter.os**

That is the whole normal starting prompt when the agent can read repository instructions and access or create your private working repository. The instructions tell the agent how to determine whether you need:

1. a new Starter.OS setup;
2. a preserve-first migration from another system; or
3. an update to an existing Starter.OS.

The agent will inspect first, explain the plan in plain language, and wait for approval before consequential changes. [`setup/START-HERE.md`](setup/START-HERE.md) explains the same process if you want to read it yourself.

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

## What the guided process handles

- discovers existing Git history, repositories, remotes, and uncommitted work;
- establishes one private hosted primary Git destination, guiding GitHub setup by default when none exists;
- configures any secondary Git service as an automatic mirror of the primary;
- preserves existing files before reorganizing or updating anything;
- validates the finished system and gives a recovery receipt;
- explains optional recurring workflows, checks what the owner's tools can actually support, and creates or updates only the routines the owner accepts.

Git is part of the fully protected standard path. GitHub is where Starter.OS is distributed and is the normal guided private primary for a new owner. An existing suitable GitLab or other hosted primary may be preserved when the owner prefers it. Local-only Git is an incomplete recovery state because it does not protect against device loss. Agents handle the technical Git work wherever possible and push only to the chosen primary.

The repository brain can run anywhere a capable agent can access it. A full persistent Chief of Staff workflow additionally needs an always-available runtime with repository, scheduling, source, and stable delivery access. That runtime may be local or hosted. Starter.OS checks actual capabilities instead of forcing a local, cloud, or hybrid label, and it calls an environment fully supported only after the complete path is tested.

## Agent and model independence

The portable product is the repository itself: Markdown instructions, skills, templates, manifests, and deterministic tools. Codex, ChatGPT, Claude, Hermes, Goose, and other file-capable agents can use the same foundation. Provider-specific files are thin adapters, not the source of truth. Owners are encouraged to customize or fork their private copy.

## Skills and automations

Portable workflows live in `os/skills/` and are classified in `os/skill-map.md`. Skills never run merely because they exist. Starter.OS includes optional recipes for a Morning Brief, a cited News Report, silent security monitoring, and cross-project reconciliation. They remain provider-neutral, require an explicit owner choice, and must be verified after creation or update.

## Privacy

This repository is a public blueprint. Never personalize it or add credentials. The guided process creates a separate private system. Do not use a public fork as the private working repository.

## Licenses

Software and scripts are available under the MIT License in [`LICENSE-CODE`](LICENSE-CODE). Documentation, the manual, Markdown skills, and templates are available under CC BY 4.0 in [`LICENSE-CONTENT`](LICENSE-CONTENT). See [`LICENSE`](LICENSE) for the boundary and attribution.

Permanent version history, current unreleased work, compatibility, limitations, update steps, and rollback guidance are in [`CHANGELOG.md`](CHANGELOG.md).

## Maintainers

Run `ruby scripts/validate-starter-kit.rb` before publication. The release manifest and validators cover clean installation, migration accounting, managed-file updates, protected manual behavior, and privacy checks.
