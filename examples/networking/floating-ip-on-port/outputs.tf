output "floating_ip" {
  description = "The allocated floating IP address."
  value       = openstack_networking_floatingip_v2.this.address
}

output "port_id" {
  description = "UUID of the Neutron port the floating IP is associated with."
  value       = openstack_networking_port_v2.vm.id
}

output "floating_ip_id" {
  description = "UUID of the floating IP resource."
  value       = openstack_networking_floatingip_v2.this.id
}
