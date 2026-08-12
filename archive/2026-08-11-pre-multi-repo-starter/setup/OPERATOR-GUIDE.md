---
type: note
created: 2026-08-03
reviewed: 2026-08-03
status: living
authority: reference
source: ai
---

# creating a personal edition for someone

**Audience:** Operator or setup helper
**Lifecycle:** Permanent in the reusable starter; archive with `setup/` in a personal edition.

**Bottom line:** Keep this repository generic. Create a private copy for each person, add only a warm welcome and confirmed starting context, then let the guided interview personalize the rest.

**When to read this:** Read when preparing a copy for a friend, client, or future customer.

## safe personalization

1. Create a fresh private repository from the starter.
2. Give the vault and repository a neutral name chosen with the owner.
3. Optionally add a short welcome note explaining why the system was prepared for them.
4. Preload known context only as **unconfirmed interview notes**, never as settled truth.
5. Do not copy another person's identity, routines, projects, private files, account names, or backup paths.
6. Run the normal interview. The new owner corrects and approves their context summary before it enters `os/me.md` or `knowledge/people/owner.md`.
7. Never merge the person's private content back into the public or reusable starter.

## what makes a copy feel personal

- Use their preferred name in the welcome.
- Mention the two or three outcomes they already said they care about.
- Use examples from their real work in the post-setup tutorial.
- Keep the structure familiar. Personalization should come mainly from context and language, not decorative folders.

## business boundary

Treat every person's vault as confidential. Use separate private repositories and separate account credentials. Never hold, request, or store their passwords, two-factor codes, recovery codes, or secret keys.

## evolving the starter safely

The reusable starter and each person's private edition will change at different speeds.

1. Keep `os/starter-version.md` in every edition so you know which foundation it adopted.
2. Improve and validate the generic starter without using a client's private files as source material.
3. When a useful foundation change exists, compare it with the personal edition before applying it.
4. Never blindly replace personalized files such as `os/me.md`, `os/now.md`, `os/agent-rules.md`, `os/recovery.md`, `knowledge-map.md`, or `knowledge/people/owner.md`.
5. Apply only the relevant system change, validate it, explain it plainly, and let the owner approve any changed behavior or permission.
6. Update `os/starter-version.md` only after that edition has actually adopted the foundation change.

This keeps the starter evolving without turning private client context into shared template material or erasing what the system has learned about its owner.

## post-onboarding cleanup

The whole `setup/` folder is temporary scaffolding inside a personal edition. After the owner completes the full tutorial and first real task, Phase 8 of `setup/AGENT-RUNBOOK.md` moves it into a dated archive, writes one short completion record, and removes its active routes. Do not perform that cleanup early, and do not delete the history.
