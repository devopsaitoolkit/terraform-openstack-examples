output "server_group_id" {
  description = "The UUID of the anti-affinity server group."
  value       = openstack_compute_servergroup_v2.this.id
}

output "instance_ids" {
  description = "The UUIDs of the instances placed in the anti-affinity group."
  value       = openstack_compute_instance_v2.instance[*].id
}

output "instance_names" {
  description = "The names of the instances placed in the anti-affinity group."
  value       = openstack_compute_instance_v2.instance[*].name
}

output "access_ips_v4" {
  description = "The first IPv4 address of each instance."
  value       = openstack_compute_instance_v2.instance[*].access_ip_v4
}
