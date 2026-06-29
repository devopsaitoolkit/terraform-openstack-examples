# Look up the network, subnet, image, and flavor by name so we don't hard-code
# IDs that differ per cloud. The subnet is needed both for the LB VIP and to
# address pool members.
data "openstack_networking_network_v2" "network" {
  name = var.network_name
}

data "openstack_networking_subnet_v2" "subnet" {
  name       = var.subnet_name
  network_id = data.openstack_networking_network_v2.network.id
}

data "openstack_images_image_v2" "image" {
  name        = var.image_name
  most_recent = true
}

data "openstack_compute_flavor_v2" "flavor" {
  name = var.flavor_name
}

# Backend web instances. Each runs nginx (installed via cloud-init) and becomes
# a pool member below. count keeps the example simple; for_each would give
# stable keys if you expect to remove individual members later.
resource "openstack_compute_instance_v2" "web" {
  count = var.member_count

  name            = "${var.name_prefix}-${count.index + 1}"
  flavor_id       = data.openstack_compute_flavor_v2.flavor.id
  image_id        = data.openstack_images_image_v2.image.id
  key_pair        = var.key_pair_name != "" ? var.key_pair_name : null
  security_groups = var.security_group_names
  tags            = var.tags

  user_data = templatefile("${path.module}/web-bootstrap.sh.tftpl", {
    name_prefix = var.name_prefix
    member_port = var.member_port
  })

  network {
    uuid = data.openstack_networking_network_v2.network.id
  }

  lifecycle {
    ignore_changes = [image_id]
  }
}

# Octavia load balancer with its VIP on the tenant subnet. This is the single,
# stable entry point clients hit; Octavia itself runs as a managed, often
# active/standby, amphora so the LB is not a single point of failure.
resource "openstack_lb_loadbalancer_v2" "this" {
  name          = "${var.name_prefix}-lb"
  vip_subnet_id = data.openstack_networking_subnet_v2.subnet.id
}

# Listener: the front-end port/protocol clients connect to.
resource "openstack_lb_listener_v2" "http" {
  name            = "${var.name_prefix}-listener"
  loadbalancer_id = openstack_lb_loadbalancer_v2.this.id
  protocol        = "HTTP"
  protocol_port   = var.listener_port
}

# Pool: the set of backends and the algorithm used to balance across them.
resource "openstack_lb_pool_v2" "this" {
  name        = "${var.name_prefix}-pool"
  listener_id = openstack_lb_listener_v2.http.id
  protocol    = "HTTP"
  lb_method   = var.lb_method
}

# Health monitor: Octavia probes each member and pulls unhealthy ones out of
# rotation automatically — the core of the HA behaviour.
resource "openstack_lb_monitor_v2" "this" {
  name        = "${var.name_prefix}-monitor"
  pool_id     = openstack_lb_pool_v2.this.id
  type        = "HTTP"
  url_path    = var.health_monitor_url
  delay       = 5
  timeout     = 3
  max_retries = 3
}

# Register each web instance as a pool member, keyed by index so adding/removing
# a backend doesn't churn the others.
resource "openstack_lb_member_v2" "web" {
  for_each = { for idx, vm in openstack_compute_instance_v2.web : idx => vm }

  name          = "${var.name_prefix}-member-${each.key}"
  pool_id       = openstack_lb_pool_v2.this.id
  address       = each.value.access_ip_v4
  protocol_port = var.member_port
  subnet_id     = data.openstack_networking_subnet_v2.subnet.id
}
