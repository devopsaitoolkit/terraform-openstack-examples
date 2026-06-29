locals {
  # Suffix names with a 1-based index only when creating more than one volume.
  volume_names = [
    for i in range(var.volume_count) :
    var.volume_count > 1 ? format("%s-%d", var.name, i + 1) : var.name
  ]
}

resource "openstack_blockstorage_volume_v3" "this" {
  count = var.volume_count

  name              = local.volume_names[count.index]
  size              = var.size
  volume_type       = var.volume_type != "" ? var.volume_type : null
  availability_zone = var.availability_zone != "" ? var.availability_zone : null
  metadata          = var.metadata
}

resource "openstack_compute_volume_attach_v2" "this" {
  # Only attach when an instance was supplied; otherwise create bare volumes.
  count = var.attach_to_instance_id != "" ? var.volume_count : 0

  instance_id = var.attach_to_instance_id
  volume_id   = openstack_blockstorage_volume_v3.this[count.index].id
}
