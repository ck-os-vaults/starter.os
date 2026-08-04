---
type: status
created: 2026-06-19
updated: 2026-08-03
reviewed: 2026-08-03
status: living
authority: canon
source: ai
---

# setup status and acceptance gate

**Audience:** Agents
**Lifecycle:** Setup only — archive with the `setup/` folder after onboarding.

**Bottom line:** The starter already has a stable structure. Setup fills it with the owner's approved context, secures two private online histories, adds a daily local backup, and verifies that the whole system can be recovered.

**When to read this:** Agents read this during setup. Owners begin with `setup/README.md` and `setup/FIRST-CHAT.md`.

## setup principle

Personalize context before structure. Use the existing lanes unless the owner's real needs clearly cannot fit them. A new folder must solve a real routing problem, not make the system look more complete.

## setup sequence

Follow `setup/AGENT-RUNBOOK.md` in order:

1. Explain the process and check the environment.
2. Conduct the context interview one section at a time.
3. Show the owner a context summary and exact personalization list.
4. Personalize the approved files and run the validator.
5. Secure and connect a private GitHub repository.
6. Secure and connect a private GitLab project as a matching second online copy.
7. Configure a daily local backup such as Carbon Copy Cloner on Mac.
8. Verify privacy, synchronization, restore instructions, and recovery access.
9. Deliver `setup/POST-SETUP-TUTORIAL.md` for the first post-setup chat.
10. After the tutorial and first real task, archive the setup scaffolding and validate the everyday system.

## completion gate

Setup is complete only when:

- `os/me.md`, `os/now.md`, and `knowledge/people/owner.md` reflect the approved context at the correct level of detail.
- `knowledge-map.md` routes the owner's real recurring tasks.
- No unnecessary folders or another person's context remain.
- The automated system check passes.
- GitHub and GitLab are private and show the same current saved version as this computer.
- Two-factor authentication is enabled on both accounts and recovery codes are stored outside the vault.
- The daily local backup has completed once and a copied file opens successfully. If an external drive is still needed, onboarding remains incomplete with that one clearly named next action.
- `os/recovery.md` explains what is backed up, what is excluded, and how to restore it without containing credentials.
- The owner knows where uncertain material goes and which prompt starts the tutorial.
- After the tutorial, temporary setup routes are removed, the setup documents are in a dated archive, and a short completion record remains active.
