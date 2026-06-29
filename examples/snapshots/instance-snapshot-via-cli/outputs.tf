output "image_name" {
  description = "Name of the Glance image created from the instance snapshot."
  value       = var.image_name
}

output "note" {
  description = "Reminder that the image is not tracked by Terraform."
  value       = "Image '${var.image_name}' is NOT managed by Terraform state. Delete it manually with: openstack image delete ${var.image_name}"
}
