output "instance_id" {
  description = "The UUID of the created instance."
  value       = openstack_compute_instance_v2.instance.id
}

output "access_ip_v4" {
  description = "The IPv4 address on the access network (the primary NIC)."
  value       = openstack_compute_instance_v2.instance.access_ip_v4
}

output "network_id_primary" {
  description = "The ID of the primary (access) network."
  value       = data.openstack_networking_network_v2.primary.id
}

output "network_id_secondary" {
  description = "The ID of the secondary network."
  value       = data.openstack_networking_network_v2.secondary.id
}
