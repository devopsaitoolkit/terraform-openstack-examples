# Look up the network, image, and flavor by name so we don't hard-code IDs that
# differ per cloud. These resolve once and are shared by every instance.
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

# A fleet of identical instances. In a real setup each would run node_exporter
# (see ../instance-with-node-exporter/); here we focus on turning their IPs into
# a Prometheus service-discovery file.
resource "openstack_compute_instance_v2" "instance" {
  count = var.instance_count

  name            = "${var.name_prefix}-${count.index + 1}"
  flavor_id       = data.openstack_compute_flavor_v2.flavor.id
  image_id        = data.openstack_images_image_v2.image.id
  key_pair        = var.key_pair_name != "" ? var.key_pair_name : null
  security_groups = var.security_group_names
  tags            = var.tags

  network {
    uuid = data.openstack_networking_network_v2.network.id
  }

  lifecycle {
    # image_id is resolved from a named image; ignore drift so a rebuilt base
    # image elsewhere doesn't force-replace running instances.
    ignore_changes = [image_id]
  }
}

# Render the instance IPs into the Prometheus file_sd_config JSON format:
# a list of target groups, each with `targets` and `labels`. Prometheus picks up
# changes to this file automatically (no reload needed) when it is referenced
# from a file_sd_configs block.
resource "local_file" "prometheus_targets" {
  filename = var.targets_file_path
  content = jsonencode([
    {
      targets = [
        for instance in openstack_compute_instance_v2.instance :
        "${instance.access_ip_v4}:${var.metrics_port}"
      ]
      labels = {
        job          = var.job_label
        provisioner  = "terraform"
        cloud        = var.cloud
        network_name = var.network_name
      }
    }
  ])
}
