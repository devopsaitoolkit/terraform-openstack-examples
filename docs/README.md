# Documentation

Guides for using the Terraform examples and modules in this repository with the
[`terraform-provider-openstack/openstack`](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest)
provider (`~> 3.0`, Terraform/OpenTofu `>= 1.3`).

Every example and module authenticates the same way: a `clouds.yaml` file
selected with `OS_CLOUD` or the provider's `cloud` argument. If you are brand new
here, start with [Terraform basics](./terraform-basics.md) and
[clouds.yaml](./clouds-yaml.md), then run the reference example in
[`examples/compute/single-instance`](../examples/compute/single-instance).

## Getting started

- [Terraform basics for OpenStack](./terraform-basics.md) — the init / plan /
  apply / destroy workflow, providers, resources vs. data sources, variables and
  outputs.

## Authentication

- [Provider configuration](./provider-configuration.md) — the
  `required_providers` block, `cloud` vs. `OS_*` environment variables, regions,
  endpoints, `interface`, TLS, and debugging auth.
- [clouds.yaml](./clouds-yaml.md) — file structure and locations, `OS_CLOUD`,
  multiple clouds and regions, and splitting secrets into `secure.yaml`.
- [Application credentials](./application-credentials.md) — create and use
  scoped, revocable credentials for automation instead of a password.

## State

- [Remote state](./remote-state.md) — why remote state matters, the Swift
  backend, locking caveats, and migrating local → remote.
- [State management](./state-management.md) — `state list/show/mv/rm/pull/push`,
  `moved {}` blocks, recovering from drift, and backups.

## Authoring

- [Module design](./module-design.md) — designing reusable modules, inputs and
  outputs, composition, and version pinning with `?ref=`.
- [Testing](./testing.md) — `fmt`, `validate`, `tflint`, and native
  `terraform test` with `mock_provider` (no cloud required), plus CI.

## Operations

- [Importing resources](./importing-resources.md) — bring existing OpenStack
  resources under management with `import` and `import {}` blocks.
- [Version upgrades](./version-upgrades.md) — upgrading Terraform core, the
  provider v2 → v3 migration, and the `.terraform.lock.hcl` lock file.

## Repository layout

| Path | What it is |
|------|------------|
| [`examples/`](../examples) | 100+ runnable, single-purpose examples grouped by service (compute, networking, identity, load-balancers, …). |
| [`modules/`](../modules) | Reusable modules with their own `variables.tf`, `outputs.tf`, a runnable `examples/basic/`, and native `tests/`. |
| [`scripts/`](../scripts) | Thin, safe wrappers around Terraform (`tf-plan.sh`, `tf-import.sh`, `setup-remote-backend.sh`, …). See [scripts/README.md](../scripts/README.md). |
| [`sample-clouds/`](../sample-clouds) | A sample [`clouds.yaml`](../sample-clouds/clouds.yaml) to copy and adapt. |

## Further reading

- [DevOps AI ToolKit](https://devopsaitoolkit.com/blog/)
