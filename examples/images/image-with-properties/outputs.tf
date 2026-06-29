output "image_id" {
  description = "The UUID of the created Glance image."
  value       = openstack_images_image_v2.image.id
}

output "image_name" {
  description = "The name of the created image."
  value       = openstack_images_image_v2.image.name
}

output "image_properties" {
  description = "The effective metadata properties on the image (includes Glance-injected keys)."
  value       = openstack_images_image_v2.image.properties
}

output "image_status" {
  description = "The status of the image (active once the upload completes)."
  value       = openstack_images_image_v2.image.status
}
