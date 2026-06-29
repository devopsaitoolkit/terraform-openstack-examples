output "role_id" {
  description = "The UUID of the role that was looked up and granted."
  value       = data.openstack_identity_role_v3.role.id
}

output "role_name" {
  description = "The name of the role that was granted."
  value       = data.openstack_identity_role_v3.role.name
}

output "assignment_id" {
  description = "The composite ID of the role assignment resource."
  value       = openstack_identity_role_assignment_v3.user_on_project.id
}
