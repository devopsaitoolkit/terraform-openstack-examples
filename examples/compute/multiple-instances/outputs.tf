output "instance_ids" {
  description = "UUIDs of all created instances."
  value       = openstack_compute_instance_v2.instance[*].id
}

output "instance_names" {
  description = "Names of all created instances."
  value       = openstack_compute_instance_v2.instance[*].name
}

output "access_ips" {
  description = "First IPv4 address of each instance, in creation order."
  value       = openstack_compute_instance_v2.instance[*].access_ip_v4
}

output "network_id" {
  description = "The network the instances are attached to."
  value       = data.openstack_networking_network_v2.network.id
}
