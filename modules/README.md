# Modules

Reusable Terraform modules for OpenStack. Each module ships a `README.md`,
`variables.tf`, `outputs.tf`, `versions.tf`, a runnable `examples/basic/`, and
native `tests/*.tftest.hcl` that run under `terraform test` with a
`mock_provider` (no real cloud or credentials needed).

| Module | Purpose |
|--------|---------|
| [compute](./compute/) | One or more instances with networks, key pair, security groups |
| [networking](./networking/) | Network + subnet(s) with DHCP/DNS options |
| [security-group](./security-group/) | Security group with a flexible rule set |
| [volume](./volume/) | Cinder volume(s) with optional attachment |
| [project](./project/) | Keystone project with quotas |
| [user](./user/) | Keystone user with role assignments |
| [image](./image/) | Glance image with properties |
| [router](./router/) | Router with external gateway and interfaces |
| [floating-ip](./floating-ip/) | Floating IP with optional association |
| [loadbalancer](./loadbalancer/) | Octavia LB with listener, pool, and members |

## Usage

```hcl
module "network" {
  source     = "github.com/devopsaitoolkit/terraform-openstack-examples//modules/networking"
  name       = "app"
  cidr       = "10.20.0.0/24"
  dns_nameservers = ["1.1.1.1", "9.9.9.9"]
}
```

Pin to a tag in production: append `?ref=v1.0.0` to the source URL.
