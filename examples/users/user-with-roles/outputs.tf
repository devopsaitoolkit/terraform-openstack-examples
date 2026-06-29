output "user_id" {
  description = "ID of the created identity user."
  value       = openstack_identity_user_v3.this.id
}

output "user_name" {
  description = "Name of the created identity user."
  value       = openstack_identity_user_v3.this.name
}

output "assigned_roles" {
  description = "Map of role name to the role ID assigned on the target project."
  value       = { for name, role in data.openstack_identity_role_v3.roles : name => role.id }
}
