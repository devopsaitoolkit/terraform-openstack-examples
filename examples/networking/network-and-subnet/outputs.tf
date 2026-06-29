output "network_id" {
  description = "UUID of the created network."
  value       = openstack_networking_network_v2.this.id
}

output "subnet_id" {
  description = "UUID of the created subnet."
  value       = openstack_networking_subnet_v2.this.id
}

output "subnet_cidr" {
  description = "CIDR range assigned to the subnet."
  value       = openstack_networking_subnet_v2.this.cidr
}
