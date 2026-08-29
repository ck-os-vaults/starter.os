# Agent setup

Create a useful private system without leaving scaffolding behind.

## 1. Inspect

Confirm this is the public Starter.OS checkout, its working tree is understood, and `ruby scripts/validate-starter-kit.rb` passes. Ask what should replace `STARTER` in `STARTER.os` and where the private vault should live.

## 2. Discover

Follow `ONBOARDING.md`. Do not edit during discovery. Do not create folders for interests, future possibilities, or assets that do not exist.

## 3. Preview and approve

Show the completed confirmation package and exact destination. Get approval before generating the private vault. Create it in a new empty location with:

```sh
ruby scripts/create-vault.rb /absolute/path/to/NAME.os
```

The generated vault must contain only root pointers, `os/`, `life/`, and an empty `biz/` container. It must not contain `setup/`.

## 4. Personalize

Update only confirmed content:

- stable agent-facing context in `os/me.md`;
- current state in `life/now.md`;
- deeper background in `life/wiki/<owner>.md`;
- active personal projects through `scripts/add-project.rb`;
- real businesses through `scripts/add-business.rb`.

Add supporting files only when actual content or a proven recurring workflow requires them.

## 5. Validate and protect

Run `ruby os/validate-starter-os.rb`. Review files for secrets and unintended personal material. Initialize and publish only the approved repositories. Never initialize Git at the vault root or `biz/`.

GitHub is the recommended primary named `origin`. Configure a second remote and full-vault backup only when the owner chooses them. Verify any configured recovery layer rather than assuming it works.

## 6. Prove the workflow

Complete one small real task. Demonstrate project ownership, an appropriate approval gate, validation, and repository closeout. Do not create scheduled tasks by default. If the owner later approves one, its routine output stays in the owning project task; only material context is reconciled with Chief.

Setup is complete when the private vault validates, its recovery plan is truthful, the first task works, and no temporary setup content remains inside it.
