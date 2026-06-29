# Credentials are read from clouds.yaml (or OS_* env vars). See the repo's
# docs/provider-configuration.md and sample-clouds/clouds.yaml.
provider "openstack" {
  cloud = var.cloud
}
