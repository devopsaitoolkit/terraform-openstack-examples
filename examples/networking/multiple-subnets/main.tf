# A single tenant network carrying two independent IPv4 subnets. Multiple subnets
# on one network are handy for separating address ranges (e.g. app vs. data) while
# keeping them on the same L2 broadcast domain.
resource "openstack_networking_network_v2" "this" {
  name           = var.network_name
  admin_state_up = true
  tags           = ["managed-by:terraform", "example:multiple-subnets"]
}

resource "openstack_networking_subnet_v2" "a" {
  name            = var.subnet_a_name
  network_id      = openstack_networking_network_v2.this.id
  cidr            = var.cidr_a
  ip_version      = 4
  enable_dhcp     = true
  dns_nameservers = var.dns_nameservers
  tags            = ["managed-by:terraform", "example:multiple-subnets"]

  allocation_pool {
    start = cidrhost(var.cidr_a, 10)
    end   = cidrhost(var.cidr_a, 200)
  }
}

resource "openstack_networking_subnet_v2" "b" {
  name            = var.subnet_b_name
  network_id      = openstack_networking_network_v2.this.id
  cidr            = var.cidr_b
  ip_version      = 4
  enable_dhcp     = true
  dns_nameservers = var.dns_nameservers
  tags            = ["managed-by:terraform", "example:multiple-subnets"]

  allocation_pool {
    start = cidrhost(var.cidr_b, 10)
    end   = cidrhost(var.cidr_b, 200)
  }
}
