output "instance_ids" {
  description = "UUIDs of the created instances, in order."
  value       = openstack_compute_instance_v2.this[*].id
}

output "instance_names" {
  description = "Names of the created instances, in order."
  value       = openstack_compute_instance_v2.this[*].name
}

output "access_ips" {
  description = "First IPv4 address of each instance, in order."
  value       = openstack_compute_instance_v2.this[*].access_ip_v4
}
