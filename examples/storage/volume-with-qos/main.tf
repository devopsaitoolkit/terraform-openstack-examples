# Define a Cinder QoS spec, associate it with a volume type, and create a volume
# of that type. QoS lets you cap IOPS/throughput per volume. Creating QoS specs
# and associations requires the ADMIN role.
resource "openstack_blockstorage_qos_v3" "qos" {
  name     = var.qos_name
  consumer = var.qos_consumer

  specs = var.qos_specs
}

resource "openstack_blockstorage_volume_type_v3" "type" {
  name        = var.volume_type_name
  description = var.volume_type_description
}

resource "openstack_blockstorage_qos_association_v3" "assoc" {
  qos_id         = openstack_blockstorage_qos_v3.qos.id
  volume_type_id = openstack_blockstorage_volume_type_v3.type.id
}

resource "openstack_blockstorage_volume_v3" "volume" {
  name        = var.volume_name
  size        = var.volume_size
  volume_type = openstack_blockstorage_volume_type_v3.type.name
}
