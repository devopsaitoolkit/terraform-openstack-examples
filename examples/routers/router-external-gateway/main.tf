# Resolve the external network by name (asserting it is external) so the
# gateway is wired by UUID without hard-coding it per cloud.
data "openstack_networking_network_v2" "external" {
  name     = var.external_network_name
  external = true
}

# A router with an external gateway. enable_snat = true means instances on
# attached internal subnets share the gateway's address for outbound internet
# access (classic NAT). Attach internal subnets with router interfaces — see
# the router-with-interfaces example.
resource "openstack_networking_router_v2" "router" {
  name                = var.router_name
  admin_state_up      = var.admin_state_up
  external_network_id = data.openstack_networking_network_v2.external.id
  enable_snat         = var.enable_snat
  tags                = var.tags
}
