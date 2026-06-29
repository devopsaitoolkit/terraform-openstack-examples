# Multi-region pattern: declare one provider block per region/cloud. Each block
# points at a different entry in clouds.yaml (see ../../../sample-clouds/clouds.yaml).
#
# The first (un-aliased) block is the default provider. Every additional region
# gets an `alias` and resources opt into it with `provider = openstack.<alias>`.

# Default provider -> region 1.
provider "openstack" {
  cloud = var.cloud_region1
}

# Aliased provider -> region 2 (a second clouds.yaml entry / second region).
provider "openstack" {
  alias = "region2"
  cloud = var.cloud_region2
}
