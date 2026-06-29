output "qos_id" {
  description = "ID of the Cinder QoS specification."
  value       = openstack_blockstorage_qos_v3.qos.id
}

output "volume_type_id" {
  description = "ID of the volume type associated with the QoS spec."
  value       = openstack_blockstorage_volume_type_v3.type.id
}

output "volume_id" {
  description = "ID of the QoS-limited Cinder volume."
  value       = openstack_blockstorage_volume_v3.volume.id
}
