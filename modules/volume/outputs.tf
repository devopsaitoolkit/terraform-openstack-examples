output "volume_ids" {
  description = "UUIDs of the created volumes, in order."
  value       = openstack_blockstorage_volume_v3.this[*].id
}

output "attachment_ids" {
  description = "IDs of the volume attachments, in order. Empty when attach_to_instance_id is not set."
  value       = openstack_compute_volume_attach_v2.this[*].id
}
