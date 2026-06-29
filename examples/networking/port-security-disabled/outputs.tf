output "port_id" {
  description = "UUID of the created port."
  value       = openstack_networking_port_v2.no_security.id
}

output "port_mac_address" {
  description = "MAC address assigned to the port."
  value       = openstack_networking_port_v2.no_security.mac_address
}

output "all_fixed_ips" {
  description = "All fixed IP addresses assigned to the port."
  value       = openstack_networking_port_v2.no_security.all_fixed_ips
}
