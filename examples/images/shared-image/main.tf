# A 'shared' image is private by default but can be shared with specific projects
# via image memberships. The flow is two-sided:
#   1. The owner creates the image with visibility = "shared" and adds a member
#      for each target project (openstack_images_image_access_v2).
#   2. Each member project ACCEPTS the membership before the image shows up in
#      its image list. A member can also reject it.
resource "openstack_images_image_v2" "image" {
  name             = var.image_name
  image_source_url = var.image_source_url
  disk_format      = var.disk_format
  container_format = var.container_format
  web_download     = var.web_download
  visibility       = "shared"
  min_disk_gb      = var.min_disk_gb
  min_ram_mb       = var.min_ram_mb
  tags             = var.tags
}

# One membership per target project. Setting status here (as the owner) is
# convenient for automation; in a strict workflow the member project accepts it.
resource "openstack_images_image_access_v2" "member" {
  for_each = toset(var.member_project_ids)

  image_id  = openstack_images_image_v2.image.id
  member_id = each.value
  status    = var.member_status
}
