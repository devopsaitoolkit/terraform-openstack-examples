# Examples

100+ standalone, production-quality Terraform examples for OpenStack. Each lives
in its own directory and is self-contained: `terraform init && terraform plan`
from inside it.

Every example follows the same layout (`versions.tf`, `providers.tf`,
`variables.tf`, `main.tf`, `outputs.tf`, `terraform.tfvars.example`, `README.md`)
and documents architecture, inputs, outputs, best practices, security,
troubleshooting, and cleanup. The reference example is
[`compute/single-instance`](./compute/single-instance/).

## Categories

- [compute](./compute/) · [networking](./networking/) · [storage](./storage/) · [images](./images/)
- [security](./security/) · [identity](./identity/) · [load-balancers](./load-balancers/)
- [floating-ips](./floating-ips/) · [routers](./routers/) · [dns](./dns/)
- [projects](./projects/) · [users](./users/) · [quotas](./quotas/)
- [monitoring](./monitoring/) · [backup](./backup/) · [snapshots](./snapshots/)
- [gpu](./gpu/) · [high-availability](./high-availability/) · [multi-region](./multi-region/) · [kolla-ansible](./kolla-ansible/)

> Looking for reusable building blocks instead of full examples? See [`../modules/`](../modules/).
