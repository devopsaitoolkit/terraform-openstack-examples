# OpenStack security groups are STATEFUL by default (stateful = true). The reply
# traffic for any allowed connection is permitted automatically by conntrack, so
# we never write a matching reverse rule. delete_default_rules lets us lock down
# egress instead of inheriting allow-all.
resource "openstack_networking_secgroup_v2" "stateful" {
  name                 = var.secgroup_name
  description          = "Stateful security group with explicit egress lockdown."
  stateful             = true
  delete_default_rules = true
  tags                 = var.tags
}

# Ingress HTTPS. Because the group is stateful, the high-port return packets to
# the client need NO explicit egress rule — conntrack allows them.
resource "openstack_networking_secgroup_rule_v2" "https_in" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 443
  port_range_max    = 443
  remote_ip_prefix  = var.https_cidr
  security_group_id = openstack_networking_secgroup_v2.stateful.id
  description       = "HTTPS in (stateful: replies auto-allowed)"
}

# --- Egress lockdown: only DNS + outbound HTTPS to approved destinations. ---

resource "openstack_networking_secgroup_rule_v2" "dns_udp_out" {
  direction         = "egress"
  ethertype         = "IPv4"
  protocol          = "udp"
  port_range_min    = 53
  port_range_max    = 53
  remote_ip_prefix  = var.dns_resolver_cidr
  security_group_id = openstack_networking_secgroup_v2.stateful.id
  description       = "DNS (UDP) to approved resolver"
}

resource "openstack_networking_secgroup_rule_v2" "https_out" {
  direction         = "egress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 443
  port_range_max    = 443
  remote_ip_prefix  = var.egress_https_cidr
  security_group_id = openstack_networking_secgroup_v2.stateful.id
  description       = "HTTPS out to approved destinations only"
}
