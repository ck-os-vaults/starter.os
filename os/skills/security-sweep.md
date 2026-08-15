---
type: skill
created: 2026-08-03
updated: 2026-08-15
reviewed: 2026-08-15
status: living
authority: canon
source: ai
---

# security sweep

## purpose

Stop credentials, account-recovery material, private data, unsafe exports, or unintended files before they enter version history or leave the computer.

## trigger

Unknown-origin, sensitive, dependency-related, public-facing, or otherwise risk-bearing changes; the first publication; or an explicit owner request. Routine known-source documentation changes do not require this skill.

## steps

1. Identify the exact changed and untracked files; do not scan unrelated private folders without need.
2. Check for credential-shaped values, private keys, tokens, recovery-code downloads, environment files, and passwords without printing their contents.
3. Check screenshots, transcripts, exports, and attachments for third-party, client, legal, medical, financial, or account-recovery information.
4. Confirm local app state, caches, raw media, transient attachments, dependencies, and build output are ignored or intentionally handled.
5. Confirm the vault root and `biz/` have no `.git`; `os/`, `life/`, and each business have one repository with no nested Git or submodules.
6. Confirm the exact GitHub destination and visibility before publication. The public starter kit is the only expected public repository.
7. Report findings by severity: secret -> private-data exposure -> wrong destination/visibility -> repository hygiene.
8. A real secret or recovery code blocks the commit or push. Tell the owner which file and issue type without reproducing the value.

## boundaries

- Never reproduce a found secret in chat, notes, reports, or commit messages.
- Never rotate credentials, rewrite Git history, force-push, delete refs, or delete data without explicit owner direction.
- Defensive review only; do not test accounts or systems the owner does not control.
