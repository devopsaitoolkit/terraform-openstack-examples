# Upload an image and attach Glance metadata properties. Properties such as
# hw_disk_bus / hw_scsi_model change the virtual hardware Nova builds for guests
# booted from this image, while os_distro / architecture inform scheduling,
# discovery, and tooling.
#
# Note: OpenStack injects several read-only properties of its own (e.g.
# os_hash_algo, owner_specified.*). ignore_changes on those keys prevents
# perpetual diffs without losing control of the properties you manage here.
resource "openstack_images_image_v2" "image" {
  name             = var.image_name
  image_source_url = var.image_source_url
  disk_format      = var.disk_format
  container_format = var.container_format
  web_download     = var.web_download
  min_disk_gb      = var.min_disk_gb
  min_ram_mb       = var.min_ram_mb
  properties       = var.properties
  tags             = var.tags

  lifecycle {
    ignore_changes = [
      properties["os_hash_algo"],
      properties["os_hash_value"],
      properties["stores"],
      properties["direct_url"],
    ]
  }
}
