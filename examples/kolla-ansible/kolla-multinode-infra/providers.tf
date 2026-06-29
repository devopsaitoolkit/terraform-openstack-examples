# Single-region example. Credentials come from the selected clouds.yaml entry
# (see ../../../sample-clouds/clouds.yaml).
provider "openstack" {
  cloud = var.cloud
}
