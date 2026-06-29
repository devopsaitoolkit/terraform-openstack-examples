output "floating_ip_id" {
  description = "The UUID of the floating IP."
  value       = openstack_networking_floatingip_v2.fip.id
}

output "floating_ip_address" {
  description = "The floating IP address now mapped to the port."
  value       = openstack_networking_floatingip_v2.fip.address
}

output "associated_port_id" {
  description = "The port the floating IP is associated with."
  value       = openstack_networking_floatingip_associate_v2.fip_assoc.port_id
}
