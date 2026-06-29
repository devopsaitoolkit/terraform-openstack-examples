# Multiattach lets one volume attach to several instances at once. The provider
# has no `multiattach` flag on the volume itself: capability is granted by the
# volume TYPE (extra_specs "multiattach" = "<is> True"), then each attachment
# opts in with multiattach = true. A cluster-aware filesystem (e.g. GFS2/OCFS2)
# is required on top — multiattach does NOT make a plain ext4/xfs volume safe to
# mount read-write on two nodes.
resource "openstack_blockstorage_volume_type_v3" "multiattach" {
  name = var.volume_type_name

  extra_specs = {
    "multiattach" = "<is> True"
  }
}

resource "openstack_blockstorage_volume_v3" "volume" {
  name        = var.volume_name
  size        = var.volume_size
  volume_type = openstack_blockstorage_volume_type_v3.multiattach.name
}

resource "openstack_compute_volume_attach_v2" "first" {
  instance_id = var.first_instance_id
  volume_id   = openstack_blockstorage_volume_v3.volume.id
  multiattach = true
}

resource "openstack_compute_volume_attach_v2" "second" {
  instance_id = var.second_instance_id
  volume_id   = openstack_blockstorage_volume_v3.volume.id
  multiattach = true
}
