---
type: skill
created: 2026-08-03
reviewed: 2026-08-03
status: living
authority: canon
source: ai
---

# security sweep

## purpose

Stop credentials, account-recovery material, private data, unsafe exports, or unintended files before they enter version history or leave the computer.

## trigger

Before the first GitHub/GitLab upload, after unknown or bulk imports, before public work, and before committing unreviewed sensitive material.

## steps

1. Identify the exact changed and untracked files; do not scan unrelated private folders without need.
2. Check for credential-shaped values, private keys, tokens, recovery-code downloads, environment files, and passwords without printing their contents.
3. Check screenshots, transcripts, exports, and attachments for third-party, client, legal, medical, financial, or account-recovery information.
4. Confirm local app state, caches, raw media, transient attachments, and independent nested repositories are ignored or intentionally handled.
5. Confirm repository visibility and destination before any push.
6. Report findings by severity: secret → private-data exposure → wrong destination/visibility → repository hygiene.
7. A real secret or recovery code blocks the commit or push. Tell the owner which file and type of issue without reproducing the value.

## boundaries

- Never reproduce a found secret in chat, notes, reports, or commit messages.
- Never rotate credentials, rewrite Git history, force-push, or delete data without explicit owner direction.
- Defensive review only; do not test accounts or systems the owner does not control.
