---
type: manual
created: 2026-08-30
updated: 2026-09-03
reviewed: 2026-09-03
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

When your agent supports persistent tasks, use one main Chief of Staff home and one home for each real project. Routine work and scheduled reports stay with their project. The Chief receives only updates that change your priorities or need your attention.

The Chief is a role, not a special model. Many capable agents can fill it.

## Where things live

`os/` holds the shared rules, this manual, reusable skills, maps, and safety checks.

`life/` holds your private personal information, current priorities, personal projects, knowledge, documents, and records.

`biz/` holds real businesses. It stays empty until you actually need one. Each business becomes its own private Git repository when it is created.

A project gets one clear home. A business gets one clear home. The system avoids duplicate copies of the same truth.

## The words you will see

**Agent.** The AI tool doing the work.

**Model.** The AI engine inside an agent. A model can change without changing your files.

**Chief of Staff.** Your main coordinating agent role.

**Project.** Work with a real outcome, status, and next action.

**Skill.** A saved method for work you may repeat. A skill does nothing until a real task calls for it.

**Automation.** A task that runs on a schedule after you approve it.

**Integration.** A connection to another app or service.

**Git.** File history. It lets you see changes and return to an earlier version.

**Repository.** A folder whose history Git tracks.

**Primary.** The one Git location agents push to.

**Mirror.** An automatic second copy of the primary on another Git service.

**Commit.** A named checkpoint in Git history.

**Validation.** A check that the system is complete and follows its rules.

**Recovery point.** A verified place you can return to if a change goes wrong.

**Local.** Work that runs on your computer.

**Cloud.** Work that runs on another company's computers.

**Fork.** Your own customized version of a file that Starter.OS normally updates.

## Git and backup in plain language

Git is part of the fully protected Starter.OS setup.

Git on your computer protects you from bad edits because it keeps history. It does not protect you if the computer is lost or damaged.

GitHub is the normal guided choice for a new owner because it keeps a private copy away from your computer. If you already use GitLab or another suitable service, you can keep it. The agent should handle the technical Git work wherever possible. You privately handle account sign-in, multifactor authentication, and recovery codes. You use one primary, and agents push only there.

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

**Morning Brief.** Prepares you for the day using the calendar, tasks, project status, and week ahead that you have authorized. It ends with a few short questions so your Chief of Staff knows what changed.

**News Report.** Follows sources you choose. It cites them, explains what changed, tells you why it matters, and recommends whether to adopt, test, watch, or ignore it.

**System Security Watch.** Runs a read-only check. It stays quiet when every check finishes and finds nothing meaningful. It reports real risks and tells you when it could not finish a check. It never fixes or installs anything by itself.

**Task Reconciliation.** Collects important changes across projects for a Morning Brief or a checkpoint you request. It does not create another report by default.

These are recipes, not required services or fixed schedules. Your agent first checks which scheduler, sources, destinations, and permissions actually exist. You may adopt, decline, or defer each option. A recurring run should return to its existing home base when possible instead of creating a new task every time.

## Agents, models, and apps

Starter.OS does not require Codex, ChatGPT, Claude, Hermes, Goose, or any other single agent.

The shared Markdown files are the product. Agent-specific files should only point back to those shared rules.

Different agents have different abilities. One may read local files, another may work in the cloud, and another may create scheduled tasks. Your agent should say what it can verify and what remains unavailable. It should never pretend a connection or automation works merely because it was configured.

## Where it can run

Starter.OS can work on your computer, in the cloud, or through both. You do not need to choose a technical label during setup.

The agent checks what it can actually do. Scheduled work needs an always-available agent with access to the right files, sources, and destination. Ordinary on-demand work does not.

If the same file changes in two places, the agent must stop and show both versions instead of silently choosing one.

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

**Setup.** Creates a new private Starter.OS in an empty location.

**Migration.** Brings another system into Starter.OS. Your old system stays untouched. A full redesign happens only if you choose it.

**Update.** Improves an existing Starter.OS. Your files stay yours. After approval, Starter.OS may replace one of its own files if you have not changed it. If you did change it, you choose whether to keep your version, replace it, or wait.

Migration and update use five simple steps:

1. **Protect.** Make sure the complete current system can be restored.
2. **Review.** Understand what Starter.OS should improve and what you customized.
3. **Ask.** Ask you only about real conflicts or important choices.
4. **Improve.** Make the reviewed changes without silently replacing your work.
5. **Prove.** Confirm nothing was lost and show how to return to the old state.

The agent first inspects without changing anything. It then verifies Git and creates a separate local recovery copy for anything Git does not cover. That copy stays outside the working OS and is not treated as current information.

A large customized agent-instruction file is never blindly replaced or reduced to a summary. The agent preserves the original, keeps useful personal meaning, moves each rule to the right home, and asks only when two instructions genuinely conflict.

All three paths explain compatible new workflows and let you adopt, decline, or defer them without changing working customizations silently.

The public `setup/` folder is only for installation. It is not copied into your private system. An agent may remove a temporary public copy after setup or update only when you approved the exact cleanup and it proved that the copy contains no personal work. Future updates begin from the current public GitHub link. Product-maintenance copies and your old system during migration stay intact.

## Validation and recovery

Validation checks whether required files exist, skills are registered, protected rules are present, local Git history is readable, links work, and files contain patterns that look like exposed secrets. It does not contact GitHub, GitLab, another backup, or a scheduler. Your agent checks those separately and records what it actually verified. A passing check is useful evidence. It cannot rule out every privacy or security risk.

Recovery means returning to a verified earlier state. Before a major change, your agent should identify the exact Git commit and any extra local recovery copy needed. After the change, it should give you a short receipt with the version, validation result, protection status, and rollback route.

## This manual is protected

This file explains the product. It does not own every operating rule. If it conflicts with `AGENTS.md`, a current project rule, or your current direct instruction, the controlling source wins and the mismatch should be reported.

An agent may not casually edit this file. If you want a personalized explanation, create an owner-owned fork such as `life/manual.md` and route agents to it from `me.md`. Starter.OS keeps the current product manual here so future updates can still explain what changed.

## When you are unsure

Ask your Chief:

> Explain this using the Starter.OS manual and tell me the one next thing I need to decide.

That is enough.
