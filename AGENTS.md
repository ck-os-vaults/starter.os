# Starter.OS entry

Use the files below to tell whether this is the public product or someone's private system. Git alone does not answer that question.

## Public Starter.OS source

When this root contains `setup/release-manifest.json`, it is the reusable public product. Do not add personal context or treat this example as someone's live OS.

If an owner provides only the public Starter.OS repository link, start here. First confirm that you can read these instructions, work in the owner's private files, use Git, and run the included Ruby tools. Then read `readme.md` and `setup/START-HERE.md`, inspect the owner's current state without changing it, and choose the matching route:

- no existing Starter.OS installation -> `setup/AGENT-SETUP.md`
- an existing Starter.OS installation -> `setup/UPDATE.md`

An unrelated personal repository is not a third route and must not be converted in place. Leave it untouched, create the new private OS in an empty location, and offer to help the owner bring over selected context only after the new installation works.

Do not ask the owner to find or paste a longer setup prompt. If the route remains ambiguous after safe inspection, ask one plain question and continue.

New setup follows **Name → Protect → Create → Personalize → Prove**. Updates follow **Protect → Review → Ask → Improve → Prove**.

Do not change an existing installation during an update until the complete current state has a verified recovery route. Use `setup/QUICK-SETUP.md` for the shared process and approval card. Use `setup/GIT-SETUP.md` for Git protection.

Each owner route first runs `ruby setup/scripts/validate-source.rb` to confirm the current public copy is complete. Source maintainers run the full release test with `ruby setup/scripts/validate-starter-kit.rb`. Build and validate private systems in a separate location.

`.github/` contains maintainer-only distribution automation. It is not part of owner setup, update, Git protection, or mirroring. Never copy its credentials or force-push workflow into an owner's repositories.

## Private installed vault

When the root contains `os/release.json` but not `setup/release-manifest.json`, it is a private installed system. Its root `AGENTS.md` belongs to the owner and may be personalized. Read that file first, then follow its route to `os/AGENTS.md`, `os/me.md`, and the nearest `AGENTS.md` inside `life/` or `biz/<business>/`.

If neither marker exists, stop and identify the folder before treating it as Starter.OS.

Never store passwords, authentication tokens, recovery codes, private keys, seed phrases, or other secrets in the vault, chat, commands, commits, or remote URLs.
