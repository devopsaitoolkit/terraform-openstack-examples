output "network_id" {
  description = "UUID of the created network."
  value       = openstack_networking_network_v2.this.id
}

output "subnet_id" {
  description = "UUID of the created subnet."
  value       = openstack_networking_subnet_v2.this.id
}

output "network_name" {
  description = "Name of the created network."
  value       = openstack_networking_network_v2.this.name
}

output "cidr" {
  description = "CIDR block of the created subnet."
  value       = openstack_networking_subnet_v2.this.cidr
}
