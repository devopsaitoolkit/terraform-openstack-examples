# A protected image cannot be deleted by Glance while protected = true — the API
# returns 403 on any delete attempt. This guards golden/base images that many
# instances depend on against accidental (or scripted) removal.
#
# To actually delete a protected image you must FIRST flip protected to false,
# apply, and THEN delete:
#   1. set `protected = false` in terraform.tfvars
#   2. terraform apply   (Glance now allows deletion)
#   3. terraform destroy (or remove the resource and apply)
# The CLI equivalent is: openstack image set --unprotected <id> && openstack image delete <id>
resource "openstack_images_image_v2" "image" {
  name             = var.image_name
  image_source_url = var.image_source_url
  disk_format      = var.disk_format
  container_format = var.container_format
  web_download     = var.web_download
  protected        = var.protected
  visibility       = var.visibility
  min_disk_gb      = var.min_disk_gb
  min_ram_mb       = var.min_ram_mb
  tags             = var.tags
}
