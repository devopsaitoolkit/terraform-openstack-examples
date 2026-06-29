output "port_a_id" {
  description = "UUID of port A (first NIC)."
  value       = openstack_networking_port_v2.a.id
}

output "port_b_id" {
  description = "UUID of port B (second NIC)."
  value       = openstack_networking_port_v2.b.id
}

output "port_a_ip" {
  description = "First fixed IP assigned to port A."
  value       = openstack_networking_port_v2.a.all_fixed_ips[0]
}

output "port_b_ip" {
  description = "First fixed IP assigned to port B."
  value       = openstack_networking_port_v2.b.all_fixed_ips[0]
}
