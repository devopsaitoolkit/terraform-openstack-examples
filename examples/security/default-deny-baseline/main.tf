# delete_default_rules = true strips the two permissive egress rules OpenStack
# normally creates (IPv4 + IPv6 to anywhere). Combined with zero ingress rules,
# the group starts as DENY-ALL in both directions; we then add back only what
# the workload genuinely needs. This is the default-deny posture.
resource "openstack_networking_secgroup_v2" "baseline" {
  name                 = var.secgroup_name
  description          = "Default-deny baseline: no ingress, only required egress."
  delete_default_rules = true
  tags                 = var.tags
}

# --- No ingress rules on purpose. Nothing can initiate a connection inbound. ---

# Egress: DNS (UDP/53) to the approved resolver only.
resource "openstack_networking_secgroup_rule_v2" "dns_udp_out" {
  direction         = "egress"
  ethertype         = "IPv4"
  protocol          = "udp"
  port_range_min    = 53
  port_range_max    = 53
  remote_ip_prefix  = var.dns_resolver_cidr
  security_group_id = openstack_networking_secgroup_v2.baseline.id
  description       = "DNS (UDP) to approved resolver"
}

# Egress: DNS (TCP/53) for large responses / zone transfers fallback.
resource "openstack_networking_secgroup_rule_v2" "dns_tcp_out" {
  direction         = "egress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 53
  port_range_max    = 53
  remote_ip_prefix  = var.dns_resolver_cidr
  security_group_id = openstack_networking_secgroup_v2.baseline.id
  description       = "DNS (TCP) to approved resolver"
}

# Egress: HTTPS (TCP/443) to the approved destination range only.
resource "openstack_networking_secgroup_rule_v2" "https_out" {
  direction         = "egress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 443
  port_range_max    = 443
  remote_ip_prefix  = var.egress_https_cidr
  security_group_id = openstack_networking_secgroup_v2.baseline.id
  description       = "HTTPS to approved destinations"
}
