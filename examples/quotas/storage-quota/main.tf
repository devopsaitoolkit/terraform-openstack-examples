# Sets Cinder (block storage) quotas on an EXISTING project. This is an
# admin-scoped operation: the credentials in clouds.yaml must map to a user with
# the admin role. Terraform does not create the project; it manages its limits.
resource "openstack_blockstorage_quotaset_v3" "this" {
  project_id = var.project_id

  volumes              = var.volumes
  snapshots            = var.snapshots
  gigabytes            = var.gigabytes
  per_volume_gigabytes = var.per_volume_gigabytes
  backups              = var.backups
  backup_gigabytes     = var.backup_gigabytes
}
