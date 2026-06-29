output "region1_network_id" {
  description = "UUID of the network created in region 1."
  value       = openstack_networking_network_v2.region1.id
}

output "region1_network_name" {
  description = "Name of the network created in region 1."
  value       = openstack_networking_network_v2.region1.name
}

output "region2_network_id" {
  description = "UUID of the network created in region 2."
  value       = openstack_networking_network_v2.region2.id
}

output "region2_network_name" {
  description = "Name of the network created in region 2."
  value       = openstack_networking_network_v2.region2.name
}
