# Look up the network and image by name so we don't hard-code IDs that differ
# per cloud.
data "openstack_networking_network_v2" "network" {
  name = var.network_name
}

data "openstack_images_image_v2" "image" {
  name        = var.image_name
  most_recent = true
}

# Resolve a flavor by capacity rather than by name. Given min_ram and vcpus, the
# data source returns the smallest matching flavor. Bump var.flavor_vcpus or
# var.flavor_ram and re-apply to trigger a Nova resize (see README).
data "openstack_compute_flavor_v2" "this" {
  vcpus   = var.flavor_vcpus
  min_ram = var.flavor_ram
}

resource "openstack_compute_instance_v2" "instance" {
  name            = var.instance_name
  flavor_id       = data.openstack_compute_flavor_v2.this.id
  image_id        = data.openstack_images_image_v2.image.id
  key_pair        = var.key_pair_name != "" ? var.key_pair_name : null
  security_groups = var.security_group_names
  tags            = var.tags

  network {
    uuid = data.openstack_networking_network_v2.network.id
  }

  lifecycle {
    # image_id is resolved from a named image; ignore drift so a rebuilt base
    # image elsewhere doesn't force-replace a running instance. flavor_id is
    # intentionally NOT ignored so capacity changes drive a resize.
    ignore_changes = [image_id]
  }
}
