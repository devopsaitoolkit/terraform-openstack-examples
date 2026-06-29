# The OpenStack provider reads credentials from your environment. The cleanest
# approach is a clouds.yaml file plus `OS_CLOUD` (or the `cloud` argument). See
# ../../../docs/provider-configuration.md and ../../../sample-clouds/clouds.yaml.
provider "openstack" {
  cloud = var.cloud
}

# The local provider writes the rendered file_sd targets file to disk. It needs
# no credentials.
provider "local" {}
