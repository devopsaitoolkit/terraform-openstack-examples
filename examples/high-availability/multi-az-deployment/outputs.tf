output "instance_ids_by_az" {
  description = "Map of availability zone to instance UUID."
  value       = { for az, vm in openstack_compute_instance_v2.instance : az => vm.id }
}

output "instance_ips_by_az" {
  description = "Map of availability zone to instance IPv4 address."
  value       = { for az, vm in openstack_compute_instance_v2.instance : az => vm.access_ip_v4 }
}

output "availability_zones" {
  description = "Availability zones the deployment spans."
  value       = sort(var.availability_zones)
}

output "network_id" {
  description = "The shared network all instances attach to."
  value       = data.openstack_networking_network_v2.network.id
}
