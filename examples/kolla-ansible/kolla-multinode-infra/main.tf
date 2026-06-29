# Existing management network the nodes attach to (e.g. from kolla-network-prereqs).
data "openstack_networking_network_v2" "management" {
  name = var.network_name
}

# Single key pair injected into every node so Ansible can reach them.
resource "openstack_compute_keypair_v2" "kolla" {
  name       = "${var.name_prefix}-key"
  public_key = var.public_key
}

# Spread controllers and computes across hypervisors for resilience.
resource "openstack_compute_servergroup_v2" "controllers" {
  name     = "${var.name_prefix}-controllers"
  policies = [var.server_group_policy]
}

resource "openstack_compute_servergroup_v2" "computes" {
  name     = "${var.name_prefix}-computes"
  policies = [var.server_group_policy]
}

# Security group for intra-cluster + admin SSH access.
resource "openstack_networking_secgroup_v2" "kolla" {
  name        = "${var.name_prefix}-cluster"
  description = "Kolla multinode cluster: SSH in + all traffic between members"
  tags        = var.tags
}

resource "openstack_networking_secgroup_rule_v2" "ssh" {
  security_group_id = openstack_networking_secgroup_v2.kolla.id
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  description       = "SSH for Ansible/admin"
}

resource "openstack_networking_secgroup_rule_v2" "icmp" {
  security_group_id = openstack_networking_secgroup_v2.kolla.id
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  remote_ip_prefix  = "0.0.0.0/0"
  description       = "ICMP for reachability checks"
}

# Allow all traffic between members of this security group (control-plane chatter:
# MariaDB, RabbitMQ, API services, VXLAN, etc.).
resource "openstack_networking_secgroup_rule_v2" "internal" {
  security_group_id = openstack_networking_secgroup_v2.kolla.id
  direction         = "ingress"
  ethertype         = "IPv4"
  remote_group_id   = openstack_networking_secgroup_v2.kolla.id
  description       = "All intra-cluster traffic between members"
}

# Controller nodes.
resource "openstack_compute_instance_v2" "controller" {
  count = var.controller_count

  name            = "${var.name_prefix}-controller-${count.index}"
  flavor_name     = var.controller_flavor
  image_name      = var.image_name
  key_pair        = openstack_compute_keypair_v2.kolla.name
  security_groups = [openstack_networking_secgroup_v2.kolla.name]
  tags            = concat(var.tags, ["kolla:control"])

  network {
    uuid = data.openstack_networking_network_v2.management.id
  }

  scheduler_hints {
    group = openstack_compute_servergroup_v2.controllers.id
  }

  lifecycle {
    ignore_changes = [image_name]
  }
}

# Compute nodes.
resource "openstack_compute_instance_v2" "compute" {
  count = var.compute_count

  name            = "${var.name_prefix}-compute-${count.index}"
  flavor_name     = var.compute_flavor
  image_name      = var.image_name
  key_pair        = openstack_compute_keypair_v2.kolla.name
  security_groups = [openstack_networking_secgroup_v2.kolla.name]
  tags            = concat(var.tags, ["kolla:compute"])

  network {
    uuid = data.openstack_networking_network_v2.management.id
  }

  scheduler_hints {
    group = openstack_compute_servergroup_v2.computes.id
  }

  lifecycle {
    ignore_changes = [image_name]
  }
}
