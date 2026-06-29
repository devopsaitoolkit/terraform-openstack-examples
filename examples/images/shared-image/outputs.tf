output "image_id" {
  description = "The UUID of the created Glance image."
  value       = openstack_images_image_v2.image.id
}

output "image_name" {
  description = "The name of the created image."
  value       = openstack_images_image_v2.image.name
}

output "image_visibility" {
  description = "The visibility of the image (shared)."
  value       = openstack_images_image_v2.image.visibility
}

output "member_ids" {
  description = "Project (member) UUIDs the image has been shared with."
  value       = [for m in openstack_images_image_access_v2.member : m.member_id]
}

output "member_statuses" {
  description = "Map of member project UUID to its membership status (pending/accepted/rejected)."
  value       = { for k, m in openstack_images_image_access_v2.member : k => m.status }
}
