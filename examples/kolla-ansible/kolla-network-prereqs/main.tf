###############################################################################
# Management network -- carries the Kolla control plane / API traffic
# (Kolla 'network_interface'). Internal tenant network with DHCP.
###############################################################################
resource "openstack_networking_network_v2" "management" {
  name           = "${var.name_prefix}-mgmt-net"
  admin_state_up = true
  tags           = concat(var.tags, ["kolla:management"])
}

resource "openstack_networking_subnet_v2" "management" {
  name            = "${var.name_prefix}-mgmt-subnet"
  network_id      = openstack_networking_network_v2.management.id
  cidr            = var.management_cidr
  ip_version      = 4
  enable_dhcp     = true
  dns_nameservers = var.dns_nameservers
  tags            = concat(var.tags, ["kolla:management"])
}

###############################################################################
# Tunnel network -- overlay (VXLAN) tenant traffic between compute/network
# nodes (Kolla 'tunnel_interface'). Internal, isolated from the management net.
###############################################################################
resource "openstack_networking_network_v2" "tunnel" {
  name           = "${var.name_prefix}-tunnel-net"
  admin_state_up = true
  tags           = concat(var.tags, ["kolla:tunnel"])
}

resource "openstack_networking_subnet_v2" "tunnel" {
  name        = "${var.name_prefix}-tunnel-subnet"
  network_id  = openstack_networking_network_v2.tunnel.id
  cidr        = var.tunnel_cidr
  ip_version  = 4
  enable_dhcp = true
  tags        = concat(var.tags, ["kolla:tunnel"])
}

###############################################################################
# External / provider network -- north-south traffic and floating IPs
# (Kolla 'neutron_external_interface'). Marked external; provider attributes are
# passed via value_specs so they match your ml2/bridge mappings.
###############################################################################
resource "openstack_networking_network_v2" "external" {
  name           = "${var.name_prefix}-external-net"
  admin_state_up = true
  external       = true
  tags           = concat(var.tags, ["kolla:external"])

  value_specs = {
    "provider:network_type"     = var.external_network_type
    "provider:physical_network" = var.external_physical_network
  }
}

resource "openstack_networking_subnet_v2" "external" {
  name        = "${var.name_prefix}-external-subnet"
  network_id  = openstack_networking_network_v2.external.id
  cidr        = var.external_cidr
  ip_version  = 4
  gateway_ip  = var.external_gateway_ip
  enable_dhcp = false
  tags        = concat(var.tags, ["kolla:external"])

  allocation_pool {
    start = var.external_allocation_start
    end   = var.external_allocation_end
  }
}
