# Look up the network, image and flavor by name so we don't hard-code IDs that
# differ per cloud. These data sources resolve once and are shared by every
# instance created with count.
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

# Create N identical instances with count. The index drives a 1-based name
# suffix so the fleet reads as web-1, web-2, web-3.
resource "openstack_compute_instance_v2" "instance" {
  count = var.instance_count

  name            = "${var.instance_name_prefix}-${count.index + 1}"
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
