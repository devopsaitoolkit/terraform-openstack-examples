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

# Security group fronting the stack: Prometheus (9090) and Grafana (3000), each
# scoped to its own CIDR, plus egress so the host can fetch packages.
resource "openstack_networking_secgroup_v2" "stack" {
  name        = var.security_group_name
  description = "Monitoring stack (Prometheus + Grafana) ingress (managed by Terraform)."
  tags        = var.tags
}

resource "openstack_networking_secgroup_rule_v2" "prometheus_in" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = var.prometheus_port
  port_range_max    = var.prometheus_port
  remote_ip_prefix  = var.monitoring_cidr
  security_group_id = openstack_networking_secgroup_v2.stack.id
  description       = "Prometheus UI/API from monitoring CIDR"
}

resource "openstack_networking_secgroup_rule_v2" "grafana_in" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = var.grafana_port
  port_range_max    = var.grafana_port
  remote_ip_prefix  = var.grafana_cidr
  security_group_id = openstack_networking_secgroup_v2.stack.id
  description       = "Grafana UI from grafana CIDR"
}

resource "openstack_networking_secgroup_rule_v2" "egress_v4" {
  direction         = "egress"
  ethertype         = "IPv4"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.stack.id
  description       = "Allow all IPv4 egress"
}

# Dedicated Cinder volume for the Prometheus TSDB so metric retention is
# decoupled from the instance's ephemeral root disk and survives a rebuild.
resource "openstack_blockstorage_volume_v3" "tsdb" {
  name        = "${var.instance_name}-tsdb"
  size        = var.tsdb_volume_size
  volume_type = var.tsdb_volume_type != "" ? var.tsdb_volume_type : null
  description = "Prometheus TSDB storage (managed by Terraform)."
}

resource "openstack_compute_instance_v2" "stack" {
  name            = var.instance_name
  flavor_id       = data.openstack_compute_flavor_v2.flavor.id
  image_id        = data.openstack_images_image_v2.image.id
  key_pair        = var.key_pair_name != "" ? var.key_pair_name : null
  security_groups = [openstack_networking_secgroup_v2.stack.name]
  tags            = var.tags

  # Render the bootstrap (volume prep + Prometheus + Grafana) for cloud-init.
  user_data = templatefile("${path.module}/monitoring-stack.sh.tftpl", {
    prometheus_version = var.prometheus_version
    prometheus_port    = var.prometheus_port
    grafana_port       = var.grafana_port
    tsdb_device        = var.tsdb_device
  })

  network {
    uuid = data.openstack_networking_network_v2.network.id
  }

  lifecycle {
    ignore_changes = [image_id]
  }
}

# Attach the TSDB volume. The bootstrap waits for var.tsdb_device, formats it
# once, and mounts it at /var/lib/prometheus.
resource "openstack_compute_volume_attach_v2" "tsdb" {
  instance_id = openstack_compute_instance_v2.stack.id
  volume_id   = openstack_blockstorage_volume_v3.tsdb.id
  device      = var.tsdb_device
}
