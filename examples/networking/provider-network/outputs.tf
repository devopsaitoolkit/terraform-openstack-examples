output "network_id" {
  description = "UUID of the created provider network."
  value       = openstack_networking_network_v2.this.id
}

output "subnet_id" {
  description = "UUID of the created subnet."
  value       = openstack_networking_subnet_v2.this.id
}
