# A single OpenStack project (Keystone tenant) carrying metadata tags.
#
# NOTE: openstack_identity_project_v3 is ADMIN-SCOPED. The token used by the
# provider must hold a cloud-admin (or at least domain-admin) role, otherwise
# the API returns 403 Forbidden.
resource "openstack_identity_project_v3" "this" {
  name        = var.project_name
  description = var.project_description
  enabled     = var.enabled
  tags        = var.tags

  # Pass null (provider default domain) when no domain_id is supplied.
  domain_id = var.domain_id != "" ? var.domain_id : null
}
