# Agent setup

Create a useful private system without leaving scaffolding behind.

## 1. Inspect

Confirm this is the public Starter.OS checkout, its working tree is understood, and `ruby scripts/validate-starter-kit.rb` passes. Ask what should replace `STARTER` in `STARTER.os` and where the private vault should live.

## 2. Configure quickly

Follow `QUICK-SETUP.md`. Infer from available context first. Ask only essential questions that cannot be answered safely, preferably in one compact group. Do not create folders for interests, future possibilities, or assets that do not exist.

## 3. Preview and approve

Show the short approval card and exact destination. Let the owner rename the proposed COS, projects, and businesses. Get approval before generating the private vault. Create it in a new empty location with:

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

## 6. Return the owner to work

Give this short orientation, personalized only where useful:

> Your COS is your main home base. Tell it the outcome you want in plain language; it will use the right project context, show a short plan before consequential work, and ask only when your decision or approval is truly needed. Project tasks keep their own routine work and reports, while your COS brings together only what affects the bigger picture. You can now return to your next real task.

Do not turn orientation into a course, exercise, or required first task. Do not create scheduled tasks by default. If the owner later approves one, its routine output stays in the owning project task; only material context is reconciled with the COS.

Setup is complete when the private vault validates, its recovery plan is truthful, the brief orientation is delivered, and no temporary setup content remains inside it.
