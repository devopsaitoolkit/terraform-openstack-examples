# Bulk-bootstrap many Keystone projects from a single map variable using
# for_each. The map key becomes the project name, which keeps Terraform's
# resource addresses stable when you add or remove entries.
#
# NOTE: openstack_identity_project_v3 is ADMIN-SCOPED. The provider token must
# hold a cloud-admin (or domain-admin) role to create these projects.
resource "openstack_identity_project_v3" "this" {
  for_each = var.projects

  name        = each.key
  description = each.value.description
  enabled     = each.value.enabled
  tags        = each.value.tags

  # Pass null (provider default domain) when no domain_id is supplied.
  domain_id = var.domain_id != "" ? var.domain_id : null
}
