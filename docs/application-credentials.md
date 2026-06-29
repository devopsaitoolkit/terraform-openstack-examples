# Application credentials

Application credentials are the recommended way to give automation — Terraform,
CI/CD, scripts — access to OpenStack. They are scoped, expirable, restricted by
default, and independently revocable, which makes them far safer than handing out
a username and password. This repository includes a ready-made example at
[`examples/identity/application-credential`](../examples/identity/application-credential).

See also: [clouds.yaml](./clouds-yaml.md) for wiring the credential into auth and
[provider configuration](./provider-configuration.md) for the provider side.

## Why they beat passwords

A password is a single, long-lived, full-power secret. Leak it and an attacker
gets everything the user can do, and rotating it disrupts the human's logins. An
application credential, by contrast, is:

- **Scoped** to one user and project.
- **Role-limited** to a chosen subset of that user's roles (least privilege).
- **Expirable** via `expires_at` — it auto-revokes.
- **Restricted by default** — it cannot create further credentials or trusts.
- **Independently revocable** — deleting it does not lock the human user out.

Issue one per pipeline or service so each can be rotated and revoked on its own.

## Creating one with the openstack CLI

Anyone can create a credential for *their own* user — no admin role required:

```bash
export OS_CLOUD=openstack   # the user the credential is created for

openstack application credential create ci-deployer \
  --role member \
  --expiration 2026-12-31T23:59:59 \
  --description "CI pipeline deploy credential"
```

The output shows the `id` and a `secret` that is displayed **only once**. Copy it
straight into your secrets manager. List, inspect, and revoke later:

```bash
openstack application credential list
openstack application credential show ci-deployer
openstack application credential delete ci-deployer
```

## Creating one with Terraform

The [identity example](../examples/identity/application-credential) wraps
`openstack_identity_application_credential_v3` and exposes the secret as a
`sensitive` output:

```hcl
resource "openstack_identity_application_credential_v3" "app_cred" {
  name        = var.name
  description = var.description

  # Empty list => inherit ALL of the user's roles. Provide a list to restrict.
  roles = var.roles

  # Omit (null) for no expiry; always set one for automation.
  expires_at = var.expires_at != "" ? var.expires_at : null

  # Keep restricted: an unrestricted credential can mint more creds/trusts.
  unrestricted = var.unrestricted
}
```

```bash
export OS_CLOUD=openstack
cp terraform.tfvars.example terraform.tfvars   # then edit
terraform init && terraform apply

# Capture the secret immediately — it is creation-time only:
terraform output -raw application_credential_secret
```

The secret is generated server-side and is knowable only at creation. It is
stored in Terraform state, so treat state as a secret: use an encrypted,
access-controlled [remote backend](./remote-state.md).

## Using one for auth

Reference it from a `clouds.yaml` entry with
`auth_type: v3applicationcredential` — no username, password, project, or domain
required, because the credential already encodes its scope:

```yaml
clouds:
  ci:
    auth_type: v3applicationcredential
    auth:
      auth_url: https://keystone.example.com:5000/v3
      application_credential_id: "<application_credential_id output>"
      application_credential_secret: "<secret output>"
    region_name: "RegionOne"
    interface: "public"
```

```bash
export OS_CLOUD=ci
terraform plan
```

Or via environment variables (handy in CI):

```bash
export OS_AUTH_TYPE=v3applicationcredential
export OS_AUTH_URL=https://keystone.example.com:5000/v3
export OS_APPLICATION_CREDENTIAL_ID=...
export OS_APPLICATION_CREDENTIAL_SECRET=...
```

## Scoping: roles and access rules

Grant only the roles a pipeline needs. With Terraform:

```hcl
roles = ["member"]   # not the user's full role set
```

For finer control, an application credential can be constrained to specific API
paths and methods with `access_rules` (provider `access_rules {}` blocks /
`--access-rules` on the CLI), so a credential can be limited to, say, only
booting servers. Leave it general only when you must.

## Unrestricted

`unrestricted = true` lets the credential create further credentials and trusts —
effectively as powerful as the account password. **Keep it `false`.** Only a few
admin workflows legitimately need an unrestricted credential.

## Expiry and rotation

- Always set `expires_at` (RFC3339, e.g. `2026-12-31T23:59:59Z`). A credential
  with no expiry is a standing risk.
- Rotate **before** expiry: create the replacement, update `clouds.yaml` /
  secrets, then delete the old one — overlap so nothing breaks mid-rotation.
- Revoke immediately when a pipeline is decommissioned or a secret leaks:
  `openstack application credential delete <id>` or `terraform destroy`.
  Any automation still using it starts failing auth at once.

## Troubleshooting

| Symptom | Likely cause | Fix |
|---------|--------------|-----|
| `secret` empty after a refresh | Secret is known only at creation | Re-create; capture the secret immediately |
| `403` creating the credential | User lacks a role listed in `roles` | Request only roles the user actually holds |
| Auth fails with the credential | Wrong id/secret, or expired | Check `expires_at`; verify the `v3applicationcredential` block |
| `Conflict ... already exists` | Name reused for the same user | Choose a unique name |

## Further reading

- [DevOps AI ToolKit](https://devopsaitoolkit.com/blog/)
