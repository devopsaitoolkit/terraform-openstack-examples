# Look up the external network by name and assert it is external.
data "openstack_networking_network_v2" "external" {
  name     = var.external_network_name
  external = true
}

# Allocate the floating IP without a port_id, so association is managed by the
# explicit associate resource below. Keeping allocation and association as two
# resources lets you re-point the address at a different port without releasing
# (and changing) the public IP.
resource "openstack_networking_floatingip_v2" "fip" {
  pool        = data.openstack_networking_network_v2.external.name
  description = var.description
  tags        = var.tags
}

# Bind the floating IP to an existing port. fixed_ip is only needed when the
# port has more than one fixed IP.
resource "openstack_networking_floatingip_associate_v2" "fip_assoc" {
  floating_ip = openstack_networking_floatingip_v2.fip.address
  port_id     = var.port_id
  fixed_ip    = var.fixed_ip != "" ? var.fixed_ip : null
}
