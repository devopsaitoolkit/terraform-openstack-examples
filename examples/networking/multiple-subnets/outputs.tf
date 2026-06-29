output "network_id" {
  description = "UUID of the tenant network."
  value       = openstack_networking_network_v2.this.id
}

output "subnet_a_id" {
  description = "UUID of the first subnet."
  value       = openstack_networking_subnet_v2.a.id
}

output "subnet_b_id" {
  description = "UUID of the second subnet."
  value       = openstack_networking_subnet_v2.b.id
}

output "subnet_cidrs" {
  description = "CIDR ranges of the two subnets."
  value       = [openstack_networking_subnet_v2.a.cidr, openstack_networking_subnet_v2.b.cidr]
}
