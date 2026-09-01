---
type: manual
created: 2026-08-30
reviewed: 2026-09-01
status: living
authority: reference
source: starter-os
---

# How Starter.OS works

**This is the simple manual.** It is for you first and your agent second.

An agent may read this file, explain it, and point you to a section. It may not rewrite or personalize this file during normal work. Starter.OS updates it only through the protected update process.

## Starter.OS in one minute

Starter.OS is a set of folders and plain files that help an AI understand how you work.

Your files hold the lasting truth. The AI is a helper that reads those files and acts on your requests. You can change the AI, model, app, or computer without rebuilding the whole system.

You own the files, accounts, backups, and decisions.

## Your Chief of Staff

Your main AI helper is called the Chief of Staff, or Chief for short. You can give it another name.

Start there when you are unsure where work belongs. Tell it the outcome you want in ordinary language. It should:

- find the right information;
- keep project work with its project;
- show a short plan before important changes;
- ask when it needs your decision or approval;
- bring you only the most important updates.

When your agent supports persistent tasks, use one main Chief of Staff home base and one home base for each real project. Routine project work and scheduled reports stay with that project. The Chief of Staff receives only the headlines that change your priorities or need your attention.

The Chief is a role, not a special model. Many capable agents can fill it.

## Where things live

`os/` holds the shared rules, this manual, reusable skills, maps, and safety checks.

`life/` holds your private personal information, current priorities, personal projects, knowledge, documents, and records.

`biz/` holds real businesses. It stays empty until you actually need one.

A project gets one clear home. A business gets one clear home. The system avoids duplicate copies of the same truth.

## The words you will see

**Agent:** The AI tool doing the work.

**Model:** The AI engine inside an agent. A model can change without changing your files.

**Chief of Staff:** Your main coordinating agent role.

**Project:** Work with a real outcome, status, and next action.

**Skill:** A saved step-by-step method for work you may repeat. A skill does nothing until a real task triggers it.

**Automation:** A task that runs on a schedule after you approve it.

**Integration:** A connection to another app or service.

**Git:** File history. It lets you see changes and return to an earlier version.

**Repository:** A folder whose history Git tracks.

**Primary:** The one Git location agents push to.

**Mirror:** An automatic second copy of the primary on another Git service.

**Commit:** A named checkpoint in Git history.

**Validation:** A check that the system is complete and follows its rules.

**Recovery point:** A verified place you can return to if a change goes wrong.

**Local:** Work that runs on your computer.

**Cloud:** Work that runs on another company's computers.

**Fork:** Your own intentionally customized version of a Starter.OS-managed file.

## Git and backup in plain language

Git is part of the fully protected Starter.OS setup.

Git on your computer protects you from bad edits because it keeps history. It does not protect you if the computer is lost or damaged.

GitHub is the normal guided choice for a new owner because it gives you an off-device private copy. If you already use GitLab or another suitable service, you can keep it. The agent should handle the technical Git work wherever possible; you privately handle account sign-in, multifactor authentication, and recovery codes. You use one primary, and agents push only there.

If you want another Git service too, it becomes an automatic mirror of the primary. The agent does not push separately to both. This prevents the two copies from quietly drifting apart.

Git does not automatically include every ignored, untracked, hidden, or external file. Before an important change, your agent must tell you what is and is not covered.

See `recovery.md` for your actual protection status.

## Skills

Skills are recipes for repeated work. They live in `skills/` and are listed in `skill-map.md`.

Some skills are part of normal safe operation. Some are optional. Some can become scheduled routines. Some are only adapters for a particular agent or app.

Having a skill does not mean it runs automatically. The trigger must be real, and actions still follow your approval boundaries.

You can add, change, or remove skills in your private system. If you change a Starter.OS-managed skill, the next update should treat it as a conflict or an explicit fork, not silently overwrite it.

## Optional recurring workflows

Starter.OS includes portable recipes you can adopt when they fit your tools and life:

**Morning Brief** prepares you for the day from the calendar, tasks, project state, and week ahead that you have authorized. It ends with a few short questions so your Chief of Staff understands what changed.

**News Report** follows sources you choose. It uses citations, explains the news in plain language, tells you why it matters, and recommends whether to adopt, test, watch, or ignore it.

**System Security Watch** performs a read-only integrity check. It stays quiet when complete checks find nothing meaningful, reports real risk, and tells you when coverage was incomplete. It never fixes or installs anything by itself.

**Task Reconciliation** distills meaningful cross-project changes for a Morning Brief or an explicit checkpoint. It is not another report you must read by default.

These are recipes, not required services or fixed schedules. Your agent first checks which scheduler, sources, destinations, and permissions actually exist. You may adopt, decline, or defer each option. A recurring run should return to its existing home base when possible instead of creating a new task every time.

## Agents, models, and apps

Starter.OS does not require Codex, ChatGPT, Claude, Hermes, Goose, or any other single agent.

The shared Markdown files are the product. Agent-specific files should only point back to those shared rules.

Different agents have different abilities. One may read local files, another may work in the cloud, and another may create scheduled tasks. Your agent should say what it can verify and what remains unavailable. It should never pretend a connection or automation works merely because it was configured.

## Local, cloud, and hybrid work

**Local-first** means most work happens on your computer.

**Cloud-first** means most work happens in a hosted service. The hosted agent still needs verified access to your private repository and every source or destination its work requires.

**Local-on-demand** means cloud work is normal and the computer is used only for tasks that need local files or apps.

**Hybrid** combines local and cloud work.

These names are simple descriptions, not choices you must make during setup and not promises that an environment supports everything. Setup checks what the agent can actually do: access and update the private repository, remain available when needed, schedule work, reach required sources, deliver to a stable home base, and verify Git protection.

The repository brain can be useful on demand without an always-on computer. A full persistent Chief of Staff—with scheduled briefs, monitoring, and cross-project reconciliation—needs an always-available runtime with all required access. That runtime may be local or hosted. No route is automatically best. The important rule is that your durable files and chosen Git primary stay clear. If the same file changes in two places, the agent must stop and show both versions instead of silently choosing the newest one.

## What an agent may do

An agent may normally read files, explain the system, inspect current state, and perform safe work inside a scope you already approved.

It should ask before:

- changing the system's structure;
- publishing or sending anything;
- creating accounts, repositories, tasks, or automations;
- changing visibility, access, or settings;
- spending money;
- deleting unique information;
- using private information outside its approved home;
- making another important real-world commitment.

Before a consequential change, it should show the smallest useful plan and the recovery route.

## Setup, migration, and update

**Setup** creates a new private Starter.OS in an empty location.

**Migration** brings another system into Starter.OS. It preserves first. Your old system stays untouched, and a full redesign happens only if you choose it.

**Update** improves an existing Starter.OS. Owner files stay yours. An unchanged managed file may update automatically after approval. A locally changed managed file becomes a choice: keep your version as a fork, replace it with Starter.OS, or defer.

All three paths begin by discovering Git. They explain compatible new workflows and let you adopt, decline, or defer them without changing working customizations silently.

The public `setup/` folder is only the installation doorway. It is not copied into your private system.

## Validation and recovery

Validation checks whether required files exist, skills are registered, protected rules are present, links resolve, and obvious secret-shaped values are absent. A passing check is evidence, not a promise that every private or security risk is impossible.

Recovery means returning to a verified earlier state. Before a major change, your agent should identify the exact Git commit and any extra backup needed. After the change, it should give you a receipt with the version, files changed, validation result, primary and mirror commits, automation status, and rollback route.

## This manual is protected

This file explains the product. It does not own every operating rule. If it conflicts with `AGENTS.md`, a current project rule, or your current direct instruction, the controlling source wins and the mismatch should be reported.

An agent may not casually edit this file. If you want a personalized explanation, create an owner-owned fork such as `life/manual.md` and route agents to it from `me.md`. Starter.OS keeps the current product manual here so future updates can still explain what changed.

## When you are unsure

Ask your Chief:

> Explain this using the Starter.OS manual and tell me the one next thing I need to decide.

That is enough.
