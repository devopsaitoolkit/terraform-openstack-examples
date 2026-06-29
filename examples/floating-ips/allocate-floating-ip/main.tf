# Look up the external network by name and assert it is external, so we never
# hard-code a per-cloud UUID and never accidentally point at a tenant network.
data "openstack_networking_network_v2" "external" {
  name     = var.external_network_name
  external = true
}

# Allocate a floating IP from the external network's pool. With no port_id set,
# the address is reserved to the project but not yet attached to anything.
resource "openstack_networking_floatingip_v2" "fip" {
  pool        = data.openstack_networking_network_v2.external.name
  description = var.description
  tags        = var.tags
}
