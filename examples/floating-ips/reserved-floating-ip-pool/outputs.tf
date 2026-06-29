output "floating_ip_addresses" {
  description = "Map of reservation name to allocated floating IP address."
  value       = { for name, fip in openstack_networking_floatingip_v2.reserved : name => fip.address }
}

output "floating_ip_ids" {
  description = "Map of reservation name to floating IP UUID."
  value       = { for name, fip in openstack_networking_floatingip_v2.reserved : name => fip.id }
}

output "reserved_count" {
  description = "Number of floating IPs reserved."
  value       = length(openstack_networking_floatingip_v2.reserved)
}
