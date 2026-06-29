# Roles ('member', 'reader', 'admin', ...) are usually pre-created by the cloud
# operator. Look the role up by name instead of hard-coding its UUID, which
# differs per cloud. (The openstack_identity_role_v3 *resource* needs admin and
# is rarely what you want; the *data source* just reads an existing role.)
data "openstack_identity_role_v3" "role" {
  name = var.role_name
}

# Grant <user_id> the <role_name> role, scoped to <project_id>.
# This is the standard "give this user access to this project" assignment.
#
# Requires an admin (or project-admin) token to apply.
resource "openstack_identity_role_assignment_v3" "user_on_project" {
  user_id    = var.user_id
  project_id = var.project_id
  role_id    = data.openstack_identity_role_v3.role.id
}
