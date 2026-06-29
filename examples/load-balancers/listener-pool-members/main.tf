# Look up the subnet by name; the VIP and every member live on it.
data "openstack_networking_subnet_v2" "subnet" {
  name = var.subnet_name
}

resource "openstack_lb_loadbalancer_v2" "lb" {
  name          = var.lb_name
  description   = "HTTP load balancer with for_each members"
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

# One member per IP in var.backend_members. Using for_each (over a set) keys each
# member by its address, so editing the list adds/removes only the affected
# member instead of re-indexing every member the way `count` would.
resource "openstack_lb_member_v2" "member" {
  for_each = toset(var.backend_members)

  name          = "${var.lb_name}-${each.key}"
  pool_id       = openstack_lb_pool_v2.pool.id
  address       = each.value
  protocol_port = var.member_port
  subnet_id     = data.openstack_networking_subnet_v2.subnet.id
  weight        = 1
}

# A health monitor keeps failed members out of rotation.
resource "openstack_lb_monitor_v2" "monitor" {
  name        = "${var.lb_name}-monitor"
  pool_id     = openstack_lb_pool_v2.pool.id
  type        = "HTTP"
  delay       = 5
  timeout     = 3
  max_retries = 3
  url_path    = "/"
}
