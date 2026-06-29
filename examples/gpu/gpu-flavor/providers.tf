# The OpenStack provider reads credentials from your environment. The cleanest
# approach is a clouds.yaml file plus `OS_CLOUD` (or the `cloud` argument). See
# ../../../docs/provider-configuration.md and ../../../sample-clouds/clouds.yaml.
#
# NOTE: Creating flavors is an ADMIN operation. The `cloud` you point at must map
# to credentials holding the admin role in Keystone.
provider "openstack" {
  cloud = var.cloud
}
