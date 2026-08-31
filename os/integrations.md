---
type: map
created: 2026-08-29
updated: 2026-08-30
reviewed: 2026-08-30
status: draft
authority: reference
source: ai
---

# integrations and automations

**Bottom line:** Record only external systems and scheduled routines that actually exist, without secret values.

**When to read this:** Before connecting, changing, scheduling through, publishing through, or retiring an external system.

## External systems

| System | Owner or path | State | Purpose | Access boundary | Checked |
|---|---|---|---|---|---|

## Scheduled routines

| Routine | Scheduler | State | Schedule and timezone | Destination | Canonical skill | Checked |
|---|---|---|---|---|---|---|
| Nightly Chief Reconciliation |  | unverified |  |  | `skills/task-reconciliation.md` |  |
| Nightly System Security Check |  | unverified |  |  | `skills/security-sweep.md` |  |

Use `verified active`, `configured but unverified`, `unavailable`, `owner declined`, or `retired`. Never treat configuration alone as proof.

Record where an authorized credential manager supplies access, never the credential itself. Providers, browsers, research services, password managers, hosting, plugins, and schedulers are optional unless the owner has adopted them. Record local and cloud connections separately when their permissions or availability differ.

Every accepted scheduled routine must be verified by name, schedule, timezone, destination, instructions, source access, runtime or model, active status, and first eligible run. Update an equivalent routine instead of creating a duplicate.
