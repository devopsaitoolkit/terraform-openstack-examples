output "server_group_id" {
  description = "UUID of the anti-affinity server group."
  value       = openstack_compute_servergroup_v2.this.id
}

output "instance_ids" {
  description = "UUIDs of the instances spread across hosts."
  value       = openstack_compute_instance_v2.instance[*].id
}

output "instance_names" {
  description = "Names of the instances."
  value       = openstack_compute_instance_v2.instance[*].name
}

output "instance_ips" {
  description = "First IPv4 address of each instance."
  value       = openstack_compute_instance_v2.instance[*].access_ip_v4
}
