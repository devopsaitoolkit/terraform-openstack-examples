# Groups let you grant a role once and have it apply to every member — the
# recommended way to manage access at scale instead of per-user assignments.
#
# Requires an admin (or domain-admin) token to apply.
resource "openstack_identity_group_v3" "group" {
  name        = var.group_name
  description = var.group_description
  domain_id   = var.domain_id
}

# Add each existing user to the group. for_each (keyed by user id) keeps the
# membership set declarative — adding/removing a user id adds/removes exactly
# one membership without re-creating the others.
resource "openstack_identity_user_membership_v3" "members" {
  for_each = toset(var.member_user_ids)

  group_id = openstack_identity_group_v3.group.id
  user_id  = each.value
}

# Look up the role by name (UUIDs differ per cloud).
data "openstack_identity_role_v3" "role" {
  name = var.role_name
}

# Grant the role to the GROUP on the project. Every current and future member of
# the group inherits this access — no per-user assignment needed.
resource "openstack_identity_role_assignment_v3" "group_on_project" {
  group_id   = openstack_identity_group_v3.group.id
  project_id = var.project_id
  role_id    = data.openstack_identity_role_v3.role.id
}
