# ADMIN-ONLY: provider networks map directly onto a physical L2 segment via the
# `segments` block. Creating one requires the admin role AND a matching
# bridge mapping (physical_network) configured on the Neutron/compute hosts.
# A regular project token will be rejected. Flat networks ignore segmentation_id.
resource "openstack_networking_network_v2" "this" {
  name           = var.network_name
  admin_state_up = true
  tags           = ["managed-by:terraform", "example:provider-network"]

  segments {
    network_type     = var.network_type
    physical_network = var.physical_network
    segmentation_id  = var.segmentation_id
  }
}

resource "openstack_networking_subnet_v2" "this" {
  name        = var.subnet_name
  network_id  = openstack_networking_network_v2.this.id
  cidr        = var.cidr
  ip_version  = 4
  enable_dhcp = true
  tags        = ["managed-by:terraform", "example:provider-network"]
}
