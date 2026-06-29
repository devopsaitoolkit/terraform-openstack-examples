# ADMIN-ONLY: a VLAN provider network tags traffic with an 802.1Q VLAN ID onto a
# physical bridge mapping. Requires the admin role AND a matching physical_network
# bridge mapping plus a permitted VLAN range on the hosts. Unlike flat networks,
# the segmentation_id (VLAN tag) is required and must fall inside the allowed range.
resource "openstack_networking_network_v2" "this" {
  name           = var.network_name
  admin_state_up = true
  tags           = ["managed-by:terraform", "example:vlan-network"]

  segments {
    network_type     = "vlan"
    physical_network = var.physical_network
    segmentation_id  = var.vlan_id
  }
}

resource "openstack_networking_subnet_v2" "this" {
  name            = var.subnet_name
  network_id      = openstack_networking_network_v2.this.id
  cidr            = var.cidr
  ip_version      = 4
  dns_nameservers = var.dns_nameservers
  enable_dhcp     = true
  tags            = ["managed-by:terraform", "example:vlan-network"]
}
