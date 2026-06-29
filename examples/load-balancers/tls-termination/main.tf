# Look up the subnet by name; the VIP and members all live on it.
data "openstack_networking_subnet_v2" "subnet" {
  name = var.subnet_name
}

resource "openstack_lb_loadbalancer_v2" "lb" {
  name          = var.lb_name
  description   = "HTTPS load balancer terminating TLS at the listener"
  vip_subnet_id = data.openstack_networking_subnet_v2.subnet.id
}

# HTTPS listener that terminates TLS. Octavia fetches the certificate and key
# from Barbican using default_tls_container_ref, so the cert material never
# touches Terraform state. sni_container_refs lets one listener serve several
# hostnames, each with its own certificate (SNI).
resource "openstack_lb_listener_v2" "https" {
  name                      = "${var.lb_name}-https"
  loadbalancer_id           = openstack_lb_loadbalancer_v2.lb.id
  protocol                  = "TERMINATED_HTTPS"
  protocol_port             = var.https_port
  default_pool_id           = openstack_lb_pool_v2.pool.id
  default_tls_container_ref = var.default_tls_container_ref
  sni_container_refs        = length(var.sni_container_refs) > 0 ? var.sni_container_refs : null
}

# Backend pool speaks plain HTTP: TLS is already terminated at the listener, so
# members do not need their own certificates (re-encryption is a separate,
# advanced setup using a pool tls_container_ref).
resource "openstack_lb_pool_v2" "pool" {
  name            = "${var.lb_name}-pool"
  loadbalancer_id = openstack_lb_loadbalancer_v2.lb.id
  protocol        = "HTTP"
  lb_method       = "ROUND_ROBIN"
}

resource "openstack_lb_member_v2" "member" {
  for_each = toset(var.backend_members)

  name          = "${var.lb_name}-${each.key}"
  pool_id       = openstack_lb_pool_v2.pool.id
  address       = each.value
  protocol_port = var.member_port
  subnet_id     = data.openstack_networking_subnet_v2.subnet.id
}

resource "openstack_lb_monitor_v2" "monitor" {
  name        = "${var.lb_name}-monitor"
  pool_id     = openstack_lb_pool_v2.pool.id
  type        = "HTTP"
  delay       = 5
  timeout     = 3
  max_retries = 3
  url_path    = "/"
}
