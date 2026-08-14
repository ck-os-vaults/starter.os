---
type: status
created: 2026-08-11
updated: 2026-08-14
reviewed: 2026-08-14
status: living
authority: canon
source: ai
---

# setup status

**For: Agent**

**Bottom line:** Setup builds the vault shell first, personalizes it second, and creates private repositories only after the owner approves the context and the security checks pass.

**When to read this:** Agents read this throughout onboarding. New users read only `README.md` and the numbered prompt files.

## phases

1. Orient in the public source, ask what replaces `STARTER` in `STARTER.os`, then choose the private vault location.
2. Generate the vault shell and confirm Obsidian/agent access.
3. Interview for stable, current, deeper, and business-specific context.
4. Confirm the summary and personalize the generated files.
5. Create and secure private GitHub primary repositories.
6. Create private GitLab mirrors and configure `backup` remotes.
7. Configure and test full-vault local/offsite protection.
8. Validate structure, privacy, recovery, and repository parity.
9. Verify start-of-work Git preflight and closeout; configure scheduled maintenance only if the owner wants it.
10. Complete the tutorial and first real task.
11. Archive setup scaffolding and verify the everyday system.

## completion gate

- The private root uses the chosen `<NAME>.os` name and contains the three lowercase top-level vaults `biz/`, `life/`, and `os/`.
- The root and `biz/` are plain containers; `os/`, `life/`, and each real business are independent repositories.
- `biz/business-model/` is renamed to the first confirmed `biz/<business>/` before personalizing, initializing, or publishing that business repository.
- `ruby os/validate-starter-os.rb` passes from the generated vault root.
- Owner context is confirmed and routed at the correct level.
- Every repository is private on GitHub and GitLab; local, `origin`, and `backup` refs match.
- Two-factor authentication and recovery access are confirmed without exposing codes.
- One `.obsidian/` folder exists at the vault root.
- A full-vault backup covers ignored safe files and opens a tested restored file.
- `os/recovery.md` accurately records the topology without secrets.
- Start-of-work Git preflight and repository closeout are understood and tested.
- Any owner-requested maintenance schedule is correctly targeted and verified.
- The tutorial and first real task are complete.
- Temporary setup files are archived under `life/archive/setup/<date>/` and a completion record remains in `life/records/sessions/`.
