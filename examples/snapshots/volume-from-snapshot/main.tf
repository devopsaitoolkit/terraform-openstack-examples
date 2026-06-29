# Create a NEW Cinder volume from an existing volume snapshot. The snapshot is
# referenced by ID (snapshots have no native Terraform resource — create them
# with the CLI or the snapshot-via-cli example, then restore here). The new
# volume size must be >= the snapshot size; omit size to inherit it.
resource "openstack_blockstorage_volume_v3" "restored" {
  name        = var.volume_name
  description = var.volume_description
  size        = var.volume_size
  snapshot_id = var.snapshot_id
}
