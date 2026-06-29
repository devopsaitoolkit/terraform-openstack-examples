output "volume_id" {
  description = "ID of the created Cinder volume."
  value       = openstack_blockstorage_volume_v3.volume.id
}

output "image_id" {
  description = "ID of the Glance image used as the volume source."
  value       = data.openstack_images_image_v2.image.id
}

output "volume_size" {
  description = "Size of the created volume in GiB."
  value       = openstack_blockstorage_volume_v3.volume.size
}
