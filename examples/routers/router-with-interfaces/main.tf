# Resolve the external network by name (asserting it is external) for the gateway.
data "openstack_networking_network_v2" "external" {
  name     = var.external_network_name
  external = true
}

# Router with an external gateway. Internal subnets are attached below.
resource "openstack_networking_router_v2" "router" {
  name                = var.router_name
  admin_state_up      = true
  external_network_id = data.openstack_networking_network_v2.external.id
  enable_snat         = var.enable_snat
  tags                = var.tags
}

# One router interface per subnet. for_each (keyed by subnet UUID) keeps each
# attachment independent in state, so adding or removing a subnet only touches
# that one interface. Each interface gives the router a leg (the subnet's
# gateway IP) on that subnet so the subnets can route to each other and out
# through the gateway.
resource "openstack_networking_router_interface_v2" "interface" {
  for_each = var.subnet_ids

  router_id = openstack_networking_router_v2.router.id
  subnet_id = each.value
}
