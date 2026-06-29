# Create a bootable Cinder volume pre-populated from a Glance image. Looking the
# image up by name keeps the config portable across clouds.
data "openstack_images_image_v2" "image" {
  name        = var.image_name
  most_recent = true
}

resource "openstack_blockstorage_volume_v3" "volume" {
  name     = var.volume_name
  size     = var.volume_size
  image_id = data.openstack_images_image_v2.image.id
}
