# security-group — basic example

Creates a web-tier security group (ports 80/443 open, SSH from RFC1918) using the [`security-group`](../../) module.

## Usage

```bash
export OS_CLOUD=openstack   # or pass -var 'cloud=openstack'
terraform init
terraform plan
terraform apply
```

Tighten the `remote_ip_prefix` values in `main.tf` to your trusted ranges before applying.
