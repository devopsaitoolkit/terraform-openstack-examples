# Resolve the external network by name (asserting it is external) for the gateway.
data "openstack_networking_network_v2" "external" {
  name     = var.external_network_name
  external = true
}

# Router with an external gateway. Static routes are added below.
resource "openstack_networking_router_v2" "router" {
  name                = var.router_name
  admin_state_up      = true
  external_network_id = data.openstack_networking_network_v2.external.id
  enable_snat         = var.enable_snat
  tags                = var.tags
}

# One static route per entry in var.routes. Managing routes as discrete
# router_route_v2 resources (rather than inline on the router) avoids the two
# fighting over the same attribute and lets for_each add/remove a single route
# without touching the others. Each next_hop must be reachable on a subnet the
# router already has an interface on.
resource "openstack_networking_router_route_v2" "route" {
  for_each = var.routes

  router_id        = openstack_networking_router_v2.router.id
  destination_cidr = each.value.destination_cidr
  next_hop         = each.value.next_hop
}
