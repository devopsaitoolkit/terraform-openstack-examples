# Look up the network, image and flavor by name so we don't hard-code IDs that
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

# Attach a rich metadata map to the instance. Unlike tags (a flat list),
# metadata is structured key/value data exposed through the Nova metadata service
# (http://169.254.169.254/openstack/) and config drive, so guest software and
# config-management tooling can read role, environment, owner, etc. at runtime.
resource "openstack_compute_instance_v2" "instance" {
  name            = var.instance_name
  flavor_id       = data.openstack_compute_flavor_v2.flavor.id
  image_id        = data.openstack_images_image_v2.image.id
  key_pair        = var.key_pair_name != "" ? var.key_pair_name : null
  security_groups = var.security_group_names
  metadata        = var.metadata
  tags            = var.tags

  network {
    uuid = data.openstack_networking_network_v2.network.id
  }

  lifecycle {
    # image_id is resolved from a named image; ignore drift so a rebuilt base
    # image elsewhere doesn't force-replace a running instance.
    ignore_changes = [image_id]
  }
}
