# Resolve the external/provider network by name (asserting it is external) for
# the gateway.
data "openstack_networking_network_v2" "external" {
  name     = var.external_network_name
  external = true
}

# Router with an external gateway but SNAT turned OFF. Traffic from internal
# subnets keeps its original source IP instead of being masqueraded behind the
# gateway address. This only works when the upstream network/fabric knows how to
# route the internal CIDRs back (e.g. routed provider networks, BGP/dynamic
# routing, or static routes on upstream devices). See the README for when to
# disable SNAT.
resource "openstack_networking_router_v2" "router" {
  name                = var.router_name
  admin_state_up      = true
  external_network_id = data.openstack_networking_network_v2.external.id
  enable_snat         = var.enable_snat
  tags                = var.tags
}
