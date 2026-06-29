output "volume_id" {
  description = "ID of the managed Cinder volume."
  value       = openstack_blockstorage_volume_v3.volume.id
}

output "volume_size" {
  description = "Current size of the volume in GiB."
  value       = openstack_blockstorage_volume_v3.volume.size
}
