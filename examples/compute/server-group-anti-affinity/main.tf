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

# An anti-affinity server group asks the Nova scheduler to place each member on a
# distinct hypervisor, so a single host failure cannot take down every instance.
resource "openstack_compute_servergroup_v2" "this" {
  name     = "${var.name_prefix}-group"
  policies = ["anti-affinity"]
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

  # Bind each instance to the anti-affinity group at scheduling time.
  scheduler_hints {
    group = openstack_compute_servergroup_v2.this.id
  }

  lifecycle {
    # image_id is resolved from a named image; ignore drift so a rebuilt base
    # image elsewhere doesn't force-replace running instances.
    ignore_changes = [image_id]
  }
}
