locals {
  # Unique set of role names to look up (a role may be reused across projects).
  role_names = toset([for ra in var.role_assignments : ra.role_name])

  # Stable, unique keys for the role-assignment resources so plans are
  # deterministic even when the input list is reordered.
  assignments = {
    for ra in var.role_assignments : "${ra.role_name}:${ra.project_id}" => ra
  }
}

resource "openstack_identity_user_v3" "this" {
  name = var.name
  # Convert "unset" sentinels to null so the provider keeps its own defaults.
  password           = var.password != "" ? var.password : null
  default_project_id = var.default_project_id != "" ? var.default_project_id : null
  domain_id          = var.domain_id != "" ? var.domain_id : null
  enabled            = var.enabled
}

# Resolve human-friendly role names to role IDs.
data "openstack_identity_role_v3" "roles" {
  for_each = local.role_names
  name     = each.value
}

resource "openstack_identity_role_assignment_v3" "this" {
  for_each = local.assignments

  user_id    = openstack_identity_user_v3.this.id
  role_id    = data.openstack_identity_role_v3.roles[each.value.role_name].id
  project_id = each.value.project_id
}
