# Group-based RBAC.
#
# Instead of assigning roles to each user directly, assign roles to a *group*
# and add users to that group. New team members get their access simply by
# joining the group, and revoking access is a single membership removal.

resource "openstack_identity_user_v3" "this" {
  name        = var.user_name
  password    = var.user_password
  enabled     = true
  description = "User managed by Terraform (${var.user_name})."
}

resource "openstack_identity_group_v3" "this" {
  name        = var.group_name
  description = "Group managed by Terraform (${var.group_name})."
}

# Add the user to the group.
resource "openstack_identity_user_membership_v3" "this" {
  user_id  = openstack_identity_user_v3.this.id
  group_id = openstack_identity_group_v3.this.id
}

# Look up the role to grant to the group on the target project.
data "openstack_identity_role_v3" "role" {
  name = var.role_name
}

# Assign the role to the GROUP (not the individual user) on the project.
resource "openstack_identity_role_assignment_v3" "group" {
  group_id   = openstack_identity_group_v3.this.id
  project_id = var.project_id
  role_id    = data.openstack_identity_role_v3.role.id
}
