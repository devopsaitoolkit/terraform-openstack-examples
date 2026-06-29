output "floating_ip_address" {
  description = "The public floating IP address assigned to the instance."
  value       = openstack_networking_floatingip_v2.this.address
}

output "port_id" {
  description = "The UUID of the port the floating IP is associated with."
  value       = openstack_networking_port_v2.this.id
}

output "instance_id" {
  description = "The UUID of the created instance."
  value       = openstack_compute_instance_v2.instance.id
}

output "instance_name" {
  description = "The name of the created instance."
  value       = openstack_compute_instance_v2.instance.name
}
