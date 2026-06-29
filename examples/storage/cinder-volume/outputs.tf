output "volume_id" {
  description = "UUID of the created Cinder volume."
  value       = openstack_blockstorage_volume_v3.volume.id
}

output "volume_name" {
  description = "Name of the created Cinder volume."
  value       = openstack_blockstorage_volume_v3.volume.name
}

output "volume_size" {
  description = "Size of the created Cinder volume in GiB."
  value       = openstack_blockstorage_volume_v3.volume.size
}
