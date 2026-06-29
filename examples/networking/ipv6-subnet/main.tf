# A dual-stack network: one IPv4 subnet (DHCP) and one IPv6 subnet (SLAAC).
resource "openstack_networking_network_v2" "dualstack" {
  name           = var.network_name
  admin_state_up = true
  tags           = ["managed-by:terraform", "example:ipv6-subnet"]
}

# IPv4 subnet with DHCP for legacy/IPv4-only clients.
resource "openstack_networking_subnet_v2" "v4" {
  name        = "${var.network_name}-v4"
  network_id  = openstack_networking_network_v2.dualstack.id
  ip_version  = 4
  cidr        = var.cidr_v4
  enable_dhcp = true
  tags        = ["managed-by:terraform", "example:ipv6-subnet"]
}

# IPv6 subnet using SLAAC for both address assignment and router advertisements.
resource "openstack_networking_subnet_v2" "v6" {
  name              = "${var.network_name}-v6"
  network_id        = openstack_networking_network_v2.dualstack.id
  ip_version        = 6
  cidr              = var.cidr_v6
  ipv6_address_mode = "slaac"
  ipv6_ra_mode      = "slaac"
  tags              = ["managed-by:terraform", "example:ipv6-subnet"]
}
