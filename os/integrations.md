---
type: map
created: 2026-08-11
updated: 2026-08-11
reviewed: 2026-08-11
status: draft
authority: reference
source: ai
---

# integrations and publishing registry

**Bottom line:** Inventory meaningful external state—repositories, public URLs, hosting, databases, APIs, account connections, scheduled jobs, plugins, and credential types—without storing secret values.

**When to read this:** Before publishing, connecting an API, creating a key, installing an operational tool, changing hosting, rotating credentials, or retiring an external system.

## rules

- Never record a key, token, password, recovery code, private key, customer data, or secret value.
- Record credential type, owner/provider, where an authorized person retrieves or rotates it, and which local environment variable or ignored file consumes it.
- Add an entry when an integration becomes real, not when it is merely mentioned in research.
- Preserve retired entries with date and evidence so external surfaces do not disappear from memory.
- Package manifests remain the exhaustive library source; this registry names only operationally meaningful dependencies.

## status language

| state | meaning |
|---|---|
| `verified active` | live provider state checked on the recorded date |
| `verified present` | local config or identifier checked; full provider behavior not proven |
| `historical` | evidence proves prior use; current state not assumed |
| `unverified` | known but not checked |
| `planned only` | discussed without a working connection |
| `retired` | confirmed removed or disconnected |

## registry

| system | owner/path | state | identifier or public URL | credential type and retrieval owner | purpose / retirement route | checked |
|---|---|---|---|---|---|---|

## attention queue

Add only unresolved owner actions or provider checks. Keep the list short and current.

## research-only providers

Names considered in research stay here until a real account, key, configuration, deployment, or data call exists.
