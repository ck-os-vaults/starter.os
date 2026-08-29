# Owner setup: start here

Starter.OS gives you one private workspace where a Chief of Staff can coordinate personal projects and businesses without mixing their ownership or loading unnecessary context. The system calls this role the COS until you choose a name.

**Public Starter.OS repository:** [github.com/ck-os-vaults/starter.os](https://github.com/ck-os-vaults/starter.os)

**This is the main setup file for the owner.** The only other owner-facing page is [`GITHUB-SETUP.md`](GITHUB-SETUP.md), used when GitHub needs to be connected or an existing GitHub and GitLab setup needs to be upgraded. The remaining files in `setup/` are instructions for the agent. You do not need to run scripts, design folders, or study the system yourself.

Your part is short: choose one path below, paste its prompt into a file-capable agent, answer one compact question group if needed, and approve or rename the proposed structure and preview. The agent inspects, designs, builds, migrates, and validates the system.

## Owner path 1: create a new system

Open this repository in your file-capable agent. **Copy and paste these exact words into the agent's prompt:**

> Read `AGENTS.md` and `setup/AGENT-SETUP.md`. Help me create my private Starter.OS. Show me the proposed name, location, file map, and repository plan before making changes.

The agent will infer what it can, ask one compact group of essential naming or boundary questions, and show one short approval card before creating a separate unpersonalized preview. A final confirmation activates and personalizes that preview; it is not a second interview.

## Owner path 2: redesign an existing system

Migration is a complete system redesign built beside your current vault. Your current vault remains untouched. You do not need to read the migration instructions; the agent does.

Open this repository in your file-capable agent. **Copy and paste these exact words into the agent's prompt:**

> Read `AGENTS.md` and `setup/MIGRATE-V1.md`. Find my current personal OS or vault on this computer without changing it. Show me the exact source path and wait for my confirmation before treating it as the migration source. Then redesign it as a separate Starter.OS 2 system. Infer what you can, ask only essential questions, let me rename and approve the proposed COS, projects, and businesses, and never change or delete anything in my current vault.

Migration uses the same two short gates: approve the proposed structure, then inspect and approve the generated preview before any copied material becomes the new active system.

## Optional repository connection

If GitHub is not connected, or if agents currently push separately to both GitHub and GitLab, use [`GITHUB-SETUP.md`](GITHUB-SETUP.md). It provides an exact prompt for each situation. GitHub remains canonical; GitLab is an optional automatic mirror rather than a second agent push target.

## What remains yours

You handle sign-ins, purchases, recovery codes, and secret values privately. An agent may use an already authorized credential system, but should never ask you to paste secrets into chat or store them in the vault.
