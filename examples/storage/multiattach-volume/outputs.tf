output "volume_id" {
  description = "ID of the shared multiattach volume."
  value       = openstack_blockstorage_volume_v3.volume.id
}

output "first_attachment_id" {
  description = "ID of the attachment to the first instance."
  value       = openstack_compute_volume_attach_v2.first.id
}

output "second_attachment_id" {
  description = "ID of the attachment to the second instance."
  value       = openstack_compute_volume_attach_v2.second.id
}
