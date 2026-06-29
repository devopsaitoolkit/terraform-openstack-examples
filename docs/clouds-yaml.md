# clouds.yaml

`clouds.yaml` is the standard OpenStack credentials file. It holds one or more
named "cloud" entries; you select one with the `OS_CLOUD` environment variable or
the provider's `cloud` argument. Both the `openstack` CLI and the Terraform
provider read it, so a single file works everywhere. This repository ships a
ready-to-copy sample at [`../sample-clouds/clouds.yaml`](../sample-clouds/clouds.yaml).

See also: [provider configuration](./provider-configuration.md) for how the
provider consumes these entries, and [application credentials](./application-credentials.md)
for the recommended auth method.

## Where Terraform looks for it

The provider (via gophercloud) searches these locations, in order, and uses the
first hit:

1. The current working directory: `./clouds.yaml`
2. `~/.config/openstack/clouds.yaml`
3. `/etc/openstack/clouds.yaml`

The repo's `.gitignore` already ignores `clouds.yaml` and `secure.yaml` so you
can drop one in an example directory without risk of committing it. Even so,
**never commit a file containing real secrets.**

## Structure

A top-level `clouds:` map keyed by entry name. Each entry has an `auth:` block
plus connection defaults:

```yaml
clouds:
  openstack:
    auth:
      auth_url: https://keystone.example.com:5000/v3
      username: "my-user"
      password: "CHANGE-ME"
      project_name: "my-project"
      user_domain_name: "Default"
      project_domain_name: "Default"
    region_name: "RegionOne"
    interface: "public"
    identity_api_version: 3
```

Key fields:

- **`auth_url`** — the Keystone v3 endpoint (ends in `/v3`).
- **`username` / `password`** — password auth. Prefer application credentials.
- **`project_name`** (or `project_id`) — the project to scope to.
- **`user_domain_name` / `project_domain_name`** — usually `Default`.
- **`region_name`** — which region; required when a cloud has several.
- **`interface`** — `public`, `internal`, or `admin` (endpoint type).
- **`identity_api_version: 3`** — always 3 for modern clouds.

## Selecting an entry

```bash
export OS_CLOUD=openstack
terraform plan
```

The examples also expose a `cloud` variable so you can pass it explicitly:

```hcl
provider "openstack" {
  cloud = var.cloud   # default "openstack"
}
```

```bash
terraform apply -var="cloud=openstack-appcred"
```

`OS_CLOUD` and the `cloud` argument do the same job; if both are present the
provider's `cloud` argument wins for Terraform. Verify which entry is active:

```bash
openstack --os-cloud "$OS_CLOUD" token issue
```

## Multiple clouds and regions

Add as many entries as you need — different clouds, projects, or regions. The
sample file defines three, including a second region used by the
[`examples/multi-region`](../examples/multi-region) examples:

```yaml
clouds:
  openstack-appcred:
    auth_type: "v3applicationcredential"
    auth:
      auth_url: https://keystone.example.com:5000/v3
      application_credential_id: "CHANGE-ME"
      application_credential_secret: "CHANGE-ME"
    region_name: "RegionOne"
    interface: "public"
    identity_api_version: 3

  openstack-region2:
    auth_type: "v3applicationcredential"
    auth:
      auth_url: https://keystone-r2.example.com:5000/v3
      application_credential_id: "CHANGE-ME"
      application_credential_secret: "CHANGE-ME"
    region_name: "RegionTwo"
    interface: "public"
    identity_api_version: 3
```

To drive two regions in one configuration, map each entry to an aliased
provider — see the multi-provider snippet in
[provider configuration](./provider-configuration.md#regions).

## Application-credential entries

The cleanest entry for automation sets `auth_type: v3applicationcredential` and
needs no username, password, project, or domain — the credential already encodes
its scope:

```yaml
clouds:
  ci:
    auth_type: v3applicationcredential
    auth:
      auth_url: https://keystone.example.com:5000/v3
      application_credential_id: "<id>"
      application_credential_secret: "<secret>"
    region_name: "RegionOne"
    interface: "public"
```

Create the credential itself with the
[`examples/identity/application-credential`](../examples/identity/application-credential)
example. Full guidance in [application credentials](./application-credentials.md).

## Splitting secrets into secure.yaml

To keep the non-secret connection details in `clouds.yaml` (safe to share within
a team) and the secrets separate, put sensitive fields in a sibling
`secure.yaml` with the **same entry names**. The two files are merged at load
time:

```yaml
# clouds.yaml (no secrets)
clouds:
  openstack:
    auth:
      auth_url: https://keystone.example.com:5000/v3
      username: "my-user"
      project_name: "my-project"
      user_domain_name: "Default"
      project_domain_name: "Default"
    region_name: "RegionOne"
    interface: "public"
    identity_api_version: 3
```

```yaml
# secure.yaml (secrets only; tighten permissions, never commit)
clouds:
  openstack:
    auth:
      password: "REAL-PASSWORD"
```

`secure.yaml` lives alongside `clouds.yaml` in any of the
[search locations](#where-terraform-looks-for-it).

## Hardening

```bash
chmod 600 ~/.config/openstack/clouds.yaml ~/.config/openstack/secure.yaml
```

- Prefer [application credentials](./application-credentials.md) over passwords.
- Keep real secrets out of version control; the sample uses `CHANGE-ME`
  placeholders for that reason.
- In CI, inject credentials with `OS_*` environment variables or write a
  short-lived `clouds.yaml` from a secret store rather than checking one in.

## Troubleshooting

| Symptom | Likely cause | Fix |
|---------|--------------|-----|
| `Could not find cloud named ...` | `OS_CLOUD` doesn't match an entry | Match the key under `clouds:` exactly (case-sensitive) |
| Picks an unexpected file | A `./clouds.yaml` shadows your global one | Remove the local copy or `cd` elsewhere |
| Auth works in CLI, not Terraform | Stale `OS_*` env vars overriding | `unset` stray `OS_*` vars; rely on `OS_CLOUD` |
| `region` errors | No `region_name` on a multi-region cloud | Add `region_name` (or provider `region`) |

## Further reading

- [DevOps AI ToolKit](https://devopsaitoolkit.com/blog/)
