# networking — basic example

Creates a `192.168.42.0/24` tenant network and subnet using the [`networking`](../../) module.

## Usage

```bash
export OS_CLOUD=openstack   # or pass -var 'cloud=openstack'
terraform init
terraform plan
terraform apply
```

Adjust the CIDR, DNS servers, and allocation pool in `main.tf` to match your environment.
