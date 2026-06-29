output "floating_ip_id" {
  description = "The UUID of the allocated floating IP."
  value       = openstack_networking_floatingip_v2.fip.id
}

output "floating_ip_address" {
  description = "The allocated floating IP address."
  value       = openstack_networking_floatingip_v2.fip.address
}

output "floating_ip_pool" {
  description = "The pool (external network name) the floating IP was allocated from."
  value       = openstack_networking_floatingip_v2.fip.pool
}
