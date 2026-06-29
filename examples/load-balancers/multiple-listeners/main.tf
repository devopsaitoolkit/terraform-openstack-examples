# Look up the subnet by name; the VIP and members all live on it.
data "openstack_networking_subnet_v2" "subnet" {
  name = var.subnet_name
}

# A single load balancer can carry several listeners (one per protocol/port).
# Here one LB serves both HTTP:80 and HTTPS:443.
resource "openstack_lb_loadbalancer_v2" "lb" {
  name          = var.lb_name
  description   = "One LB with HTTP and HTTPS listeners sharing a backend pool"
  vip_subnet_id = data.openstack_networking_subnet_v2.subnet.id
}

# Shared backend pool. Because it is attached to the load balancer (not a single
# listener), both listeners can reference it as their default_pool_id. Sharing a
# pool means one set of members and one health monitor serve both ports.
resource "openstack_lb_pool_v2" "shared" {
  name            = "${var.lb_name}-shared"
  loadbalancer_id = openstack_lb_loadbalancer_v2.lb.id
  protocol        = "HTTP"
  lb_method       = "ROUND_ROBIN"
}

# Plain HTTP listener on port 80.
resource "openstack_lb_listener_v2" "http" {
  name            = "${var.lb_name}-http"
  loadbalancer_id = openstack_lb_loadbalancer_v2.lb.id
  protocol        = "HTTP"
  protocol_port   = var.http_port
  default_pool_id = openstack_lb_pool_v2.shared.id
}

# HTTPS listener on port 443, terminating TLS with a Barbican certificate.
resource "openstack_lb_listener_v2" "https" {
  name                      = "${var.lb_name}-https"
  loadbalancer_id           = openstack_lb_loadbalancer_v2.lb.id
  protocol                  = "TERMINATED_HTTPS"
  protocol_port             = var.https_port
  default_pool_id           = openstack_lb_pool_v2.shared.id
  default_tls_container_ref = var.default_tls_container_ref
}

# Members of the shared pool.
resource "openstack_lb_member_v2" "member" {
  for_each = toset(var.backend_members)

  name          = "${var.lb_name}-${each.key}"
  pool_id       = openstack_lb_pool_v2.shared.id
  address       = each.value
  protocol_port = var.member_port
  subnet_id     = data.openstack_networking_subnet_v2.subnet.id
}

# One monitor covers the shared pool (and therefore both listeners).
resource "openstack_lb_monitor_v2" "monitor" {
  name        = "${var.lb_name}-monitor"
  pool_id     = openstack_lb_pool_v2.shared.id
  type        = "HTTP"
  delay       = 5
  timeout     = 3
  max_retries = 3
  url_path    = "/"
}
