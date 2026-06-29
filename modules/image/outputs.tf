output "image_id" {
  description = "The UUID of the created Glance image."
  value       = openstack_images_image_v2.this.id
}

output "image_name" {
  description = "The name of the created Glance image."
  value       = openstack_images_image_v2.this.name
}
