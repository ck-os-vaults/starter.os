# Starter.OS entry

This root has two possible roles.

## Public source checkout

When this root contains `.git/`, it is the reusable Starter.OS source. Do not add personal context. Read `readme.md`, then:

- new installation: `setup/START-HERE.md` then `setup/AGENT-SETUP.md`
- existing-system migration: `setup/MIGRATE-V1.md`
- source maintenance: `scripts/validate-starter-kit.rb`

Build and validate private systems in a separate location. Never treat the public example as someone's live OS.

## Private installed vault

When the root does not contain `.git/`, read `os/AGENTS.md` first. Then follow the nearest `AGENTS.md` inside `life/` or `biz/<business>/`.

Never store passwords, authentication tokens, recovery codes, private keys, seed phrases, or other secrets in the vault, chat, commands, commits, or remote URLs.
