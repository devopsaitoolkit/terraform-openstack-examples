# A two-level project hierarchy: a parent project and a child project nested
# under it via parent_id. Nested projects model organisational units (e.g. a
# business unit owning several team projects).
#
# NOTE: openstack_identity_project_v3 is ADMIN-SCOPED. The provider token must
# hold a cloud-admin (or domain-admin) role to create either project.
resource "openstack_identity_project_v3" "parent" {
  name        = var.parent_name
  description = var.description

  # Pass null (provider default domain) when no domain_id is supplied.
  domain_id = var.domain_id != "" ? var.domain_id : null
}

resource "openstack_identity_project_v3" "child" {
  name        = var.child_name
  description = var.description

  # The child is nested under the parent. It inherits the parent's domain, so
  # domain_id is intentionally not set here.
  parent_id = openstack_identity_project_v3.parent.id
}
