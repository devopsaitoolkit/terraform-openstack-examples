# compute — basic example

Launches two instances on the `private` network using the [`compute`](../../) module.

## Usage

```bash
export OS_CLOUD=openstack   # or pass -var 'cloud=openstack'
terraform init
terraform plan
terraform apply
```

Adjust the flavor, image, and network name in `main.tf` to match your cloud.
