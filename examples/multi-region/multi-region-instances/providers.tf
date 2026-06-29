# Two aliased providers, one per region. Resources and data sources select a
# region with the `provider` meta-argument. See sample-clouds/clouds.yaml for the
# matching `openstack` and `openstack-region2` entries.

provider "openstack" {
  cloud = var.cloud_region1
}

provider "openstack" {
  alias = "region2"
  cloud = var.cloud_region2
}
