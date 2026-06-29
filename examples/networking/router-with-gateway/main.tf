# Look up the external network by name so no UUID is hard-coded. This is the
# provider network that gives the router its gateway (and SNAT for egress).
data "openstack_networking_network_v2" "external" {
  name     = var.external_network_name
  external = true
}

# A tenant network + subnet so the router interface has something to attach to.
resource "openstack_networking_network_v2" "this" {
  name           = var.network_name
  admin_state_up = true
  tags           = ["managed-by:terraform", "example:router-with-gateway"]
}

resource "openstack_networking_subnet_v2" "this" {
  name        = var.subnet_name
  network_id  = openstack_networking_network_v2.this.id
  cidr        = var.cidr
  ip_version  = 4
  enable_dhcp = true
  tags        = ["managed-by:terraform", "example:router-with-gateway"]
}

# The router with an external gateway and SNAT enabled for outbound traffic.
resource "openstack_networking_router_v2" "this" {
  name                = var.router_name
  admin_state_up      = true
  external_network_id = data.openstack_networking_network_v2.external.id
  enable_snat         = true
  tags                = ["managed-by:terraform", "example:router-with-gateway"]
}

# Attach the tenant subnet to the router so its instances can reach the gateway.
resource "openstack_networking_router_interface_v2" "this" {
  router_id = openstack_networking_router_v2.this.id
  subnet_id = openstack_networking_subnet_v2.this.id
}
