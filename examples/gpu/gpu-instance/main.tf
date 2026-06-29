# Look up the GPU flavor by name. The flavor itself carries the extra_specs that
# tell Nova to attach a GPU (PCI passthrough alias or a VGPU resource request);
# this example consumes such a flavor rather than creating it (see ../gpu-flavor).
data "openstack_compute_flavor_v2" "gpu" {
  name = var.gpu_flavor_name
}

# Resolve the network by name so no cloud-specific UUIDs are hard-coded.
data "openstack_networking_network_v2" "network" {
  name = var.network_name
}

# Boot the instance on the GPU flavor. Whether this yields a full passed-through
# GPU or a time-sliced vGPU is determined entirely by the flavor's extra_specs
# and the host aggregate the scheduler lands on -- not by anything set here.
resource "openstack_compute_instance_v2" "gpu" {
  name              = var.instance_name
  flavor_id         = data.openstack_compute_flavor_v2.gpu.id
  image_name        = var.image_name
  key_pair          = var.key_pair_name != "" ? var.key_pair_name : null
  availability_zone = var.availability_zone != "" ? var.availability_zone : null
  security_groups   = var.security_group_names
  user_data         = var.user_data != "" ? var.user_data : null
  tags              = var.tags

  network {
    uuid = data.openstack_networking_network_v2.network.id
  }

  lifecycle {
    # image_name resolves to an image_id at create time; ignore drift so a
    # rebuilt base image elsewhere doesn't force-replace a running GPU node.
    ignore_changes = [image_name]
  }
}
