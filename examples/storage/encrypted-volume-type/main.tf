# Define a volume type intended for encryption and a volume that uses it.
#
# IMPORTANT: the openstack provider's volume type resource cannot itself attach
# the *encryption* parameters (provider, cipher, key size, control location).
# Cinder stores volume-type encryption separately and it must be configured by
# an admin with the CLI:
#
#   openstack volume type set --encryption-provider luks \
#     --encryption-cipher aes-xts-plain64 \
#     --encryption-key-size 256 \
#     --encryption-control-location front-end <type-name>
#
# LUKS encryption keys are generated per-volume and stored in Barbican (Key
# Manager). Data is encrypted on the hypervisor (front-end control location)
# before it ever reaches the storage backend.
resource "openstack_blockstorage_volume_type_v3" "encrypted" {
  name        = var.volume_type_name
  description = var.volume_type_description
  extra_specs = var.extra_specs
}

resource "openstack_blockstorage_volume_v3" "volume" {
  name        = var.volume_name
  size        = var.volume_size
  volume_type = openstack_blockstorage_volume_type_v3.encrypted.name
}
