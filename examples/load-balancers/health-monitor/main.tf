# Look up the subnet by name; the VIP and members all live on it.
data "openstack_networking_subnet_v2" "subnet" {
  name = var.subnet_name
}

resource "openstack_lb_loadbalancer_v2" "lb" {
  name          = var.lb_name
  description   = "HTTP load balancer focused on health monitoring"
  vip_subnet_id = data.openstack_networking_subnet_v2.subnet.id
}

resource "openstack_lb_listener_v2" "http" {
  name            = "${var.lb_name}-http"
  loadbalancer_id = openstack_lb_loadbalancer_v2.lb.id
  protocol        = "HTTP"
  protocol_port   = var.listener_port
}

resource "openstack_lb_pool_v2" "pool" {
  name        = "${var.lb_name}-pool"
  listener_id = openstack_lb_listener_v2.http.id
  protocol    = "HTTP"
  lb_method   = "ROUND_ROBIN"
}

resource "openstack_lb_member_v2" "member" {
  for_each = toset(var.backend_members)

  name          = "${var.lb_name}-${each.key}"
  pool_id       = openstack_lb_pool_v2.pool.id
  address       = each.value
  protocol_port = var.member_port
  subnet_id     = data.openstack_networking_subnet_v2.subnet.id
  weight        = 1
}

# The HTTP health monitor probes monitor_url_path on every member and compares
# the response code against expected_codes. A member that fails max_retries_down
# probes in a row is pulled from rotation; it returns after max_retries good
# probes. Use a dedicated, cheap health endpoint (not "/") so probes do not load
# the application path or get cached.
resource "openstack_lb_monitor_v2" "monitor" {
  name             = "${var.lb_name}-monitor"
  pool_id          = openstack_lb_pool_v2.pool.id
  type             = "HTTP"
  http_method      = var.monitor_http_method
  url_path         = var.monitor_url_path
  expected_codes   = var.monitor_expected_codes
  delay            = var.monitor_delay
  timeout          = var.monitor_timeout
  max_retries      = var.monitor_max_retries
  max_retries_down = var.monitor_max_retries_down
}
