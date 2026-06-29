# Terraform basics for OpenStack

This guide introduces the core Terraform (and OpenTofu) concepts you need to use
the examples in this repository against an OpenStack cloud. If you already know
Terraform, skim to [The workflow](#the-workflow) and the OpenStack-specific
notes. New to authentication? Read [clouds.yaml](./clouds-yaml.md) and
[provider configuration](./provider-configuration.md) first.

Terraform and OpenTofu are interchangeable for everything here. Where the docs
say `terraform`, you can substitute `tofu`; the helper scripts honour
`TF_BIN=tofu`.

## Prerequisites

- Terraform `>= 1.3` (CI pins `1.9.8`) or a recent OpenTofu, on your `PATH`.
- The `openstack` CLI (handy for finding IDs and verifying results).
- A working `clouds.yaml` and `export OS_CLOUD=openstack`.

```bash
terraform version
openstack --os-cloud openstack token issue   # sanity-check your credentials
```

## Providers, resources, and data sources

A **provider** is the plugin that talks to a platform's API. Every directory
declares the OpenStack provider and pins its version in `versions.tf`:

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

The provider block tells it which cloud to authenticate against:

```hcl
provider "openstack" {
  cloud = var.cloud   # entry name from clouds.yaml
}
```

A **resource** is something Terraform creates and owns. Its lifecycle (create,
update, replace, destroy) is tracked in state:

```hcl
resource "openstack_compute_instance_v2" "instance" {
  name        = "web-1"
  flavor_name = "m1.small"
  image_name  = "ubuntu-22.04"

  network {
    uuid = data.openstack_networking_network_v2.network.id
  }
}
```

A **data source** reads something that already exists; Terraform never creates or
destroys it. This is how the examples avoid hard-coding cloud-specific UUIDs:

```hcl
data "openstack_networking_network_v2" "network" {
  name = var.network_name
}
```

OpenStack resource and data-source names carry an API-version suffix
(`_v2`, `_v3`). Use the version that matches the resource type — for example
`openstack_compute_instance_v2`, `openstack_networking_network_v2`,
`openstack_identity_application_credential_v3`.

## Variables and outputs

**Variables** parameterise a configuration. Define them in `variables.tf`:

```hcl
variable "instance_name" {
  description = "Name of the compute instance."
  type        = string
  default     = "example-single-instance"
}
```

Set values on the CLI, with `TF_VAR_` environment variables, or in a
`terraform.tfvars` file (gitignored, so secrets and environment specifics never
get committed):

```bash
cp terraform.tfvars.example terraform.tfvars   # then edit
terraform apply -var="instance_name=web-1"
```

**Outputs** surface useful attributes after apply. Mark anything secret as
`sensitive` so it is not printed in logs:

```hcl
output "access_ip_v4" {
  description = "The first IPv4 address assigned to the instance."
  value       = openstack_compute_instance_v2.instance.access_ip_v4
}
```

```bash
terraform output                       # all outputs
terraform output -raw access_ip_v4     # one value, unquoted (good for scripts)
```

## The workflow

Run these from inside an example directory (e.g.
[`examples/compute/single-instance`](../examples/compute/single-instance)):

```bash
export OS_CLOUD=openstack

terraform init      # download the provider, set up the backend
terraform fmt       # canonical formatting
terraform validate  # check syntax and types (no API calls)
terraform plan      # preview changes
terraform apply     # create/update resources after confirmation
terraform destroy   # tear everything down
```

- **`init`** downloads providers into `.terraform/` and writes/updates
  `.terraform.lock.hcl`. Re-run it after changing providers or backend config.
- **`plan`** shows a diff of `+ create`, `~ update`, `-/+ replace`, and
  `- destroy`. Save it with `-out=tfplan.out` to apply *exactly* that plan later.
- **`apply`** asks for confirmation unless you pass a saved plan file or
  `-auto-approve`. The repo's [`scripts/tf-apply.sh`](../scripts/tf-apply.sh)
  wraps this safely.
- **`destroy`** removes everything in state. Always review the plan first.

A typical safe loop using the helper scripts:

```bash
scripts/tf-fmt.sh --check .
scripts/tf-validate.sh examples/compute/single-instance
scripts/tf-plan.sh examples/compute/single-instance
scripts/tf-apply.sh examples/compute/single-instance
```

## State

Terraform records what it created in a **state file** (`terraform.tfstate`).
It maps your configuration to real OpenStack resources and stores attribute
values. State can contain secrets, so for any shared or team use you should move
it to a [remote backend](./remote-state.md) and learn the
[state commands](./state-management.md).

## Where to go next

- [clouds.yaml](./clouds-yaml.md) and
  [provider configuration](./provider-configuration.md) for authentication.
- [Module design](./module-design.md) once you want to reuse configuration.
- [Testing](./testing.md) to validate changes without touching a cloud.

## Further reading

- [DevOps AI ToolKit](https://devopsaitoolkit.com/blog/)
