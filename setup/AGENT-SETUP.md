# Create a new Starter.OS

> **Audience: Agent only.** The owner normally starts by providing the public repository link. Read `START-HERE.md`, `QUICK-SETUP.md`, and `GIT-SETUP.md`.

Create a private, useful system without leaving setup scaffolding inside it.

## Step 1: confirm a safe source and destination

Verify this is the public Starter.OS source and run:

```sh
ruby scripts/validate-starter-kit.rb
```

Infer the private vault name and destination. Refuse a non-empty destination; use migration or update instead. Never personalize the public source.

## Step 2: discover Git and recovery

Follow the Git discovery in `QUICK-SETUP.md`. A first-time owner may already have repositories, accounts, preferred providers, or backup tools. Preserve them and avoid duplicate accounts or repositories.

Propose independent local Git repositories for `os/` and `life/`. A real business receives its repository when created. The vault root and empty `biz/` container stay plain so repositories do not become accidentally nested.

Offer one private off-device primary per repository. GitHub, GitLab, another host, or local-only Git may be chosen. Explain that local-only Git does not protect against device loss. Any second Git service must be an automatic mirror configured from the primary; agents push only to the primary.

## Step 3: use the shared approval card

Follow `QUICK-SETUP.md`. Ask one compact question group only if needed, show the exact destination and proposed result, and wait for approval before creating the preview.

Do not invent projects, businesses, interests, folders, integrations, or automations.

## Step 4: create an unpersonalized preview

Only after approval:

```sh
ruby scripts/create-vault.rb /absolute/path/to/NAME.os
```

The preview contains root pointers, `os/`, `life/`, and an empty `biz/`. It does not contain `setup/`.

Show the root tree, installed Starter.OS version, and exact files personalization would change. Ask for final adoption confirmation. This is a confirmation of the preview, not a second interview.

## Step 5: personalize only confirmed context

After adoption:

- stable collaboration context -> `os/me.md`;
- current personal state -> `life/now.md`;
- durable personal background -> `life/wiki/<owner>.md`;
- real personal projects -> `os/scripts/add-project.rb`;
- real businesses -> `os/scripts/add-business.rb`;
- actual integrations and automation status -> `os/integrations.md`;
- chosen Git topology and recovery state -> `os/recovery.md`.

Do not edit `os/manual.md`. It is the protected product explanation layer. An owner who wants a personalized manual may explicitly create an owner-owned fork as described in the manual.

## Step 6: establish Git protection

Follow `GIT-SETUP.md`:

1. initialize only the approved repositories that do not already exist;
2. review privacy and secret checks;
3. create and verify a local baseline commit;
4. create or connect the approved private primary;
5. verify visibility before personal content is pushed;
6. push only to the primary;
7. configure an approved secondary as an automatic mirror;
8. verify exact commit parity;
9. record every layer truthfully.

Account creation, sign-in, repository creation, visibility changes, publication, and mirror configuration require owner approval.

## Step 7: guide the two automation choices

Use the shared automation contract in `QUICK-SETUP.md`.

Offer `Nightly Chief Reconciliation` and `Nightly System Security Check` separately. If accepted, create or update each in the owner's chosen local or cloud scheduler, using `os/skills/task-reconciliation.md` and `os/skills/security-sweep.md`. Verify the full configuration. If declined or unavailable, record the truthful status without blocking setup.

## Step 8: validate and return the owner to work

Run:

```sh
ruby os/validate-starter-os.rb
```

Review intended changes and privacy, then give the receipt required by `QUICK-SETUP.md`.

Finish with this orientation:

> Your Chief of Staff is your main home base. Ask for the outcome you want in ordinary language. Your files hold the lasting truth, project work stays with its project, and the manual explains unfamiliar terms simply. The agent will show a short plan before consequential work and ask when your approval is genuinely needed.

Setup is complete only when the owner adopted the preview, the installed vault validates, Git and recovery status are truthful, every enabled mirror is verified or clearly unresolved, both automation choices have recorded outcomes, and no setup scaffolding remains inside the private vault.
