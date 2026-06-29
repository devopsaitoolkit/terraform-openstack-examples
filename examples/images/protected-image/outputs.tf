output "image_id" {
  description = "The UUID of the created Glance image."
  value       = openstack_images_image_v2.image.id
}

output "image_name" {
  description = "The name of the created image."
  value       = openstack_images_image_v2.image.name
}

output "image_protected" {
  description = "Whether the image is delete-protected. Must be false before the image can be deleted."
  value       = openstack_images_image_v2.image.protected
}

output "image_status" {
  description = "The status of the image (active once the upload completes)."
  value       = openstack_images_image_v2.image.status
}
