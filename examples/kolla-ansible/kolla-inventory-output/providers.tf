# OpenStack provider for the instances; the local provider renders the Ansible
# inventory file to disk. See ../../../sample-clouds/clouds.yaml.
provider "openstack" {
  cloud = var.cloud
}

provider "local" {}
