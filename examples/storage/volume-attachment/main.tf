# Create a volume and attach it to an existing Nova instance. The instance is
# referenced by UUID via a variable so this example stays decoupled from how the
# instance was created.
resource "openstack_blockstorage_volume_v3" "volume" {
  name = var.volume_name
  size = var.volume_size
}

resource "openstack_compute_volume_attach_v2" "attached" {
  instance_id = var.instance_id
  volume_id   = openstack_blockstorage_volume_v3.volume.id
  device      = var.device != "" ? var.device : null
}
