output "image_id" {
  description = "The UUID of the created Glance image. Use this to boot the image even while it is hidden."
  value       = openstack_images_image_v2.image.id
}

output "image_name" {
  description = "The name of the created image."
  value       = openstack_images_image_v2.image.name
}

output "image_hidden" {
  description = "Whether the image is hidden from default listings."
  value       = openstack_images_image_v2.image.hidden
}

output "image_visibility" {
  description = "The visibility scope of the image (who can see it)."
  value       = openstack_images_image_v2.image.visibility
}
