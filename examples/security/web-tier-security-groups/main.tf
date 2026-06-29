resource "openstack_networking_secgroup_v2" "web" {
  name        = var.secgroup_name
  description = "Web tier with data-driven rule set (managed by Terraform)."
  tags        = var.tags
}

# One rule resource per map entry. for_each (not count) keys instances by name,
# so removing one rule never re-indexes and churns the others.
resource "openstack_networking_secgroup_rule_v2" "ingress" {
  for_each = var.ingress_rules

  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = each.value.protocol
  port_range_min    = each.value.port
  port_range_max    = each.value.port
  remote_ip_prefix  = each.value.cidr
  security_group_id = openstack_networking_secgroup_v2.web.id
  description       = "ingress:${each.key}"
}

resource "openstack_networking_secgroup_rule_v2" "egress_v4" {
  direction         = "egress"
  ethertype         = "IPv4"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.web.id
  description       = "Allow all IPv4 egress"
}
