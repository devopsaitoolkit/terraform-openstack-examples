output "instance_id" {
  description = "The UUID of the created instance."
  value       = openstack_compute_instance_v2.instance.id
}

output "instance_name" {
  description = "The name of the created instance."
  value       = openstack_compute_instance_v2.instance.name
}

output "access_ip_v4" {
  description = "The first IPv4 address assigned to the instance."
  value       = openstack_compute_instance_v2.instance.access_ip_v4
}

output "volume_size" {
  description = "Size of the bootable root volume, in GB."
  value       = var.volume_size
}

output "network_id" {
  description = "The network the instance is attached to."
  value       = data.openstack_networking_network_v2.network.id
}
