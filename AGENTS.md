# Starter.OS root

This root supports two states.

## public source checkout

If this root contains `.git/`, treat it as the public Starter.OS source. Do not add personal context. Read `readme.md`, then use:

- new installation: `setup/README.md` -> `setup/SETUP-STATUS.md` -> `setup/AGENT-RUNBOOK.md`
- source maintenance: `readme.md` -> `scripts/validate-starter-kit.rb`

The visible `biz/`, `life/`, and `os/` folders are the reusable source structure. Create the owner's private vault separately.

## private installed vault

If this root does not contain `.git/`, read `os/AGENTS.md` first and follow the boot chain in `os/me.md`. Then follow the nearest repository-level `AGENTS.md` inside `life/` or a business.

Never place passwords, security codes, recovery codes, tokens, API keys, private keys, or other credentials in chat, files, commands, commits, or remote URLs.
