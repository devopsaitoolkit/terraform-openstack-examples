# A network in region 1 using the default provider.
resource "openstack_networking_network_v2" "region1" {
  name           = "${var.network_name}-region1"
  admin_state_up = true
  tags           = var.tags
}

# A network in region 2. The only difference is `provider = openstack.region2`,
# which routes this resource through the aliased provider (a second cloud entry).
resource "openstack_networking_network_v2" "region2" {
  provider = openstack.region2

  name           = "${var.network_name}-region2"
  admin_state_up = true
  tags           = var.tags
}
