# Look up the network, image, and flavor by name so we don't hard-code IDs that
# differ per cloud.
data "openstack_networking_network_v2" "network" {
  name = var.network_name
}

data "openstack_images_image_v2" "image" {
  name        = var.image_name
  most_recent = true
}

data "openstack_compute_flavor_v2" "flavor" {
  name = var.flavor_name
}

# Dedicated security group: only the monitoring CIDR may reach the metrics port.
# node_exporter exposes detailed host metrics, so this must never be world-open.
resource "openstack_networking_secgroup_v2" "metrics" {
  name        = var.security_group_name
  description = "Allows Prometheus to scrape node_exporter (managed by Terraform)."
  tags        = var.tags
}

resource "openstack_networking_secgroup_rule_v2" "metrics_in" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = var.metrics_port
  port_range_max    = var.metrics_port
  remote_ip_prefix  = var.monitoring_cidr
  security_group_id = openstack_networking_secgroup_v2.metrics.id
  description       = "Prometheus scrape of node_exporter from monitoring CIDR"
}

# Explicit egress so the instance can pull the node_exporter release on boot.
resource "openstack_networking_secgroup_rule_v2" "egress_v4" {
  direction         = "egress"
  ethertype         = "IPv4"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.metrics.id
  description       = "Allow all IPv4 egress"
}

resource "openstack_compute_instance_v2" "instance" {
  name            = var.instance_name
  flavor_id       = data.openstack_compute_flavor_v2.flavor.id
  image_id        = data.openstack_images_image_v2.image.id
  key_pair        = var.key_pair_name != "" ? var.key_pair_name : null
  security_groups = [openstack_networking_secgroup_v2.metrics.name]
  tags            = var.tags

  # Render the install script and hand it to Nova as user_data; cloud-init runs
  # it on first boot to bring up node_exporter as a systemd service.
  user_data = templatefile("${path.module}/node-exporter.sh.tftpl", {
    node_exporter_version = var.node_exporter_version
    metrics_port          = var.metrics_port
  })

  network {
    uuid = data.openstack_networking_network_v2.network.id
  }

  lifecycle {
    # image_id is resolved from a named image; ignore drift so a rebuilt base
    # image elsewhere doesn't force-replace a running instance.
    ignore_changes = [image_id]
  }
}
