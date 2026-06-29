resource "openstack_networking_floatingip_v2" "this" {
  count = var.fip_count

  pool        = var.pool
  description = var.description != "" ? var.description : null
}

# Associate each supplied port with the floating IP at the same index. When
# port_ids is empty no associations are created (the floating IPs stay
# unattached). If more ports than floating IPs are supplied the index lookup
# fails at plan time, surfacing the misconfiguration early.
resource "openstack_networking_floatingip_associate_v2" "this" {
  count = length(var.port_ids)

  floating_ip = openstack_networking_floatingip_v2.this[count.index].address
  port_id     = var.port_ids[count.index]
}
