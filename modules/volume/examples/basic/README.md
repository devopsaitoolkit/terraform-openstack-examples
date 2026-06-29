# volume — basic example

Creates two unattached 50 GB volumes using the [`volume`](../../) module.

## Usage

```bash
export OS_CLOUD=openstack   # or pass -var 'cloud=openstack'
terraform init
terraform plan
terraform apply
```

Set `attach_to_instance_id` in `main.tf` to a real instance UUID to attach the volumes on apply.
