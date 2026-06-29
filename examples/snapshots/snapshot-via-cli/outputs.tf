output "snapshot_name" {
  description = "Name of the snapshot created via the CLI."
  value       = var.snapshot_name
}

output "note" {
  description = "Reminder that the snapshot is not tracked by Terraform."
  value       = "Snapshot '${var.snapshot_name}' is NOT managed by Terraform state. Delete it manually with: openstack volume snapshot delete ${var.snapshot_name}"
}
