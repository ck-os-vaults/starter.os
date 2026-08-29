# Agent setup

> **Audience: Agent only.** The owner-facing entry is `START-HERE.md`. Do not ask the owner to follow this checklist or run these commands.

Create a useful private system without leaving scaffolding behind.

## 1. Inspect

Confirm this is the public Starter.OS checkout, its working tree is understood, and `ruby scripts/validate-starter-kit.rb` passes. Infer the private vault name, destination, owner context, real work boundaries, and repository needs before asking anything. Do not ask questions during this step.

## 2. Configure quickly

Follow `QUICK-SETUP.md`. Ask one compact group containing every essential choice that cannot be inferred safely, including the vault name and destination. Do not ask a second question group later. Do not create folders for interests, future possibilities, or assets that do not exist.

## 3. Preview and approve

Show the short approval card and exact destination. Let the owner rename the proposed COS, projects, and businesses. For a first-time owner without existing material, omit empty project, business, and file-assignment sections. Get approval before generating an unpersonalized private-vault preview. Create it in a new empty location with:

```sh
ruby scripts/create-vault.rb /absolute/path/to/NAME.os
```

The generated vault must contain only root pointers, `os/`, `life/`, and an empty `biz/` container. It must not contain `setup/`.

Show the generated root tree and list the exact files that personalization would change. Ask for one final confirmation that this preview should become the owner's active private system. This is an adoption gate, not another interview.

## 4. Adopt and personalize

Only after the adoption confirmation, update confirmed content:

- stable agent-facing context in `os/me.md`;
- current state in `life/now.md`;
- deeper background in `life/wiki/<owner>.md`;
- active personal projects through `scripts/add-project.rb`;
- real businesses through `scripts/add-business.rb`.

Add supporting files only when actual content or a proven recurring workflow requires them.

## 5. Validate and protect

Run `ruby os/validate-starter-os.rb`. Review files for secrets and unintended personal material. Initialize and publish only the approved repositories. Never initialize Git at the vault root or `biz/`.

Follow `GITHUB-SETUP.md` for repository connection or upgrade. GitHub is the canonical primary named `origin`. GitLab is an optional automatic downstream mirror, not a second routine agent push target. Configure it only when the owner chooses it, then push only to GitHub and verify that GitLab reaches the same commit automatically.

Configure a full-vault backup only when the owner chooses one. Report every recovery layer as `verified`, `configured but unverified`, or `owner declined`; never imply that a plan is working recovery.

## 6. Return the owner to work

Give this short orientation, personalized only where useful:

> Your COS is your main home base. Tell it the outcome you want in plain language; it will use the right project context, show a short plan before consequential work, and ask only when your decision or approval is truly needed. Project tasks keep their own routine work and reports, while your COS brings together only what affects the bigger picture. You can now return to your next real task.

Do not turn orientation into a course, exercise, or required first task. Do not create scheduled tasks by default. If the owner later approves one, its routine output stays in the owning project task; only material context is reconciled with the COS.

Setup is complete when the owner has adopted the preview, the private vault validates, its recovery status is truthful, the brief orientation is delivered, and no temporary setup content remains inside it.
