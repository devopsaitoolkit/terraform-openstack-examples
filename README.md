<div align="center">

# ☁️ terraform-openstack-examples

**The most comprehensive collection of production-quality Terraform examples for OpenStack.**

100+ real-world examples · reusable modules · diagrams · automation · tested in CI.

[![CI](https://github.com/devopsaitoolkit/terraform-openstack-examples/actions/workflows/ci.yml/badge.svg)](https://github.com/devopsaitoolkit/terraform-openstack-examples/actions/workflows/ci.yml)
[![Link check](https://github.com/devopsaitoolkit/terraform-openstack-examples/actions/workflows/link-check.yml/badge.svg)](https://github.com/devopsaitoolkit/terraform-openstack-examples/actions/workflows/link-check.yml)
[![TFLint](https://github.com/devopsaitoolkit/terraform-openstack-examples/actions/workflows/tflint.yml/badge.svg)](https://github.com/devopsaitoolkit/terraform-openstack-examples/actions/workflows/tflint.yml)
[![tfsec](https://github.com/devopsaitoolkit/terraform-openstack-examples/actions/workflows/tfsec.yml/badge.svg)](https://github.com/devopsaitoolkit/terraform-openstack-examples/actions/workflows/tfsec.yml)
[![License: Apache-2.0](https://img.shields.io/badge/license-Apache--2.0-blue.svg)](./LICENSE)
[![Terraform](https://img.shields.io/badge/terraform-%3E%3D1.3-7B42BC.svg)](https://www.terraform.io/)
[![Provider](https://img.shields.io/badge/openstack%20provider-~%3E%203.0-da1a32.svg)](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest)
[![PRs welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](./CONTRIBUTING.md)

</div>

---

Most OpenStack Terraform content stops at a single VM and a network. Real
private clouds need boot-from-volume, Octavia load balancers, application
credentials, multi-region, quotas, GPU instances, and HA — done safely. This
repository is the reference library for exactly that: **complete, copy-pasteable,
CI-validated** Terraform for OpenStack, each example documented like production
code.

> ⭐ **If this saves you time, star the repo** — it helps other OpenStack
> operators find it.

## Why this repository

- **Production, not toys.** Every example reflects real enterprise patterns:
  documented variables, outputs, tags, least-privilege security, and a
  troubleshooting guide.
- **Current and safe.** Targets the modern `openstack ~> 3.0` provider and
  `terraform >= 1.3`; no deprecated syntax. Examples never commit secrets.
- **Actually validated.** CI runs `terraform fmt`, `terraform validate` on every
  example and module, and native `terraform test` (with `mock_provider`, so it
  needs no real cloud).
- **Reusable modules** you can pull straight into your own root modules.

## Quick start

```bash
git clone https://github.com/devopsaitoolkit/terraform-openstack-examples.git
cd terraform-openstack-examples

# Configure auth once (see docs/provider-configuration.md)
cp sample-clouds/clouds.yaml ~/.config/openstack/clouds.yaml   # then edit
export OS_CLOUD=openstack

# Run any example
cd examples/compute/single-instance
cp terraform.tfvars.example terraform.tfvars
terraform init && terraform plan
```

## What's inside

| Area | Contents |
|------|----------|
| 📁 [`examples/`](./examples/) | 100+ standalone examples across 20+ categories |
| 🧩 [`modules/`](./modules/) | Reusable modules (compute, networking, security group, volume, project, user, image, router, floating IP, load balancer) |
| 📚 [`docs/`](./docs/) | Provider config, clouds.yaml, application credentials, remote state, modules, testing, importing, state, upgrades |
| 🗺️ [`docs/diagrams.md`](./docs/diagrams.md) | Mermaid diagrams: workflow, architecture, networking, volumes, modules |
| 🔧 [`scripts/`](./scripts/) | fmt / validate / plan / apply / destroy / import / state / backend helpers with safety checks |
| ☁️ [`sample-clouds/`](./sample-clouds/) | Sanitized `clouds.yaml` (password + application credential) |

## Example catalog

| Category | Examples |
|----------|----------|
| [Compute](./examples/compute/) | single & multiple instances, boot-from-volume, GPU, dedicated hosts, AZs, metadata, user-data, cloud-init, server groups, multi-NIC |
| [Networking](./examples/networking/) | networks, subnets, routers, provider networks, VLANs, security groups, port security, multi-NIC, IPv6, trunk ports, RBAC |
| [Storage](./examples/storage/) | Cinder volumes, attachments, snapshots, boot-from-volume, backups, volume types, multiattach |
| [Images](./examples/images/) | upload, properties, protected, hidden, from-volume |
| [Security](./examples/security/) | security group rules, remote-group rules, default-deny, key pairs, FWaaS |
| [Identity](./examples/identity/) | projects, users, roles, groups, domains, application credentials |
| [Load balancers](./examples/load-balancers/) | Octavia LB, listeners, pools, health monitors, L7 policies, TLS termination |
| [Floating IPs](./examples/floating-ips/) · [Routers](./examples/routers/) · [DNS](./examples/dns/) | association, pools, gateways, static routes, Designate zones & records |
| [Quotas](./examples/quotas/) · [Backup](./examples/backup/) · [Snapshots](./examples/snapshots/) | compute/network/storage quotas, volume backups, snapshots |
| [HA](./examples/high-availability/) · [Multi-region](./examples/multi-region/) · [GPU](./examples/gpu/) · [Kolla-Ansible](./examples/kolla-ansible/) | anti-affinity, LB-backed web, cross-region, vGPU/PCI passthrough, Kolla infra |

## Reusable modules

```hcl
module "web" {
  source = "github.com/devopsaitoolkit/terraform-openstack-examples//modules/compute"

  name         = "web"
  instance_count = 3
  flavor_name  = "m1.large"
  image_name   = "ubuntu-22.04"
  network_id   = module.network.network_id
}
```

See [`modules/`](./modules/) — each module ships a README, variables, outputs,
a runnable example, and `mock_provider` tests.

## Target audience

Terraform & OpenStack engineers · platform & infrastructure engineers · private
cloud teams · the OpenInfra & Kolla-Ansible community · DevOps engineers · SREs.

## Contributing

Operator experience is what makes this library great. Adding an example takes 20
minutes and helps the whole community.

- 📄 [Contributing guide](./CONTRIBUTING.md)
- ➕ [Request an example or module](https://github.com/devopsaitoolkit/terraform-openstack-examples/issues/new?template=example_request.yml)
- 💬 [Discussions](https://github.com/devopsaitoolkit/terraform-openstack-examples/discussions)
- 🧭 [Roadmap](./ROADMAP.md) — Registry modules, CLI, MCP server, VS Code extension

By participating you agree to our [Code of Conduct](./CODE_OF_CONDUCT.md).

## License

[Apache-2.0](./LICENSE). Use the examples and modules freely in your own
infrastructure.

## Further reading & free resources

This repository stands on its own. If you want to go deeper on **AI-assisted**
OpenStack and Terraform operations, these free resources from the maintainers
help you keep learning:

- 📚 [Advanced OpenStack & Terraform guides](https://devopsaitoolkit.com/blog/)
- 🧪 [Terraform & config validators](https://devopsaitoolkit.com/validators/)
- 🤖 [AI Incident Response Assistant](https://devopsaitoolkit.com/dashboard/incident-response/)
- 💡 [Prompt library](https://devopsaitoolkit.com/prompts/)
- ✉️ [Weekly DevOps newsletter](https://devopsaitoolkit.com/#newsletter)

---

<div align="center">

**Built by engineers who run OpenStack in production.**
If it helps you, [give it a ⭐](https://github.com/devopsaitoolkit/terraform-openstack-examples).

</div>
