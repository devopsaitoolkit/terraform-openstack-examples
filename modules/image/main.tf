resource "openstack_images_image_v2" "this" {
  name             = var.name
  image_source_url = var.image_source_url
  container_format = var.container_format
  disk_format      = var.disk_format
  visibility       = var.visibility
  protected        = var.protected
  min_disk_gb      = var.min_disk_gb
  min_ram_mb       = var.min_ram_mb
  properties       = var.properties
  tags             = var.tags
}
