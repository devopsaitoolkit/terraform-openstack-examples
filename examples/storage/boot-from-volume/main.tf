# Boot an instance from a new Cinder volume created from a Glance image instead
# of the ephemeral root disk. This gives a persistent, resizable root disk.
data "openstack_networking_network_v2" "network" {
  name = var.network_name
}

data "openstack_images_image_v2" "image" {
  name        = var.image_name
  most_recent = true
}

resource "openstack_compute_instance_v2" "instance" {
  name            = var.instance_name
  flavor_name     = var.flavor_name
  key_pair        = var.key_pair_name != "" ? var.key_pair_name : null
  security_groups = var.security_group_names

  block_device {
    uuid                  = data.openstack_images_image_v2.image.id
    source_type           = "image"
    destination_type      = "volume"
    volume_size           = var.root_volume_size
    boot_index            = 0
    delete_on_termination = var.delete_on_termination
  }

  network {
    uuid = data.openstack_networking_network_v2.network.id
  }
}
