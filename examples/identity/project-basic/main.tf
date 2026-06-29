# A Keystone project (a.k.a. tenant) is the unit that owns quotas, instances,
# networks and volumes. Domains are NOT managed by Terraform — reference an
# existing domain by ID via `domain_id`.
#
# Requires an admin (or domain-admin) token to apply.
resource "openstack_identity_project_v3" "project" {
  name        = var.project_name
  description = var.project_description
  domain_id   = var.domain_id
  enabled     = var.enabled
  tags        = var.tags
}
