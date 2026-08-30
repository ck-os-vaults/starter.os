---
type: skill
created: 2026-08-30
updated: 2026-08-30
reviewed: 2026-08-30
status: living
authority: canon
source: ai
---

# task reconciliation

**Bottom line:** Bring only meaningful cross-project progress into one concise nightly COS brief without copying routine project reports or creating another memory system.

**When to read this:** During the approved nightly reconciliation, when the owner asks for a cross-task checkpoint, or after meaningful work finishes in another user-visible task. Do not use it for ordinary single-task summaries or work already synthesized in its owning task.

## Procedure

1. Identify the main COS task, the last visible reconciliation, and only the active or recently changed tasks since that cutoff. If no prior reconciliation exists, use the start of the current day.
2. Read compact task status and final results instead of full transcripts. Capture only material outcomes, confirmed decisions, blockers, anything waiting on the owner, the next action and owner, and durable output locations.
3. Resolve duplicate work and surface conflicts. Never silently choose between contradictory claims or recommendations.
4. Keep routine project reporting in its project task. Bring a project into the COS brief only when it affects priorities, requires owner attention, changes shared context, or creates a cross-project dependency.
5. Report repository publication state when a changed repository matters to the checkpoint. Reconciliation does not authorize commits, pushes, record edits, task creation, external messages, or execution of follow-up work.
6. Return one concise update in the main COS task:
   - what materially changed;
   - what is waiting on the owner;
   - the next one to three priorities and their owners; and
   - durable records updated or still needing approval.

## Scheduled task contract

Maintain exactly one scheduled task named `Nightly COS Reconciliation`, targeting the owner's main COS task and running every night at 3:00 AM in the owner's verified local timezone. It must:

- read this workflow before reconciling;
- remain read-only and execute no follow-up work;
- inspect only enough recent task context to produce the brief;
- stay silent when nothing material changed;
- use an economical model capable of reliable summarization; and
- be updated rather than duplicated when its schedule, destination, or instructions change.

If the agent environment cannot create scheduled tasks or cannot verify the destination, report the exact unresolved setup item instead of simulating an automation.

## Boundaries

Do not create a reconciliation log, dashboard, memory file, or parallel status system. Do not treat brainstorming, reviewer dissent, tentative recommendations, or unverified completion claims as durable decisions. Preserve links and locations instead of copying large outputs.
