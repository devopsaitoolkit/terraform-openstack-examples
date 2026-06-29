output "security_group_id" {
  description = "UUID of the created security group."
  value       = openstack_networking_secgroup_v2.web.id
}

output "security_group_name" {
  description = "Name of the created security group."
  value       = openstack_networking_secgroup_v2.web.name
}
