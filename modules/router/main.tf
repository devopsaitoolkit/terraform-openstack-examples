resource "openstack_networking_router_v2" "this" {
  name                = var.name
  admin_state_up      = var.admin_state_up
  external_network_id = var.external_network_id
  enable_snat         = var.enable_snat
}

# One interface per attached subnet. toset() keys the resources by subnet ID so
# adding/removing a subnet only touches that interface.
resource "openstack_networking_router_interface_v2" "this" {
  for_each = toset(var.subnet_ids)

  router_id = openstack_networking_router_v2.this.id
  subnet_id = each.value
}
