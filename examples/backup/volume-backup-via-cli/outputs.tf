output "backup_name" {
  description = "Name of the backup created via the CLI."
  value       = var.backup_name
}

output "note" {
  description = "Reminder that the backup is not tracked by Terraform."
  value       = "Backup '${var.backup_name}' is NOT managed by Terraform state. Delete it with: openstack volume backup delete ${var.backup_name}. Restore with: openstack volume backup restore ${var.backup_name} <target-volume>"
}
