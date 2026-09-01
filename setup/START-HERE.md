# Start here

Starter.OS gives you a private repository brain and a Chief of Staff without making you design the system yourself.

## The one-link start

Paste this link into a file-capable AI agent:

**https://github.com/ck-os-vaults/starter.os**

The link is the whole normal starting prompt when the agent can read repository instructions and access or create your private working repository. The root `AGENTS.md` tells the agent to verify those capabilities, inspect first, and guide the correct route:

1. **New setup** when you do not have a personal system yet.
2. **Migration** when you have another system whose files must be preserved.
3. **Update** when you already use Starter.OS.

If your agent cannot read the repository or cannot work with a private repository, it should name that limitation and help you move to a capable environment. If it can access the repository but does not follow its instructions from the link, use this fallback sentence:

> Read the root `AGENTS.md` in this Starter.OS repository and guide me through the correct owner path.

## What happens in every path

The agent will:

1. inspect your current files, Git repositories, remotes, backups, and existing automations without changing them;
2. tell you which route applies and explain the proposed result in plain language;
3. ask one compact group of questions only when an important choice cannot be inferred safely;
4. show a short approval card before creating, moving, replacing, publishing, or scheduling anything;
5. protect the current state with Git and any additional recovery coverage that is actually needed;
6. make only the approved changes;
7. validate the result and show a completion and rollback receipt.

You do not need to run commands, design folders, understand Git, or read the agent-only setup files.

## Git protection

Git version history is part of the fully protected Starter.OS path. The agent first finds out whether you already have Git and how it is configured.

GitHub is the normal guided primary for a new owner. If you do not already have a suitable private Git service, the agent helps you create and secure a GitHub account, create private repositories, and verify the first protected version before setup is complete. You handle sign-in, multifactor authentication, recovery codes, and secret values privately; the agent handles the technical Git work wherever possible.

If you already use GitLab or another suitable private Git host, the agent can preserve it as your primary when you prefer. Local-only Git may be used temporarily to create a recovery point, but it is incomplete protection because it does not protect you if the computer is lost or damaged.

If you use a second Git service, the agent configures it as an automatic mirror from the primary. The agent pushes only to the primary and verifies that the mirror reaches the same commit.

## Optional recurring workflows

Starter.OS can suggest a Morning Brief, a cited News Report, silent security monitoring, and cross-project reconciliation. They are starting points, not required services or fixed schedules.

The agent first checks what your current tools, scheduler, sources, and destinations can actually support. It then explains only compatible options in plain language. You may adopt, decline, or defer each one. Existing equivalents are updated instead of duplicated, and recurring output returns to an existing home base when possible instead of creating a new task every time.

## What remains yours

You approve names, privacy, repositories, publication, automations, structural changes, and anything consequential. You handle sign-ins, purchases, recovery codes, and secret values privately. An agent may use an already authorized credential system, but it must never ask you to paste secrets into chat or store them in the OS.

After installation, the simple owner manual is `os/manual.md`. The agent can use it to explain the system but may not rewrite it during ordinary work.
