# A trunk port lets a single VM NIC carry traffic for several networks: one
# "parent" port carries the untagged (native) traffic, and each "sub-port" maps
# a separate network onto a VLAN ID that the guest sees on a tagged sub-interface.
#
# Topology: one parent network/subnet/port, plus two sub-port networks each with
# their own subnet and port. The trunk binds the parent port and attaches the two
# sub-ports with distinct VLAN segmentation IDs.

# ----- Parent network, subnet and port (untagged / native traffic) -----
resource "openstack_networking_network_v2" "parent" {
  name           = "${var.trunk_name}-parent"
  admin_state_up = true
  tags           = ["managed-by:terraform", "example:trunk-port"]
}

resource "openstack_networking_subnet_v2" "parent" {
  name        = "${var.trunk_name}-parent"
  network_id  = openstack_networking_network_v2.parent.id
  cidr        = var.parent_cidr
  ip_version  = 4
  enable_dhcp = true

  tags = ["managed-by:terraform", "example:trunk-port"]
}

resource "openstack_networking_port_v2" "parent" {
  name           = "${var.trunk_name}-parent"
  network_id     = openstack_networking_network_v2.parent.id
  admin_state_up = true

  fixed_ip {
    subnet_id = openstack_networking_subnet_v2.parent.id
  }

  tags = ["managed-by:terraform", "example:trunk-port"]
}

# ----- First sub-port network, subnet and port (VLAN-tagged) -----
resource "openstack_networking_network_v2" "sub1" {
  name           = "${var.trunk_name}-sub1"
  admin_state_up = true
  tags           = ["managed-by:terraform", "example:trunk-port"]
}

resource "openstack_networking_subnet_v2" "sub1" {
  name        = "${var.trunk_name}-sub1"
  network_id  = openstack_networking_network_v2.sub1.id
  cidr        = var.sub1_cidr
  ip_version  = 4
  enable_dhcp = true

  tags = ["managed-by:terraform", "example:trunk-port"]
}

resource "openstack_networking_port_v2" "sub1" {
  name           = "${var.trunk_name}-sub1"
  network_id     = openstack_networking_network_v2.sub1.id
  admin_state_up = true

  fixed_ip {
    subnet_id = openstack_networking_subnet_v2.sub1.id
  }

  tags = ["managed-by:terraform", "example:trunk-port"]
}

# ----- Second sub-port network, subnet and port (VLAN-tagged) -----
resource "openstack_networking_network_v2" "sub2" {
  name           = "${var.trunk_name}-sub2"
  admin_state_up = true
  tags           = ["managed-by:terraform", "example:trunk-port"]
}

resource "openstack_networking_subnet_v2" "sub2" {
  name        = "${var.trunk_name}-sub2"
  network_id  = openstack_networking_network_v2.sub2.id
  cidr        = var.sub2_cidr
  ip_version  = 4
  enable_dhcp = true

  tags = ["managed-by:terraform", "example:trunk-port"]
}

resource "openstack_networking_port_v2" "sub2" {
  name           = "${var.trunk_name}-sub2"
  network_id     = openstack_networking_network_v2.sub2.id
  admin_state_up = true

  fixed_ip {
    subnet_id = openstack_networking_subnet_v2.sub2.id
  }

  tags = ["managed-by:terraform", "example:trunk-port"]
}

# ----- The trunk: bind the parent port, attach two VLAN sub-ports -----
resource "openstack_networking_trunk_v2" "this" {
  name           = var.trunk_name
  port_id        = openstack_networking_port_v2.parent.id
  admin_state_up = true

  sub_port {
    port_id           = openstack_networking_port_v2.sub1.id
    segmentation_id   = var.sub1_seg_id
    segmentation_type = "vlan"
  }

  sub_port {
    port_id           = openstack_networking_port_v2.sub2.id
    segmentation_id   = var.sub2_seg_id
    segmentation_type = "vlan"
  }

  tags = ["managed-by:terraform", "example:trunk-port"]
}
