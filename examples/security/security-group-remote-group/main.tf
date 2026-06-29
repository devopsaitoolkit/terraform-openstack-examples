# Web tier: public HTTPS, admin-only SSH.
resource "openstack_networking_secgroup_v2" "web" {
  name        = var.web_secgroup_name
  description = "Web tier (managed by Terraform)."
  tags        = var.tags
}

# Database tier: no public exposure at all.
resource "openstack_networking_secgroup_v2" "db" {
  name        = var.db_secgroup_name
  description = "Database tier — reachable only from the web tier."
  tags        = var.tags
}

resource "openstack_networking_secgroup_rule_v2" "web_https_in" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 443
  port_range_max    = 443
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.web.id
  description       = "HTTPS from the internet"
}

resource "openstack_networking_secgroup_rule_v2" "web_ssh_in" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = var.admin_ssh_cidr
  security_group_id = openstack_networking_secgroup_v2.web.id
  description       = "SSH from admin CIDR only"
}

# The key rule: the DB accepts its listener port ONLY from members of the web
# security group. remote_group_id references identity, not IP — so it keeps
# working as web instances scale up/down and change addresses.
resource "openstack_networking_secgroup_rule_v2" "db_from_web" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = var.db_port
  port_range_max    = var.db_port
  remote_group_id   = openstack_networking_secgroup_v2.web.id
  security_group_id = openstack_networking_secgroup_v2.db.id
  description       = "PostgreSQL from web tier only (remote_group_id)"
}

resource "openstack_networking_secgroup_rule_v2" "web_egress_v4" {
  direction         = "egress"
  ethertype         = "IPv4"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.web.id
  description       = "Allow all IPv4 egress from web"
}

resource "openstack_networking_secgroup_rule_v2" "db_egress_v4" {
  direction         = "egress"
  ethertype         = "IPv4"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.db.id
  description       = "Allow all IPv4 egress from db"
}
