# The bastion: the only host that exposes SSH to operators, and only from a
# scoped admin CIDR.
resource "openstack_networking_secgroup_v2" "bastion" {
  name        = var.bastion_secgroup_name
  description = "Bastion / jump host — the single SSH entry point."
  tags        = var.tags
}

# The application group: no SSH from the internet at all.
resource "openstack_networking_secgroup_v2" "app" {
  name        = var.app_secgroup_name
  description = "Application tier — SSH only from the bastion group."
  tags        = var.tags
}

# Operators -> bastion SSH, restricted to the admin CIDR.
resource "openstack_networking_secgroup_rule_v2" "bastion_ssh_in" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = var.bastion_admin_cidr
  security_group_id = openstack_networking_secgroup_v2.bastion.id
  description       = "SSH to bastion from admin CIDR"
}

# The jump-host rule: app instances accept SSH ONLY from members of the bastion
# group (identity-based via remote_group_id). No app instance is SSH-reachable
# from anywhere else.
resource "openstack_networking_secgroup_rule_v2" "app_ssh_from_bastion" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_group_id   = openstack_networking_secgroup_v2.bastion.id
  security_group_id = openstack_networking_secgroup_v2.app.id
  description       = "SSH to app from bastion group only"
}

# App listener reachable from other app-group members (e.g. peers / LB in-group).
resource "openstack_networking_secgroup_rule_v2" "app_port_in" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = var.app_port
  port_range_max    = var.app_port
  remote_group_id   = openstack_networking_secgroup_v2.app.id
  security_group_id = openstack_networking_secgroup_v2.app.id
  description       = "App port from within the app group"
}

resource "openstack_networking_secgroup_rule_v2" "bastion_egress_v4" {
  direction         = "egress"
  ethertype         = "IPv4"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.bastion.id
  description       = "Allow all IPv4 egress from bastion"
}

resource "openstack_networking_secgroup_rule_v2" "app_egress_v4" {
  direction         = "egress"
  ethertype         = "IPv4"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.app.id
  description       = "Allow all IPv4 egress from app"
}
