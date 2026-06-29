# Provider configuration

This guide covers configuring the
[`terraform-provider-openstack/openstack`](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest)
provider used throughout this repository: declaring it, choosing how it
authenticates, selecting regions and endpoints, TLS options, and debugging auth
problems. For the credential file itself see [clouds.yaml](./clouds-yaml.md), and
for the broader workflow see [Terraform basics](./terraform-basics.md).

## Declaring the provider

Every example pins the provider in `versions.tf`:

```hcl
terraform {
  required_version = ">= 1.3"

  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 3.0"
    }
  }
}
```

`~> 3.0` allows any `3.x` release but not `4.0`. The exact version that gets
installed is recorded in [`.terraform.lock.hcl`](./version-upgrades.md); commit
that file. `source` must be the full registry address — the short name
`openstack` alone is not enough on the current provider.

## Two ways to authenticate

The provider can get credentials from either a `clouds.yaml` entry or from
`OS_*` environment variables. **Pick one** to avoid confusion.

### The `cloud` argument (recommended)

The examples take a `cloud` variable and pass it to the provider:

```hcl
provider "openstack" {
  cloud = var.cloud   # default "openstack" — an entry in clouds.yaml
}
```

```bash
export OS_CLOUD=openstack       # or rely on the var default / -var=cloud=...
terraform apply
```

This keeps all connection details (auth URL, project, domain, region) in one
versionable, secret-free-ish file and out of your `.tf`. See
[clouds.yaml](./clouds-yaml.md).

### `OS_*` environment variables

If you leave `cloud` unset, the provider falls back to the standard OpenStack
environment variables — the same ones produced by a Horizon "OpenStack RC" file:

```bash
export OS_AUTH_URL=https://keystone.example.com:5000/v3
export OS_USERNAME=my-user
export OS_PASSWORD=...                 # prefer app-cred vars below
export OS_PROJECT_NAME=my-project
export OS_USER_DOMAIN_NAME=Default
export OS_PROJECT_DOMAIN_NAME=Default
export OS_REGION_NAME=RegionOne
export OS_INTERFACE=public
export OS_IDENTITY_API_VERSION=3
terraform apply
```

For [application credentials](./application-credentials.md):

```bash
export OS_AUTH_TYPE=v3applicationcredential
export OS_AUTH_URL=https://keystone.example.com:5000/v3
export OS_APPLICATION_CREDENTIAL_ID=...
export OS_APPLICATION_CREDENTIAL_SECRET=...
```

You can also set these inline on the provider block (`auth_url`, `user_name`,
`password`, `application_credential_id`, …), but that risks committing secrets;
prefer `cloud` or environment variables.

## Regions

A single Keystone endpoint can serve several regions. Select one with the
`region` argument (or `OS_REGION_NAME` / `region_name` in `clouds.yaml`):

```hcl
provider "openstack" {
  cloud  = var.cloud
  region = "RegionTwo"
}
```

To manage two regions at once, declare aliased providers and pass them to
resources or modules — see [`examples/multi-region`](../examples/multi-region):

```hcl
provider "openstack" {
  alias  = "r1"
  cloud  = "openstack"
  region = "RegionOne"
}

provider "openstack" {
  alias  = "r2"
  cloud  = "openstack-region2"
  region = "RegionTwo"
}

module "net_r2" {
  source    = "../../modules/networking"
  providers = { openstack = openstack.r2 }
  # ...
}
```

## Endpoints and interface

`interface` (a.k.a. endpoint type) picks which catalog endpoint to call:
`public` (default), `internal`, or `admin`. Use `internal` when running
Terraform inside the cloud on a management network:

```hcl
provider "openstack" {
  cloud     = var.cloud
  interface = "internal"
}
```

To bypass the service catalog entirely — useful when DNS or the catalog is
wrong — override a service endpoint:

```hcl
provider "openstack" {
  cloud = var.cloud

  endpoint_overrides = {
    "network" = "https://neutron.example.com:9696/v2.0/"
  }
}
```

## TLS: `cacert`, `cert`/`key`, `insecure`

For private CAs, point the provider at the CA bundle so verification still
happens:

```hcl
provider "openstack" {
  cloud  = var.cloud
  cacert = "/etc/ssl/certs/my-openstack-ca.pem"
}
```

`insecure = true` disables TLS verification. **Only** use it for throwaway lab
clouds — never in production. The right fix is almost always a correct `cacert`.
For mutual-TLS, set `cert` and `key` to client cert/key paths.

## Debugging authentication

Work from least to most invasive:

```bash
# 1. Does the CLI authenticate with the same credentials Terraform will use?
openstack --os-cloud openstack token issue

# 2. Which clouds.yaml is in play, and is OS_CLOUD set?
echo "$OS_CLOUD"
openstack --os-cloud openstack --debug catalog list 2>&1 | head -40

# 3. Verbose Terraform provider logs (very noisy; redact before sharing).
export TF_LOG=DEBUG
export OS_DEBUG=1
terraform plan
unset TF_LOG OS_DEBUG
```

Common causes:

| Symptom | Likely cause | Fix |
|---------|--------------|-----|
| `Authentication failed` | Wrong password/secret, or expired app credential | Re-check `clouds.yaml`; see [application credentials](./application-credentials.md) |
| `No suitable endpoint could be found` | Wrong `region` or `interface` | Match `openstack catalog list`; try `interface = "public"` |
| `x509: certificate signed by unknown authority` | Private CA not trusted | Set `cacert` (not `insecure`) |
| Provider can't be installed | Short source name / wrong constraint | Use full `terraform-provider-openstack/openstack`, run `terraform init -upgrade` |
| Picks the wrong project | `OS_CLOUD` unset or stale env vars | `export OS_CLOUD=...`; clear stray `OS_*` vars |

## Further reading

- [DevOps AI ToolKit](https://devopsaitoolkit.com/blog/)
