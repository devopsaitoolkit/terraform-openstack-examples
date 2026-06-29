# Sets Nova (compute) quotas on an EXISTING project. This is an admin-scoped
# operation: the credentials in clouds.yaml must map to a user with the admin
# role. Terraform does not create the project; it only manages its quota limits.
resource "openstack_compute_quotaset_v2" "this" {
  project_id = var.project_id

  instances      = var.instances
  cores          = var.cores
  ram            = var.ram
  key_pairs      = var.key_pairs
  metadata_items = var.metadata_items
}
