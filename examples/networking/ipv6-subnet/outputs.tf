output "network_id" {
  description = "UUID of the dual-stack network."
  value       = openstack_networking_network_v2.dualstack.id
}

output "subnet_v4_id" {
  description = "UUID of the IPv4 subnet."
  value       = openstack_networking_subnet_v2.v4.id
}

output "subnet_v6_id" {
  description = "UUID of the IPv6 subnet."
  value       = openstack_networking_subnet_v2.v6.id
}
