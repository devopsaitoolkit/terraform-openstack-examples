# A least-privilege security group for a typical web server: SSH from a trusted
# admin range, HTTP/HTTPS from the allowed range, and explicit egress.
resource "openstack_networking_secgroup_v2" "web" {
  name        = var.secgroup_name
  description = "Least-privilege web server group (SSH from admin, HTTP/HTTPS from clients)"
  tags        = ["managed-by:terraform", "example:security-group"]
}

# Ingress SSH (tcp/22) from the trusted admin CIDR only.
resource "openstack_networking_secgroup_rule_v2" "ssh_in" {
  description       = "SSH from admin network"
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = var.ssh_cidr
  security_group_id = openstack_networking_secgroup_v2.web.id
}

# Ingress HTTPS (tcp/443) from the allowed client CIDR.
resource "openstack_networking_secgroup_rule_v2" "https_in" {
  description       = "HTTPS from clients"
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 443
  port_range_max    = 443
  remote_ip_prefix  = var.allowed_cidr
  security_group_id = openstack_networking_secgroup_v2.web.id
}

# Ingress HTTP (tcp/80) from the allowed client CIDR.
resource "openstack_networking_secgroup_rule_v2" "http_in" {
  description       = "HTTP from clients"
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 80
  port_range_max    = 80
  remote_ip_prefix  = var.allowed_cidr
  security_group_id = openstack_networking_secgroup_v2.web.id
}

# Egress all IPv4. Defining egress explicitly documents intent; omit protocol and
# port range to allow every protocol/port outbound.
resource "openstack_networking_secgroup_rule_v2" "egress_all" {
  description       = "Allow all outbound IPv4 traffic"
  direction         = "egress"
  ethertype         = "IPv4"
  security_group_id = openstack_networking_secgroup_v2.web.id
}
