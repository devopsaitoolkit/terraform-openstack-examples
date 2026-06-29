# Manage a Cinder volume whose size is driven by a variable. Increasing
# var.volume_size and re-applying grows the volume in place (Cinder supports
# extend, never shrink). Set enable_online_resize so the volume can grow while
# it is still attached to a running instance.
resource "openstack_blockstorage_volume_v3" "volume" {
  name                 = var.volume_name
  description          = var.volume_description
  size                 = var.volume_size
  enable_online_resize = var.enable_online_resize
}
