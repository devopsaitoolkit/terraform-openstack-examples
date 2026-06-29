# Look up the network and image by name so we don't hard-code IDs that differ
# per cloud. The image id seeds the bootable root volume below.
data "openstack_networking_network_v2" "network" {
  name = var.network_name
}

data "openstack_images_image_v2" "image" {
  name        = var.image_name
  most_recent = true
}

# Boot from a Cinder volume instead of the ephemeral local disk. Nova creates a
# new volume from the image (source_type = "image", destination_type = "volume")
# and attaches it as the boot disk. Note: we deliberately do NOT set image_name
# on the instance itself — the boot disk is defined entirely by this block.
resource "openstack_compute_instance_v2" "instance" {
  name            = var.instance_name
  flavor_name     = var.flavor_name
  key_pair        = var.key_pair_name != "" ? var.key_pair_name : null
  security_groups = var.security_group_names
  tags            = var.tags

  block_device {
    uuid                  = data.openstack_images_image_v2.image.id
    source_type           = "image"
    destination_type      = "volume"
    boot_index            = 0
    delete_on_termination = true
    volume_size           = var.volume_size
    volume_type           = var.volume_type != "" ? var.volume_type : null
  }

  network {
    uuid = data.openstack_networking_network_v2.network.id
  }
}
