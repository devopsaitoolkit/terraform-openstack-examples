# A self-service (tenant) network plus an IPv4 subnet with DHCP. This is the
# foundational building block almost every other networking example depends on.
resource "openstack_networking_network_v2" "this" {
  name           = var.network_name
  admin_state_up = true
  tags           = ["managed-by:terraform", "example:network-and-subnet"]
}

resource "openstack_networking_subnet_v2" "this" {
  name            = var.subnet_name
  network_id      = openstack_networking_network_v2.this.id
  cidr            = var.cidr
  ip_version      = 4
  dns_nameservers = var.dns_nameservers
  enable_dhcp     = true

  allocation_pool {
    start = var.allocation_start
    end   = var.allocation_end
  }

  tags = ["managed-by:terraform", "example:network-and-subnet"]
}
