# Upload a cloud image into Glance from a remote URL. With web_download = true
# the OpenStack image service pulls the bytes directly (fast, no local round
# trip); otherwise Terraform downloads the file and streams it to Glance.
resource "openstack_images_image_v2" "image" {
  name             = var.image_name
  image_source_url = var.image_source_url
  disk_format      = var.disk_format
  container_format = var.container_format
  min_disk_gb      = var.min_disk_gb
  min_ram_mb       = var.min_ram_mb
  visibility       = var.visibility
  web_download     = var.web_download
  tags             = var.tags
}
