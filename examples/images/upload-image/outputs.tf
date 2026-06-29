output "image_id" {
  description = "The UUID of the created Glance image."
  value       = openstack_images_image_v2.image.id
}

output "image_name" {
  description = "The name of the created image."
  value       = openstack_images_image_v2.image.name
}

output "image_status" {
  description = "The status of the image (e.g. active once the upload completes)."
  value       = openstack_images_image_v2.image.status
}

output "image_size_bytes" {
  description = "The size of the uploaded image in bytes."
  value       = openstack_images_image_v2.image.size_bytes
}

output "image_checksum" {
  description = "The MD5 checksum Glance computed for the image data."
  value       = openstack_images_image_v2.image.checksum
}
