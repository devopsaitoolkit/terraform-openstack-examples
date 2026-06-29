# A tenant network plus a DHCP-enabled subnet that also pushes static routes to
# instances. Host routes are the classic DHCP-pushed static routes mechanism: the
# DHCP agent advertises them (DHCP option 121) so every instance on the subnet
# learns them at lease time — no per-instance config.
#
# In provider v3 the inline subnet `host_routes` block was removed; host routes
# are now managed with the dedicated `openstack_networking_subnet_route_v2`
# resource (one entry per route), which is what we use below.
resource "openstack_networking_network_v2" "this" {
  name           = var.network_name
  admin_state_up = true
  tags           = ["managed-by:terraform", "example:dhcp-and-host-routes"]
}

resource "openstack_networking_subnet_v2" "this" {
  name            = var.subnet_name
  network_id      = openstack_networking_network_v2.this.id
  cidr            = var.cidr
  ip_version      = 4
  enable_dhcp     = true
  dns_nameservers = var.dns_nameservers

  allocation_pool {
    start = var.allocation_start
    end   = var.allocation_end
  }

  tags = ["managed-by:terraform", "example:dhcp-and-host-routes"]
}

# One subnet route per entry in var.host_routes. Each is advertised to instances
# via DHCP (option 121) so they route destination_cidr through next_hop. Keyed by
# destination_cidr so the for_each map is stable across plans.
resource "openstack_networking_subnet_route_v2" "host_route" {
  for_each = { for route in var.host_routes : route.destination_cidr => route }

  subnet_id        = openstack_networking_subnet_v2.this.id
  destination_cidr = each.value.destination_cidr
  next_hop         = each.value.next_hop
}
