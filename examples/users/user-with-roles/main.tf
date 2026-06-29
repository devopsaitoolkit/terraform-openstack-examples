# Create an identity user and assign one or more roles on a target project.
# Role IDs are looked up by name so the configuration stays portable across
# clouds that may use different internal role IDs.

resource "openstack_identity_user_v3" "this" {
  name               = var.user_name
  password           = var.user_password
  default_project_id = var.project_id
  enabled            = var.enabled
  description        = "User managed by Terraform (${var.user_name})."
}

# Look up each requested role by name -> role.id
data "openstack_identity_role_v3" "roles" {
  for_each = toset(var.role_names)
  name     = each.value
}

# One role assignment per requested role, scoped to the target project.
resource "openstack_identity_role_assignment_v3" "this" {
  for_each = data.openstack_identity_role_v3.roles

  user_id    = openstack_identity_user_v3.this.id
  project_id = var.project_id
  role_id    = each.value.id
}
