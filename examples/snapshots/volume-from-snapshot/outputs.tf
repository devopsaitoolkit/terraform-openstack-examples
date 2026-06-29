output "volume_id" {
  description = "UUID of the restored volume."
  value       = openstack_blockstorage_volume_v3.restored.id
}

output "volume_name" {
  description = "Name of the restored volume."
  value       = openstack_blockstorage_volume_v3.restored.name
}

output "source_snapshot_id" {
  description = "UUID of the snapshot the volume was restored from."
  value       = var.snapshot_id
}
