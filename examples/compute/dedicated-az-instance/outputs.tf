output "instance_id" {
  description = "The UUID of the created instance."
  value       = openstack_compute_instance_v2.instance.id
}

output "instance_availability_zone" {
  description = "The availability zone the instance was placed in."
  value       = openstack_compute_instance_v2.instance.availability_zone
}

output "instance_name" {
  description = "The name of the created instance."
  value       = openstack_compute_instance_v2.instance.name
}

output "access_ip_v4" {
  description = "The first IPv4 address assigned to the instance."
  value       = openstack_compute_instance_v2.instance.access_ip_v4
}
