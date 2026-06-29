# Look up the external network by name and assert it is external.
data "openstack_networking_network_v2" "external" {
  name     = var.external_network_name
  external = true
}

# Reserve a pool of floating IPs, one per logical name. for_each (keyed by the
# name) keeps each address stable in state: adding or removing a name only
# touches that one floating IP, never re-allocating the others. None are
# associated to a port, so they sit reserved until you wire them up later.
resource "openstack_networking_floatingip_v2" "reserved" {
  for_each = var.reserved_ip_names

  pool        = data.openstack_networking_network_v2.external.name
  description = "Reserved floating IP: ${each.key}"
  tags        = concat(var.tags, ["reservation:${each.key}"])
}
