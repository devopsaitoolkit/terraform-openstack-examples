output "instance_ids_by_az" {
  description = "Map of availability zone => instance UUID."
  value       = { for az, vm in openstack_compute_instance_v2.instance : az => vm.id }
}

output "access_ips_by_az" {
  description = "Map of availability zone => first IPv4 address."
  value       = { for az, vm in openstack_compute_instance_v2.instance : az => vm.access_ip_v4 }
}

output "network_id" {
  description = "The network the instances are attached to."
  value       = data.openstack_networking_network_v2.network.id
}
