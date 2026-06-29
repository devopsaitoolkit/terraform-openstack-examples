output "volume_ids" {
  description = "UUIDs of the created volumes."
  value       = module.volume.volume_ids
}

output "attachment_ids" {
  description = "IDs of the volume attachments (empty unless attached)."
  value       = module.volume.attachment_ids
}
