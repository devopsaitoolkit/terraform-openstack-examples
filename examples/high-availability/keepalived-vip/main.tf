# Look up the network and subnet by name so we don't hard-code IDs that differ
# per cloud. The subnet is where the VIP is reserved and where the nodes get IPs.
data "openstack_networking_network_v2" "network" {
  name = var.network_name
}

data "openstack_networking_subnet_v2" "subnet" {
  name       = var.subnet_name
  network_id = data.openstack_networking_network_v2.network.id
}

# Per-node VRRP role: node 0 is MASTER (higher priority), node 1 is BACKUP.
locals {
  nodes = [
    { state = "MASTER", priority = 150 },
    { state = "BACKUP", priority = 100 },
  ]
}

# Security group for the pair: SSH from admins, the service port, plus VRRP.
resource "openstack_networking_secgroup_v2" "vip" {
  name        = "${var.name_prefix}-sg"
  description = "keepalived/VRRP pair sharing a VIP (managed by Terraform)."
  tags        = var.tags
}

resource "openstack_networking_secgroup_rule_v2" "ssh_in" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = var.admin_ssh_cidr
  security_group_id = openstack_networking_secgroup_v2.vip.id
  description       = "SSH from admin CIDR"
}

resource "openstack_networking_secgroup_rule_v2" "service_in" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = var.service_port
  port_range_max    = var.service_port
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.vip.id
  description       = "Service traffic to the VIP"
}

# VRRP advertisements (IP protocol 112) must be allowed between the peers. We
# scope them to the subnet CIDR so only on-segment nodes participate.
resource "openstack_networking_secgroup_rule_v2" "vrrp_in" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "112"
  remote_ip_prefix  = data.openstack_networking_subnet_v2.subnet.cidr
  security_group_id = openstack_networking_secgroup_v2.vip.id
  description       = "VRRP advertisements between keepalived peers"
}

resource "openstack_networking_secgroup_rule_v2" "egress_v4" {
  direction         = "egress"
  ethertype         = "IPv4"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.vip.id
  description       = "Allow all IPv4 egress"
}

# A dedicated port that reserves the VIP in Neutron so IPAM never hands the
# address to anything else. It is not attached to an instance — it just owns the
# IP. keepalived moves the live VIP between the node ports below via VRRP/ARP.
resource "openstack_networking_port_v2" "vip" {
  name           = "${var.name_prefix}-vip"
  network_id     = data.openstack_networking_network_v2.network.id
  admin_state_up = true

  fixed_ip {
    subnet_id  = data.openstack_networking_subnet_v2.subnet.id
    ip_address = var.vip_address
  }
}

# One Neutron port per node. Each gets its own fixed IP AND declares the VIP in
# allowed_address_pairs. Without this, Neutron's port-security anti-spoofing
# would DROP any packet (and the gratuitous ARP) sourced from the VIP, so the
# floating address would be unreachable no matter what keepalived does.
resource "openstack_networking_port_v2" "node" {
  count = length(local.nodes)

  name               = "${var.name_prefix}-port-${count.index}"
  network_id         = data.openstack_networking_network_v2.network.id
  admin_state_up     = true
  security_group_ids = [openstack_networking_secgroup_v2.vip.id]

  fixed_ip {
    subnet_id = data.openstack_networking_subnet_v2.subnet.id
  }

  # Whitelist the shared VIP so the node may emit/receive traffic for it.
  allowed_address_pairs {
    ip_address = var.vip_address
  }
}

data "openstack_images_image_v2" "image" {
  name        = var.image_name
  most_recent = true
}

data "openstack_compute_flavor_v2" "flavor" {
  name = var.flavor_name
}

# Two instances, each bound to its pre-created port. keepalived (installed via
# cloud-init) negotiates which node holds the VIP and fails it over on failure.
resource "openstack_compute_instance_v2" "node" {
  count = length(local.nodes)

  name      = "${var.name_prefix}-${count.index}"
  flavor_id = data.openstack_compute_flavor_v2.flavor.id
  image_id  = data.openstack_images_image_v2.image.id
  key_pair  = var.key_pair_name != "" ? var.key_pair_name : null
  tags      = var.tags

  user_data = templatefile("${path.module}/keepalived-bootstrap.sh.tftpl", {
    state          = local.nodes[count.index].state
    priority       = local.nodes[count.index].priority
    vip_address    = var.vip_address
    vrrp_interface = var.vrrp_interface
    vrrp_router_id = var.vrrp_router_id
    vrrp_auth_pass = var.vrrp_auth_pass
  })

  # Attach by port (not uuid) so the instance uses the port with the VIP pair.
  network {
    port = openstack_networking_port_v2.node[count.index].id
  }

  lifecycle {
    ignore_changes = [image_id]
  }
}
