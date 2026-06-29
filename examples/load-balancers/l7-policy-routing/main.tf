# Look up the subnet by name; the VIP and all members live on it.
data "openstack_networking_subnet_v2" "subnet" {
  name = var.subnet_name
}

resource "openstack_lb_loadbalancer_v2" "lb" {
  name          = var.lb_name
  description   = "HTTP load balancer with L7 path-based routing"
  vip_subnet_id = data.openstack_networking_subnet_v2.subnet.id
}

# Single HTTP listener. Its default_pool_id is the web pool, which serves any
# request that does not match an L7 rule.
resource "openstack_lb_listener_v2" "http" {
  name            = "${var.lb_name}-http"
  loadbalancer_id = openstack_lb_loadbalancer_v2.lb.id
  protocol        = "HTTP"
  protocol_port   = var.listener_port
  default_pool_id = openstack_lb_pool_v2.web.id
}

# Default pool (everything else). Attached to the LB, referenced as the
# listener's default_pool_id above.
resource "openstack_lb_pool_v2" "web" {
  name            = "${var.lb_name}-web"
  loadbalancer_id = openstack_lb_loadbalancer_v2.lb.id
  protocol        = "HTTP"
  lb_method       = "ROUND_ROBIN"
}

# API pool. Only reachable via the L7 policy below.
resource "openstack_lb_pool_v2" "api" {
  name            = "${var.lb_name}-api"
  loadbalancer_id = openstack_lb_loadbalancer_v2.lb.id
  protocol        = "HTTP"
  lb_method       = "ROUND_ROBIN"
}

resource "openstack_lb_member_v2" "web" {
  for_each = toset(var.web_members)

  name          = "${var.lb_name}-web-${each.key}"
  pool_id       = openstack_lb_pool_v2.web.id
  address       = each.value
  protocol_port = var.member_port
  subnet_id     = data.openstack_networking_subnet_v2.subnet.id
}

resource "openstack_lb_member_v2" "api" {
  for_each = toset(var.api_members)

  name          = "${var.lb_name}-api-${each.key}"
  pool_id       = openstack_lb_pool_v2.api.id
  address       = each.value
  protocol_port = var.member_port
  subnet_id     = data.openstack_networking_subnet_v2.subnet.id
}

# L7 policy: requests matching the rule(s) are redirected to the API pool.
# Lower position numbers are evaluated first.
resource "openstack_lb_l7policy_v2" "api_routing" {
  name             = "${var.lb_name}-api-policy"
  listener_id      = openstack_lb_listener_v2.http.id
  action           = "REDIRECT_TO_POOL"
  redirect_pool_id = openstack_lb_pool_v2.api.id
  position         = 1
}

# L7 rule: send requests whose path starts with api_path_prefix (e.g. /api) to
# the policy's target pool. All rules in a policy are ANDed together.
resource "openstack_lb_l7rule_v2" "api_path" {
  l7policy_id  = openstack_lb_l7policy_v2.api_routing.id
  type         = "PATH"
  compare_type = "STARTS_WITH"
  value        = var.api_path_prefix
}

# A health monitor per pool keeps failed members out of rotation.
resource "openstack_lb_monitor_v2" "web" {
  name        = "${var.lb_name}-web-monitor"
  pool_id     = openstack_lb_pool_v2.web.id
  type        = "HTTP"
  delay       = 5
  timeout     = 3
  max_retries = 3
  url_path    = "/"
}

resource "openstack_lb_monitor_v2" "api" {
  name        = "${var.lb_name}-api-monitor"
  pool_id     = openstack_lb_pool_v2.api.id
  type        = "HTTP"
  delay       = 5
  timeout     = 3
  max_retries = 3
  url_path    = var.api_path_prefix
}
