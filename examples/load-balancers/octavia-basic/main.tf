# Look up the subnet by name so we don't hard-code VIP/member IDs that differ
# per cloud. The VIP and the members all live on this subnet.
data "openstack_networking_subnet_v2" "subnet" {
  name = var.subnet_name
}

# The load balancer owns the VIP. Octavia provisions an amphora (or driver
# backend) once this is created; the VIP is allocated from the subnet above.
resource "openstack_lb_loadbalancer_v2" "lb" {
  name          = var.lb_name
  description   = "Basic HTTP load balancer managed by Terraform"
  vip_subnet_id = data.openstack_networking_subnet_v2.subnet.id
}

# A listener terminates the front-end protocol/port (HTTP:80 here).
resource "openstack_lb_listener_v2" "http" {
  name            = "${var.lb_name}-http"
  loadbalancer_id = openstack_lb_loadbalancer_v2.lb.id
  protocol        = "HTTP"
  protocol_port   = var.listener_port
  description     = "HTTP front-end listener"
}

# The pool holds the members and decides how to balance across them.
resource "openstack_lb_pool_v2" "pool" {
  name        = "${var.lb_name}-pool"
  listener_id = openstack_lb_listener_v2.http.id
  protocol    = "HTTP"
  lb_method   = "ROUND_ROBIN"
  description = "Round-robin backend pool"
}

# Two explicit members. Each member is a backend reachable on subnet_name.
resource "openstack_lb_member_v2" "member_a" {
  name          = "${var.lb_name}-member-a"
  pool_id       = openstack_lb_pool_v2.pool.id
  address       = var.member_a_address
  protocol_port = var.member_port
  subnet_id     = data.openstack_networking_subnet_v2.subnet.id
  weight        = 1
}

resource "openstack_lb_member_v2" "member_b" {
  name          = "${var.lb_name}-member-b"
  pool_id       = openstack_lb_pool_v2.pool.id
  address       = var.member_b_address
  protocol_port = var.member_port
  subnet_id     = data.openstack_networking_subnet_v2.subnet.id
  weight        = 1
}

# Health monitor: members that fail the check are pulled out of rotation.
resource "openstack_lb_monitor_v2" "monitor" {
  name        = "${var.lb_name}-monitor"
  pool_id     = openstack_lb_pool_v2.pool.id
  type        = "HTTP"
  delay       = 5
  timeout     = 3
  max_retries = 3
  url_path    = var.monitor_url_path
}
