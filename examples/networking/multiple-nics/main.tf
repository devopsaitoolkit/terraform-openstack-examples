# Two independent networks + subnets, then one port on each. An instance can
# consume both ports to get two NICs (see the README note).

# --- Network / subnet A ---
resource "openstack_networking_network_v2" "a" {
  name           = "${var.name_prefix}-net-a"
  admin_state_up = true
  tags           = ["managed-by:terraform", "example:multiple-nics"]
}

resource "openstack_networking_subnet_v2" "a" {
  name       = "${var.name_prefix}-subnet-a"
  network_id = openstack_networking_network_v2.a.id
  cidr       = var.cidr_a
  ip_version = 4
  tags       = ["managed-by:terraform", "example:multiple-nics"]
}

# --- Network / subnet B ---
resource "openstack_networking_network_v2" "b" {
  name           = "${var.name_prefix}-net-b"
  admin_state_up = true
  tags           = ["managed-by:terraform", "example:multiple-nics"]
}

resource "openstack_networking_subnet_v2" "b" {
  name       = "${var.name_prefix}-subnet-b"
  network_id = openstack_networking_network_v2.b.id
  cidr       = var.cidr_b
  ip_version = 4
  tags       = ["managed-by:terraform", "example:multiple-nics"]
}

# --- Port A (first NIC) ---
resource "openstack_networking_port_v2" "a" {
  name           = "${var.name_prefix}-port-a"
  network_id     = openstack_networking_network_v2.a.id
  admin_state_up = true
  tags           = ["managed-by:terraform", "example:multiple-nics"]

  fixed_ip {
    subnet_id = openstack_networking_subnet_v2.a.id
  }
}

# --- Port B (second NIC) ---
resource "openstack_networking_port_v2" "b" {
  name           = "${var.name_prefix}-port-b"
  network_id     = openstack_networking_network_v2.b.id
  admin_state_up = true
  tags           = ["managed-by:terraform", "example:multiple-nics"]

  fixed_ip {
    subnet_id = openstack_networking_subnet_v2.b.id
  }
}
