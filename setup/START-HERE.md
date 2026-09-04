# Start here

Starter.OS gives you a private repository brain and a Chief of Staff without making you design the system yourself.

## The one-link start

Paste this link into a file-capable AI agent:

**https://github.com/ck-os-vaults/starter-os-public**

The link is the entire starting prompt when the agent can read repository instructions, work in your private files, use Git, and run the included Ruby checking tools. The root `AGENTS.md` tells the agent to check those abilities, inspect first, and guide one of two routes:

1. **New installation** when you do not already use Starter.OS.
2. **Update** when you already use Starter.OS.

Another personal repository is not converted into Starter.OS. The agent creates your new OS in an empty location and leaves the old repository untouched. After the new system works, you may ask the agent to bring over only the context you still want.

If your agent cannot read the repository, work with private files, use Git, or run the included Ruby tools, it should say so and help you move to an environment that can. If it can read the repository but does not follow the instructions, use this fallback sentence:

> Read the root `AGENTS.md` in this Starter.OS repository and guide me through the correct owner path.

## New installation

The agent follows five simple steps:

1. **Name.** Choose the name and empty location for your private system.
2. **Protect.** Confirm the public source is genuine and make sure any old material stays safe and separate.
3. **Create.** Build the small `os/`, `life/`, and `biz/` structure and establish private Git protection.
4. **Personalize.** Give the system your working preferences and only the optional routines you accept.
5. **Prove.** Validate the result and show you where everything lives.

## Update

An update follows **Protect → Review → Ask → Improve → Prove**. The agent saves the complete current state, reviews your customizations, asks only about real conflicts, applies the approved changes, and proves nothing was lost.

After success, the agent may remove an approved temporary installer only after proving it contains no owner work. A product-maintenance checkout stays intact.

You do not need to run commands, design folders, understand Git, or read the agent-only setup files.

An update cannot move past **Protect** until the agent verifies Git recovery and a separate local recovery copy for anything Git does not cover. The recovery copy stays outside the working OS so it cannot be mistaken for current information.

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
