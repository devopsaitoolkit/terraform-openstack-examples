resource "openstack_networking_secgroup_v2" "this" {
  name        = var.name
  description = var.description
  tags        = var.tags
}

resource "openstack_networking_secgroup_rule_v2" "this" {
  # Key by list index so rules are stable and addressable; the list order is
  # the source of truth for what each rule represents.
  for_each = { for idx, rule in var.rules : tostring(idx) => rule }

  security_group_id = openstack_networking_secgroup_v2.this.id
  direction         = each.value.direction
  ethertype         = each.value.ethertype
  protocol          = each.value.protocol
  port_range_min    = each.value.port_min
  port_range_max    = each.value.port_max
  remote_ip_prefix  = each.value.remote_ip_prefix
}
