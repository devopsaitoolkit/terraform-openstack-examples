output "user_id" {
  description = "ID of the created identity user."
  value       = openstack_identity_user_v3.this.id
}

output "group_id" {
  description = "ID of the created identity group."
  value       = openstack_identity_group_v3.this.id
}

output "membership" {
  description = "Membership info: which user belongs to which group, and the role granted to the group."
  value = {
    membership_id = openstack_identity_user_membership_v3.this.id
    user_id       = openstack_identity_user_v3.this.id
    group_id      = openstack_identity_group_v3.this.id
    project_id    = var.project_id
    role_name     = var.role_name
    role_id       = data.openstack_identity_role_v3.role.id
  }
}
