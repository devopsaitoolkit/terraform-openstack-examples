# Create a standalone Cinder block storage volume. Look up nothing external —
# this is the base building block other storage examples reference.
resource "openstack_blockstorage_volume_v3" "volume" {
  name        = var.volume_name
  description = var.volume_description
  size        = var.volume_size
  volume_type = var.volume_type != "" ? var.volume_type : null
  metadata    = var.metadata
}
