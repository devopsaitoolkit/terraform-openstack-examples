output "secgroup_id" {
  description = "UUID of the stateful security group."
  value       = openstack_networking_secgroup_v2.stateful.id
}

output "secgroup_name" {
  description = "Name of the security group."
  value       = openstack_networking_secgroup_v2.stateful.name
}

output "stateful" {
  description = "Whether the security group is stateful (true) — replies auto-allowed."
  value       = openstack_networking_secgroup_v2.stateful.stateful
}
