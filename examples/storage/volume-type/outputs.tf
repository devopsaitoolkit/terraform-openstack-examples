output "volume_type_id" {
  description = "ID of the created Cinder volume type."
  value       = openstack_blockstorage_volume_type_v3.type.id
}

output "volume_type_name" {
  description = "Name of the created Cinder volume type."
  value       = openstack_blockstorage_volume_type_v3.type.name
}

output "volume_id" {
  description = "ID of the volume created with this volume type."
  value       = openstack_blockstorage_volume_v3.volume.id
}
