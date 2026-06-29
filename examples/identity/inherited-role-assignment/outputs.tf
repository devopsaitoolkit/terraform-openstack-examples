output "role_id" {
  description = "The UUID of the role being inherited."
  value       = data.openstack_identity_role_v3.role.id
}

output "role_name" {
  description = "The name of the role being inherited."
  value       = data.openstack_identity_role_v3.role.name
}

output "domain_id" {
  description = "The domain whose child projects inherit the role."
  value       = openstack_identity_inherit_role_assignment_v3.domain_inherited.domain_id
}

output "assignment_id" {
  description = "The composite ID of the inherited role assignment."
  value       = openstack_identity_inherit_role_assignment_v3.domain_inherited.id
}
