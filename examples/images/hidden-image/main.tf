# A hidden image (hidden = true) is omitted from the default `openstack image
# list` / Horizon image picker, but stays fully bootable by its ID. This is the
# standard way to RETIRE an image: hide it so new users stop picking it, while
# instances and automation that reference it by ID keep working.
#
# Do not confuse hidden with visibility:
#   - hidden     => show/don't show in default listings (any visibility)
#   - visibility => WHO can see the image (private / shared / community / public)
# A "community" image (visibility = community) is visible to all projects only
# when explicitly requested, similar in spirit to hiding but scoped by tenancy.
resource "openstack_images_image_v2" "image" {
  name             = var.image_name
  image_source_url = var.image_source_url
  disk_format      = var.disk_format
  container_format = var.container_format
  web_download     = var.web_download
  hidden           = var.hidden
  visibility       = var.visibility
  min_disk_gb      = var.min_disk_gb
  min_ram_mb       = var.min_ram_mb
  tags             = var.tags
}
