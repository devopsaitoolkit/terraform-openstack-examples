locals {
  # Key members by address:port so reordering the input list does not churn the
  # plan.
  members = {
    for m in var.members : "${m.address}:${m.protocol_port}" => m
  }
}

resource "openstack_lb_loadbalancer_v2" "this" {
  name          = var.name
  vip_subnet_id = var.vip_subnet_id
  tags          = var.tags
}

resource "openstack_lb_listener_v2" "this" {
  name            = "${var.name}-listener"
  loadbalancer_id = openstack_lb_loadbalancer_v2.this.id
  protocol        = var.listener_protocol
  protocol_port   = var.listener_port
}

resource "openstack_lb_pool_v2" "this" {
  name        = "${var.name}-pool"
  listener_id = openstack_lb_listener_v2.this.id
  protocol    = var.listener_protocol
  lb_method   = var.pool_method
}

resource "openstack_lb_member_v2" "this" {
  for_each = local.members

  pool_id       = openstack_lb_pool_v2.this.id
  address       = each.value.address
  protocol_port = each.value.protocol_port
  subnet_id     = each.value.subnet_id
}

resource "openstack_lb_monitor_v2" "this" {
  count = var.monitor != null ? 1 : 0

  pool_id     = openstack_lb_pool_v2.this.id
  type        = var.monitor.type
  delay       = var.monitor.delay
  timeout     = var.monitor.timeout
  max_retries = var.monitor.max_retries
  url_path    = var.monitor.url_path
}
