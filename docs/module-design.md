# Module design

A module is a reusable, parameterised group of resources. This repository's
[`modules/`](../modules) directory holds curated OpenStack modules — compute,
networking, security-group, volume, project, user, image, router, floating-ip,
loadbalancer — that you can call from your own configurations. This guide covers
how those modules are structured, how to design good inputs and outputs, how to
compose and pin them, and when a module is worth creating at all.

See also: [testing](./testing.md) for how the modules are tested without a cloud,
and [Terraform basics](./terraform-basics.md) for the underlying concepts.

## Anatomy of a module

Every module in this repo ships the same files, and yours should too:

```text
modules/networking/
├── README.md            # what it does, inputs, outputs, an example
├── main.tf              # the resources
├── variables.tf         # inputs
├── outputs.tf           # outputs
├── versions.tf          # required_version + required_providers
├── examples/basic/      # a runnable example that calls the module
└── tests/               # native *.tftest.hcl with a mock_provider
```

Keeping `versions.tf` *inside* the module pins the provider it needs. A module
should declare `required_providers` but **not** a `provider` block — let the
calling configuration supply credentials. See
[provider configuration](./provider-configuration.md).

## Designing inputs

Variables are a module's API. Make them clear, typed, and defaulted where sane:

```hcl
variable "name" {
  description = "Base name for the network and its subnet."
  type        = string
}

variable "cidr" {
  description = "CIDR for the subnet, e.g. 10.20.0.0/24."
  type        = string

  validation {
    condition     = can(cidrhost(var.cidr, 0))
    error_message = "cidr must be a valid CIDR block."
  }
}

variable "dns_nameservers" {
  description = "DNS servers for the subnet."
  type        = list(string)
  default     = ["1.1.1.1", "9.9.9.9"]
}
```

Guidelines:

- **One concept per module.** `networking` makes a network + subnet, not a whole
  app stack.
- **Sensible defaults** so the common case is a one-liner, but expose the knobs
  that differ per environment.
- **Validate** inputs (`validation {}` blocks) to fail fast with a good message.
- **Prefer names over IDs** where it improves portability, mirroring the
  examples that look networks up by name via a data source.
- **Avoid hard-coding** region, project, or cloud — accept them as inputs or let
  the provider supply them.

## Designing outputs

Outputs are how callers wire modules together. Export the IDs and attributes a
consumer will realistically need:

```hcl
output "network_id" {
  description = "ID of the created network."
  value       = openstack_networking_network_v2.this.id
}

output "subnet_id" {
  description = "ID of the created subnet."
  value       = openstack_networking_subnet_v2.this.id
}
```

Mark secrets `sensitive = true` (as the
[application credential](./application-credentials.md) example does with its
generated secret).

## Composition

Build stacks by passing one module's outputs into another's inputs:

```hcl
module "network" {
  source          = "../../modules/networking"
  name            = "app"
  cidr            = "10.20.0.0/24"
  dns_nameservers = ["1.1.1.1", "9.9.9.9"]
}

module "web_sg" {
  source = "../../modules/security-group"
  name   = "web"
  # ... ingress rules ...
}

module "web" {
  source          = "../../modules/compute"
  name            = "web"
  network_id      = module.network.network_id
  security_groups = [module.web_sg.name]
}
```

For multi-region stacks, pass an aliased provider into a module with
`providers = { openstack = openstack.r2 }` — see
[provider configuration](./provider-configuration.md#regions).

Use `count` / `for_each` on a module to stamp out several copies:

```hcl
module "tenant" {
  source   = "../../modules/project"
  for_each = toset(["team-a", "team-b", "team-c"])
  name     = each.key
}
```

## Versioning and pinning with `?ref=`

When you reference a module by Git URL, **pin it to an immutable ref** so an
upstream change can't silently alter your infrastructure. Append `?ref=` with a
tag (preferred), branch, or commit SHA:

```hcl
module "network" {
  source          = "github.com/devopsaitoolkit/terraform-openstack-examples//modules/networking?ref=v1.0.0"
  name            = "app"
  cidr            = "10.20.0.0/24"
  dns_nameservers = ["1.1.1.1", "9.9.9.9"]
}
```

- The `//` separates the repo from the subdirectory of the module.
- `?ref=v1.0.0` pins to a release tag — reproducible and safe to upgrade
  deliberately.
- A branch (`?ref=main`) tracks the latest and is fine for experimentation, not
  production.
- A commit SHA is the most precise pin.

Local paths (`source = "../../modules/networking"`) don't take a `ref` — they
move with the repo, which is how the in-repo `examples/basic/` call modules.

## When to make a module

Create a module when:

- You repeat the same group of resources across configurations.
- A pattern has a clear, nameable purpose and a small, stable interface.
- You want to test a unit in isolation (see [testing](./testing.md)).

**Don't** wrap a single resource in a module just to add indirection — a thin
pass-through module adds friction without benefit. Start with a plain resource;
extract a module once the duplication or the need for a stable contract is real.

## Checklist

- `README.md`, `variables.tf`, `outputs.tf`, `versions.tf`, `examples/basic/`,
  `tests/`.
- `required_providers` in the module; **no** `provider` block.
- Typed, described, validated inputs; meaningful outputs; secrets marked
  `sensitive`.
- Pin Git module sources with `?ref=` in production.

## Further reading

- [DevOps AI ToolKit](https://devopsaitoolkit.com/blog/)
