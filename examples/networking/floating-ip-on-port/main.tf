# A tenant network + subnet to host the port that will receive the floating IP.
resource "openstack_networking_network_v2" "this" {
  name           = var.network_name
  admin_state_up = true
  tags           = ["managed-by:terraform", "example:floating-ip-on-port"]
}

resource "openstack_networking_subnet_v2" "this" {
  name       = var.subnet_name
  network_id = openstack_networking_network_v2.this.id
  cidr       = var.cidr
  ip_version = 4
  tags       = ["managed-by:terraform", "example:floating-ip-on-port"]
}

# The Neutron port the workload (e.g. an instance) would bind to. Creating the
# port explicitly lets us associate the floating IP without depending on a VM.
resource "openstack_networking_port_v2" "vm" {
  name           = "${var.network_name}-vm-port"
  network_id     = openstack_networking_network_v2.this.id
  admin_state_up = true
  tags           = ["managed-by:terraform", "example:floating-ip-on-port"]

  fixed_ip {
    subnet_id = openstack_networking_subnet_v2.this.id
  }
}

# Allocate a floating IP from the external pool.
resource "openstack_networking_floatingip_v2" "this" {
  pool = var.floating_ip_pool
  tags = ["managed-by:terraform", "example:floating-ip-on-port"]
}

# Bind the floating IP to the port. Kept as a separate association resource so
# the FIP allocation and its binding can be managed independently.
resource "openstack_networking_floatingip_associate_v2" "this" {
  floating_ip = openstack_networking_floatingip_v2.this.address
  port_id     = openstack_networking_port_v2.vm.id
}
