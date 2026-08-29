# Connect GitHub and an optional GitLab mirror

> **Audience: Owner.** Use this only when GitHub is not connected or when an existing GitHub and GitLab setup needs to adopt the Starter.OS recovery model.

Starter.OS treats GitHub as the canonical home for every published repository. GitLab is optional and, when used, receives an automatic downstream mirror. Agents push only to GitHub and verify the mirror instead of pushing the same commit twice.

## Owner path 1: connect GitHub

Open Starter.OS in your file-capable agent. **Copy and paste these exact words into the agent's prompt:**

> Read `AGENTS.md`, `setup/AGENT-SETUP.md`, and `setup/GITHUB-SETUP.md`. Check whether GitHub is already authenticated without exposing credentials. If it is not, give me the smallest secure sign-in step. Then show me the proposed repository names, owners, visibility, and recovery plan. Wait for my approval before creating or publishing anything. Use GitHub as the canonical remote named `origin`. Ask whether I want an optional automatic GitLab mirror, but do not configure a second agent push target.

The agent should never ask you to paste a token into chat or store one in the vault. Account creation, sign-in, repository creation, visibility changes, and first publication remain approval boundaries.

## Owner path 2: upgrade existing GitHub and GitLab repositories

Use this when both services already contain your repositories but agents currently push to each one separately. **Copy and paste these exact words into the agent's prompt:**

> Read `AGENTS.md`, `setup/AGENT-SETUP.md`, and `setup/GITHUB-SETUP.md`. Audit my existing GitHub and GitLab repository connections without changing them. Show me the exact repository pairs and current commit parity, then wait for my approval. Make GitHub the canonical `origin` and convert GitLab into an automatic downstream mirror. Agents must push only to GitHub after the conversion. Preserve both repositories, remove no history, and verify the mirror before calling the upgrade complete.

## Agent contract

1. Inspect existing authentication, remotes, repository ownership, visibility, default branches, and commit parity read-only. Never expose credentials.
2. Show the exact repository map and wait for approval before account changes, repository creation, publication, mirror configuration, or local remote changes.
3. Use GitHub as the canonical remote named `origin`. Do not initialize Git at the vault root or `biz/`; publish only approved operating-system, personal, project, and business repositories.
4. When GitLab is wanted, configure one automatic downstream path:
   - Prefer a GitLab pull mirror from GitHub when the owner's GitLab plan supports it. This is configured in the GitLab project's **Settings > Repository > Mirroring repositories**.
   - Otherwise, propose a GitHub Actions mirror that runs from GitHub and uses a narrowly scoped GitLab credential stored only as a GitHub Actions secret. Adding the workflow or secret requires approval.
5. Do not keep GitLab as a second routine agent push target. Do not push directly to the downstream mirror after conversion.
6. Verify the GitHub default-branch commit, trigger or wait for the automatic mirror, and confirm GitLab reaches the same commit. Record the mirror as `verified` only after this succeeds; otherwise use `configured but unverified`.
7. Record only repository locations, visibility, mirror direction, and verification status in `os/recovery.md`. Never record tokens or credential-bearing URLs.

GitLab pull mirroring may depend on the owner's GitLab plan. If neither automatic option is approved or available, keep GitHub as the sole remote and record GitLab as `owner declined` or `configured but unverified`; do not silently restore manual dual pushes.
