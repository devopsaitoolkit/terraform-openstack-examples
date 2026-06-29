# Define a Cinder volume type with backend scheduling hints (extra_specs) and a
# volume that uses it. Creating volume types is an ADMIN-only operation.
resource "openstack_blockstorage_volume_type_v3" "type" {
  name        = var.volume_type_name
  description = var.volume_type_description
  is_public   = var.is_public
  extra_specs = var.extra_specs
}

resource "openstack_blockstorage_volume_v3" "volume" {
  name        = var.volume_name
  size        = var.volume_size
  volume_type = openstack_blockstorage_volume_type_v3.type.name
}
