# Starter.OS entry

This root has two possible roles.

## Public Starter.OS source

When this root contains `.git/`, it is the reusable public product. Do not add personal context or treat this example as someone's live OS.

If an owner provides only the public Starter.OS repository link, use it to begin when the agent can read these repository instructions and access or create the owner's private working repository. Read `readme.md` and `setup/START-HERE.md`, verify those capabilities, inspect the owner's current state read-only, and choose the matching route:

- no existing personal system -> `setup/AGENT-SETUP.md`
- migration from another personal system to preserve -> `setup/MIGRATE.md`
- an existing Starter.OS installation -> `setup/UPDATE.md`

Do not ask the owner to find or paste a longer setup prompt. If the route remains ambiguous after safe inspection, ask one plain question and continue.

Every route must discover the current Git setup before changing it. For a new owner without a suitable private hosted primary, guide secure GitHub account and private-repository setup as the normal protected path. Preserve an existing suitable hosted primary when the owner prefers it, treat secondary Git services as automatic mirrors, and suggest only recurring workflows that fit the owner's verified tools and needs. Use `setup/GIT-SETUP.md` for the shared repository contract and `setup/QUICK-SETUP.md` for the shared approval card.

Source maintainers run `ruby scripts/validate-starter-kit.rb`. Build and validate private systems in a separate location.

## Private installed vault

When the root does not contain `.git/`, read `os/AGENTS.md` first. Then follow the nearest `AGENTS.md` inside `life/` or `biz/<business>/`.

Never store passwords, authentication tokens, recovery codes, private keys, seed phrases, or other secrets in the vault, chat, commands, commits, or remote URLs.
