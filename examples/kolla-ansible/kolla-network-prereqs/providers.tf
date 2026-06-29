# Single-region example. Credentials come from the selected clouds.yaml entry
# (see ../../../sample-clouds/clouds.yaml and ../../../docs/provider-configuration.md).
provider "openstack" {
  cloud = var.cloud
}
