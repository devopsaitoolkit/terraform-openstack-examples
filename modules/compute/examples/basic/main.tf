# Look up the network by name so the example doesn't hard-code a per-cloud UUID.
data "openstack_networking_network_v2" "network" {
  name = "private"
}

module "compute" {
  source = "../.."

  name                 = "example-app"
  instance_count       = 2
  flavor_name          = "m1.small"
  image_name           = "ubuntu-22.04"
  network_id           = data.openstack_networking_network_v2.network.id
  security_group_names = ["default"]
  metadata             = { example = "compute-module" }
  tags                 = ["managed-by:terraform", "example:compute-module"]
}
