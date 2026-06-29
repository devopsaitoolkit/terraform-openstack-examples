locals {
  # Suffix names with a 1-based index only when launching more than one instance,
  # so a single instance keeps the clean name the caller asked for.
  instance_names = [
    for i in range(var.instance_count) :
    var.instance_count > 1 ? format("%s-%d", var.name, i + 1) : var.name
  ]
}

resource "openstack_compute_instance_v2" "this" {
  count = var.instance_count

  name              = local.instance_names[count.index]
  flavor_name       = var.flavor_name
  image_name        = var.image_name
  key_pair          = var.key_pair_name != "" ? var.key_pair_name : null
  security_groups   = var.security_group_names
  availability_zone = var.availability_zone != "" ? var.availability_zone : null
  metadata          = var.metadata
  user_data         = var.user_data != "" ? var.user_data : null
  tags              = var.tags

  network {
    uuid = var.network_id
  }

  lifecycle {
    # image_name resolves to an image_id at create time; ignore drift so a
    # rebuilt base image elsewhere doesn't force-replace a running instance.
    ignore_changes = [image_name]
  }
}
