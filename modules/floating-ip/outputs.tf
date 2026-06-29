output "floating_ip_addresses" {
  description = "The allocated floating IP addresses, in order."
  value       = openstack_networking_floatingip_v2.this[*].address
}

output "floating_ip_ids" {
  description = "The UUIDs of the allocated floating IPs, in order."
  value       = openstack_networking_floatingip_v2.this[*].id
}
