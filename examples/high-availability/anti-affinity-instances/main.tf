# Look up the network, image, and flavor by name so we don't hard-code IDs that
# differ per cloud.
data "openstack_networking_network_v2" "network" {
  name = var.network_name
}

data "openstack_images_image_v2" "image" {
  name        = var.image_name
  most_recent = true
}

data "openstack_compute_flavor_v2" "flavor" {
  name = var.flavor_name
}

# A server group with an anti-affinity policy tells the Nova scheduler to place
# each member on a different hypervisor. With the strict "anti-affinity" policy a
# host failure can take down at most one member; "soft-anti-affinity" is
# best-effort and won't block scheduling when hosts are scarce.
resource "openstack_compute_servergroup_v2" "this" {
  name     = "${var.name_prefix}-group"
  policies = [var.affinity_policy]
}

resource "openstack_compute_instance_v2" "instance" {
  count = var.instance_count

  name            = "${var.name_prefix}-${count.index}"
  flavor_id       = data.openstack_compute_flavor_v2.flavor.id
  image_id        = data.openstack_images_image_v2.image.id
  key_pair        = var.key_pair_name != "" ? var.key_pair_name : null
  security_groups = var.security_group_names
  tags            = var.tags

  network {
    uuid = data.openstack_networking_network_v2.network.id
  }

  # Bind each instance to the server group at scheduling time so the policy is
  # enforced when Nova picks a host.
  scheduler_hints {
    group = openstack_compute_servergroup_v2.this.id
  }

  lifecycle {
    ignore_changes = [image_id]
  }
}
