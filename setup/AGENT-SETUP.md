# Create a new Starter.OS

> **Audience: Agent only.** The owner normally starts by providing the public repository link. Read `START-HERE.md`, `QUICK-SETUP.md`, and `GIT-SETUP.md`.

Create a private system without leaving setup files inside it. Use the same five steps in every owner path: **Protect → Review → Ask → Improve → Prove**.

## 1. Protect: confirm the source and destination

Verify this is the public Starter.OS source and run:

```sh
ruby setup/scripts/validate-source.rb
```

Infer the private vault name and destination. Refuse a non-empty destination; use migration or update instead. Never personalize the public source.

### Discover Git and recovery

Follow the Git discovery in `QUICK-SETUP.md`. A first-time owner may already have repositories, accounts, preferred providers, or backup tools. Preserve them and avoid duplicate accounts or repositories.

Propose separate Git repositories for `os/` and `life/`. Every real `biz/<business>/` becomes its own repository when created. The vault root and empty `biz/` folder stay plain so repositories do not become accidentally nested.

Require one private hosted primary per repository for the completed standard path. If the owner does not already have a suitable private Git host, guide secure GitHub account setup and private repository creation before adoption. Preserve an existing GitLab or other suitable hosted primary when the owner prefers it. A local-only recovery commit is a temporary incomplete state, not completed protection. Any second Git service must be an automatic mirror configured from the primary; agents push only to the primary.

## 2. Review

Review the proposed name, location, folder structure, Git setup, privacy, recovery, and available tools. Check which optional recurring workflows the owner's scheduler, sources, and destinations can support.

Do not invent projects, businesses, interests, folders, integrations, or recurring routines.

## 3. Ask

Follow `QUICK-SETUP.md`. Ask one compact question group only if needed, show the exact destination and proposed result, and wait for approval before creating the preview.

## 4. Improve

### Create an unpersonalized preview

Only after approval:

```sh
ruby setup/scripts/create-vault.rb /absolute/path/to/NAME.os
```

The preview contains root pointers, `os/`, `life/`, and an empty `biz/`. It does not contain `setup/`.

Show the root folders, installed Starter.OS version, and files that personalization would change. Ask for final adoption confirmation. This confirms the preview. It is not a second interview.

### Personalize only confirmed context

After adoption:

- stable collaboration context -> `os/me.md`;
- current personal state -> `life/now.md`;
- durable personal background -> `life/wiki/owner.md` (personalize the contents, not the path);
- real personal projects -> `os/scripts/add-project.rb`;
- real businesses -> `os/scripts/add-business.rb`, followed by independent Git and private-primary verification for that business;
- actual integrations and automation status -> `os/integrations.md`;
- chosen Git topology and recovery state -> `os/recovery.md`.

Do not edit `os/manual.md`. It is the protected product explanation layer. An owner who wants a personalized manual may explicitly create an owner-owned fork as described in the manual.

### Establish Git protection

Follow `GIT-SETUP.md`:

1. initialize only the approved repositories that do not already exist;
2. review privacy and secret checks;
3. create and verify a baseline commit in the working repository;
4. create or connect the approved private primary;
5. verify visibility before personal content is pushed;
6. push only to the primary;
7. configure an approved secondary as an automatic mirror;
8. verify exact commit parity;
9. record every layer truthfully.

Account creation, sign-in, repository creation, visibility changes, publication, and mirror configuration require owner approval.

### Guide optional recurring workflows

Use the shared recurring-workflow contract in `QUICK-SETUP.md`.

Suggest only compatible recipes. If accepted, create or update each in the owner's chosen scheduler, using the matching portable skill. Verify the full configuration. If declined, deferred, or unavailable, record the truthful status without blocking setup.

## 5. Prove

Run:

```sh
ruby os/validate-starter-os.rb
```

Review intended changes and privacy, then give the receipt required by `QUICK-SETUP.md`.

The validator proves local structure and readable local Git history. Separately verify hosted primaries, enabled mirrors, uncovered-file backup, and the restore route before calling setup fully protected.

Apply the shared distribution-source cleanup contract in `QUICK-SETUP.md`. Remove only an approved temporary public source after confirming it contains no owner work; leave an intentional maintainer checkout intact.

Finish with this orientation:

> Your Chief of Staff is your main home. Ask for the outcome you want in ordinary language. Your files hold the lasting information, project work stays with its project, and the manual explains unfamiliar terms. The agent will show a short plan before important work and ask when it needs your approval.

Setup is complete only when:

- the owner adopted the preview;
- the installed vault passes validation;
- Git and recovery status are accurate;
- each enabled mirror is verified or clearly unresolved;
- each offered recurring workflow has a recorded outcome;
- no setup files remain inside the private vault;
- temporary source cleanup is complete or its remaining work is reported.
