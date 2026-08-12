---
type: note
created: 2026-08-11
updated: 2026-08-11
reviewed: 2026-08-11
status: living
authority: reference
source: ai
---

# install Starter.OS

**For: New User**

**Bottom line:** Install the two apps, download Starter.OS, open its folder in an agent, and paste the first prompt. The agent checks the one technical helper, asks what should replace `STARTER` in `STARTER.os`, and creates that private root with `biz/`, `life/`, and `os/` inside it.

**When to read this:** Read before the first setup conversation.

## five steps

1. Install the ChatGPT desktop app with Codex—or another agent that can read and edit a local folder—and install Obsidian.
2. Download or clone the public Starter.OS repository.
3. Open the downloaded folder in your agent.
4. Open [`PROMPT-01-CREATE-MY-OS.md`](PROMPT-01-CREATE-MY-OS.md), copy the prompt, and paste it into the agent.
5. Follow one step at a time.

Do not personalize the downloaded public folder. The setup agent makes the separate private copy for you.

Current official Codex setup: https://learn.chatgpt.com/docs/quickstart

Obsidian download: https://obsidian.md/download

Starter.OS uses Ruby for its small setup and validation helpers. You do not need to use Ruby yourself. Before setup changes anything, the agent checks whether Ruby is available and gives you one clear installation step if it is missing.

## security rule

Your OS is private. Keep passwords, security codes, recovery codes, and secret keys in your password manager—not in chat or the OS.
