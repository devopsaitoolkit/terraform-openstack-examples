output "volume_type_id" {
  description = "ID of the encryption-intended volume type."
  value       = openstack_blockstorage_volume_type_v3.encrypted.id
}

output "volume_id" {
  description = "ID of the Cinder volume created from the encrypted type."
  value       = openstack_blockstorage_volume_v3.volume.id
}
