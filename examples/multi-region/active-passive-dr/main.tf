###############################################################################
# PRIMARY (active) stack -- region 1, default provider.
###############################################################################

resource "openstack_networking_network_v2" "primary" {
  name           = "${var.name_prefix}-primary-net"
  admin_state_up = true
  tags           = concat(var.tags, ["role:primary"])
}

resource "openstack_networking_subnet_v2" "primary" {
  name            = "${var.name_prefix}-primary-subnet"
  network_id      = openstack_networking_network_v2.primary.id
  cidr            = var.subnet_cidr
  ip_version      = 4
  enable_dhcp     = true
  dns_nameservers = var.dns_nameservers
  tags            = concat(var.tags, ["role:primary"])
}

resource "openstack_compute_instance_v2" "primary" {
  count = var.primary_instance_count

  name            = "${var.name_prefix}-primary-${count.index}"
  flavor_name     = var.flavor_name
  image_name      = var.image_name
  key_pair        = var.key_pair_name != "" ? var.key_pair_name : null
  security_groups = var.security_group_names
  tags            = concat(var.tags, ["role:primary"])

  network {
    uuid = openstack_networking_network_v2.primary.id
  }

  lifecycle {
    ignore_changes = [image_name]
  }
}

###############################################################################
# STANDBY (passive / DR) stack -- region 2, aliased provider.
#
# The network + subnet always exist (so failover does not wait on Neutron), but
# instances are gated by standby_instance_count, which defaults to 0. To fail
# over, set standby_instance_count > 0 (and typically primary_instance_count 0).
###############################################################################

resource "openstack_networking_network_v2" "standby" {
  provider = openstack.standby

  name           = "${var.name_prefix}-standby-net"
  admin_state_up = true
  tags           = concat(var.tags, ["role:standby"])
}

resource "openstack_networking_subnet_v2" "standby" {
  provider = openstack.standby

  name            = "${var.name_prefix}-standby-subnet"
  network_id      = openstack_networking_network_v2.standby.id
  cidr            = var.subnet_cidr
  ip_version      = 4
  enable_dhcp     = true
  dns_nameservers = var.dns_nameservers
  tags            = concat(var.tags, ["role:standby"])
}

resource "openstack_compute_instance_v2" "standby" {
  provider = openstack.standby
  count    = var.standby_instance_count

  name            = "${var.name_prefix}-standby-${count.index}"
  flavor_name     = var.flavor_name
  image_name      = var.image_name
  key_pair        = var.key_pair_name != "" ? var.key_pair_name : null
  security_groups = var.security_group_names
  tags            = concat(var.tags, ["role:standby"])

  network {
    uuid = openstack_networking_network_v2.standby.id
  }

  lifecycle {
    ignore_changes = [image_name]
  }
}
