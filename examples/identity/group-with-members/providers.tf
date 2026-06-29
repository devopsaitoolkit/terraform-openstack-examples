# The OpenStack provider reads credentials from your environment. The cleanest
# approach is a clouds.yaml file plus `OS_CLOUD` (or the `cloud` argument). See
# ../../../docs/provider-configuration.md and ../../../sample-clouds/clouds.yaml.
#
# Note: every resource in this identity example is Keystone-scoped and most
# require an ADMIN (or domain-admin) role to apply. Use a cloud entry whose
# credentials are admin-scoped.
provider "openstack" {
  cloud = var.cloud
}
