# project — basic example

Creates a top-level Keystone project using the [`project`](../../) module.

## Usage

```bash
export OS_CLOUD=openstack   # or pass -var 'cloud=openstack'
terraform init
terraform plan
terraform apply
```

Creating projects requires admin credentials in your `clouds.yaml` entry.
