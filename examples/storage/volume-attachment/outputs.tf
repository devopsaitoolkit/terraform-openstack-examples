output "volume_id" {
  description = "UUID of the created Cinder volume."
  value       = openstack_blockstorage_volume_v3.volume.id
}

output "attachment_id" {
  description = "ID of the volume attachment resource."
  value       = openstack_compute_volume_attach_v2.attached.id
}

output "device" {
  description = "Device path the volume was attached as (as reported by Nova)."
  value       = openstack_compute_volume_attach_v2.attached.device
}
