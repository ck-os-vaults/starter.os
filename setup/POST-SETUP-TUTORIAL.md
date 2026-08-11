---
type: note
created: 2026-08-03
updated: 2026-08-11
reviewed: 2026-08-11
status: living
authority: canon
source: ai
---

# your first post-setup chat

**Audience:** Owner
**Lifecycle:** Setup only — archive with the `setup/` folder after this tutorial.

**Bottom line:** This prompt starts an interactive, plain-English tutorial that teaches a first-time owner how to collaborate with Codex or Claude without needing perfect prompts or technical knowledge.

**When to read this:** Paste this into a new chat after the complete setup and backup checks pass.

```text
Teach me how to work confidently with an AI agent inside Starter.OS.

Assume I have zero technical or coding background. Use ordinary language and
teach interactively, not as one long lecture. Read AGENTS.md, os/me.md,
os/agent-rules.md, os/now.md, and knowledge-map.md first so the lesson fits me.

Teach one short lesson at a time. For each lesson:
1. Explain the idea simply.
2. Show one realistic example that fits my life or work.
3. Give me one tiny practice exercise.
4. Wait for my response before continuing.

Cover these lessons:

1. What the agent, the AI brain (often called the model), and the app around it
   are—and why my local Starter.OS files are the lasting memory. If you use the
   technical word “harness,” define it in ordinary language first.
2. Why I do not need a perfect prompt. Show me how to begin with a natural
   conversation about the problem, then let the agent interview me about the
   goal, ideal outcome, success, failure, constraints, and missing context.
3. How to give high-quality context: what is happening, why it matters, what
   already exists, what good looks like, what must not happen, and what evidence
   or files the agent should inspect.
4. How to name the current kind of work: discuss, research, plan, change, review,
   or take an external action. Teach me when to say “read only,” when local edits
   are expected, and when the agent must ask before acting.
5. How to collaborate while work is happening: correct direction early, ask for
   options with tradeoffs, approve one layer at a time, and request verification
   before calling something done.
6. How to use context and tokens efficiently. First explain that tokens are the
   small chunks of text an AI reads and writes—the rough meter for how much fits
   in a conversation. Then teach me to keep one workstream per chat,
   start a fresh chat for unrelated work, store durable truth in files instead
   of repeatedly pasting history, ask the agent to read only relevant context,
   keep routine answers short, and create a handoff when a long task pauses.
7. How to choose model strength and reasoning effort. Teach me to leave the
   default or automatic setting on for ordinary work, use a faster/lighter
   option for simple repetitive tasks, and use a stronger model or higher effort
   for difficult planning, architecture, research synthesis, debugging, or
   high-consequence review. Explain why the maximum setting is rarely the first
   answer and why clearer context often helps more than extra reasoning. Product
   names and controls change, so check the current official guidance for the
   agent app I am actually using before naming a specific model or setting.
8. How to review agent work safely: inspect the summary and changed files, ask
   what was tested, understand what remains uncertain, and use Git history to
   recover when needed.

Include this reusable conversation starter and help me practice it:

“I want help with [problem or idea]. Before doing anything, discuss it with me
and ask the questions that would materially improve the result. Help me clarify
the goal, ideal outcome, success, failure, constraints, useful context, and the
right next layer of work. Do not change files or take external actions until we
agree on the direction.”

Finish by asking me for one real problem, idea, or responsibility I want help
with today. Help me turn it into a strong working brief, then complete one small,
safe first task with me.

After the lessons and that first task are fully complete, continue with Phase 8
of setup/AGENT-RUNBOOK.md. Perform the cleanup yourself: create the completion
record, archive the entire setup folder, remove obsolete active
routes, validate the finished Starter.OS system, and verify both private online histories
match. Do not merely tell me what I should archive. If any security, backup,
sync, or tutorial gate is incomplete, leave the setup documents active and tell
me the one next action instead.
```

## the simplest rule to remember

Talk to the agent like a thoughtful collaborator. Start with the problem, not a polished command. Let the agent help you discover what the prompt needs to become.
