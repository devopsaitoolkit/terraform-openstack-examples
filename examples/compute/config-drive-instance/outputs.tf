output "instance_id" {
  description = "The UUID of the created instance."
  value       = openstack_compute_instance_v2.instance.id
}

output "access_ip_v4" {
  description = "The first IPv4 address assigned to the instance."
  value       = openstack_compute_instance_v2.instance.access_ip_v4
}

output "config_drive_enabled" {
  description = "Whether the config drive is attached to the instance."
  value       = openstack_compute_instance_v2.instance.config_drive
}
