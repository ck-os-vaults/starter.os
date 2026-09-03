# Start here

Starter.OS gives you a private repository brain and a Chief of Staff without making you design the system yourself.

## The one-link start

Paste this link into a file-capable AI agent:

**https://github.com/ck-os-vaults/starter-os-public**

The link is the entire starting prompt when the agent can read repository instructions, work in your private files, use Git, and run the included Ruby checking tools. The root `AGENTS.md` tells the agent to check those abilities, inspect first, and guide the correct route:

1. **New setup** when you do not have a personal system yet.
2. **Migration** when you have another system whose files must be preserved.
3. **Update** when you already use Starter.OS.

If your agent cannot read the repository, work with private files, use Git, or run the included Ruby tools, it should say so and help you move to an environment that can. If it can read the repository but does not follow the instructions, use this fallback sentence:

> Read the root `AGENTS.md` in this Starter.OS repository and guide me through the correct owner path.

## What happens in every path

The agent follows five simple steps:

1. **Protect.** Inspect everything first, then verify that the complete current state can be restored before changing it.
2. **Review.** Compare the current system with Starter.OS and understand personal changes instead of treating them as clutter.
3. **Ask.** Handle obvious safe choices and ask you only about real conflicts or important decisions.
4. **Improve.** Make only the reviewed and approved changes.
5. **Prove.** Confirm nothing was lost, validate the result, and give you the exact recovery route.

After success, the agent may remove an approved temporary installer only after proving it contains no owner work. A product-maintenance checkout stays intact.

You do not need to run commands, design folders, understand Git, or read the agent-only setup files.

An update or migration cannot move past **Protect** until the agent verifies Git recovery and a separate local recovery copy for anything Git does not cover. The recovery copy stays outside the working OS so it cannot be mistaken for current information.

## Git protection

Git version history is part of the fully protected Starter.OS path. The agent first finds out whether you already have Git and how it is configured.

GitHub is the normal guided primary for a new owner. If you do not already have a suitable private Git service, the agent helps you secure a GitHub account, create private repositories, and verify the first protected version. You handle sign-in, multifactor authentication, recovery codes, and secret values privately. The agent handles the technical Git work wherever possible.

If you already use GitLab or another suitable private Git host, the agent can preserve it as your primary when you prefer. Local-only Git may be used temporarily to create a recovery point, but it is incomplete protection because it does not protect you if the computer is lost or damaged.

If you use a second Git service, the agent configures it as an automatic mirror from the primary. The agent pushes only to the primary and verifies that the mirror reaches the same commit.

## Optional recurring workflows

Starter.OS can suggest a Morning Brief, a cited News Report, silent security monitoring, and cross-project reconciliation. They are starting points, not required services or fixed schedules.

The agent first checks what your tools, scheduler, sources, and destinations can support. It explains only the options that will work. You may adopt, decline, or defer each one. The agent updates an existing routine instead of creating a duplicate. Recurring output returns to an existing home when possible.

## What remains yours

You approve names, privacy, repositories, publication, automations, structural changes, and other important actions. You handle sign-ins, purchases, recovery codes, and secret values privately. An agent may use a credential system you already approved. It must never ask you to paste secrets into chat or store them in Starter.OS.

After installation, the simple owner manual is `os/manual.md`. The agent can use it to explain the system but may not rewrite it during ordinary work.

Your private system never keeps the public `setup/` folder. For a future update, paste the current GitHub link again so the agent uses fresh instructions.
