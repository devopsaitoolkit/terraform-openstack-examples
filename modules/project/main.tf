resource "openstack_identity_project_v3" "this" {
  name        = var.name
  description = var.description
  domain_id   = var.domain_id != "" ? var.domain_id : null
  parent_id   = var.parent_id != "" ? var.parent_id : null
  enabled     = var.enabled
  tags        = var.tags
}
