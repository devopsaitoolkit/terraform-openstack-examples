# A dedicated security group instead of relying on the shared `default` group.
# One group = one role makes intent reviewable and least privilege auditable.
resource "openstack_networking_secgroup_v2" "web" {
  name        = var.secgroup_name
  description = var.secgroup_description
  tags        = var.tags
}

# SSH (22) only from a scoped admin CIDR. A validation in variables.tf rejects
# 0.0.0.0/0 so management access can never be opened to the whole internet.
resource "openstack_networking_secgroup_rule_v2" "ssh_in" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = var.admin_ssh_cidr
  security_group_id = openstack_networking_secgroup_v2.web.id
  description       = "SSH from admin CIDR only"
}

# HTTPS (443) from the configured CIDR (0.0.0.0/0 for a public service).
resource "openstack_networking_secgroup_rule_v2" "https_in" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 443
  port_range_max    = 443
  remote_ip_prefix  = var.https_cidr
  security_group_id = openstack_networking_secgroup_v2.web.id
  description       = "HTTPS from the internet"
}

# Explicit egress to anywhere. OpenStack adds permissive egress by default, but
# declaring it in code keeps the full policy visible in one place.
resource "openstack_networking_secgroup_rule_v2" "egress_v4" {
  direction         = "egress"
  ethertype         = "IPv4"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.web.id
  description       = "Allow all IPv4 egress"
}
