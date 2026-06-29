output "group_id" {
  description = "The UUID of the created group."
  value       = openstack_identity_group_v3.group.id
}

output "group_name" {
  description = "The name of the created group."
  value       = openstack_identity_group_v3.group.name
}

output "member_user_ids" {
  description = "User UUIDs that are members of the group."
  value       = [for m in openstack_identity_user_membership_v3.members : m.user_id]
}

output "role_assignment_id" {
  description = "The composite ID of the group's role assignment on the project."
  value       = openstack_identity_role_assignment_v3.group_on_project.id
}
