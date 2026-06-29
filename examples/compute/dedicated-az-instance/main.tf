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

resource "openstack_compute_instance_v2" "instance" {
  name            = var.instance_name
  flavor_id       = data.openstack_compute_flavor_v2.flavor.id
  image_id        = data.openstack_images_image_v2.image.id
  key_pair        = var.key_pair_name != "" ? var.key_pair_name : null
  security_groups = var.security_group_names
  tags            = var.tags

  # Pin the instance to a specific availability zone. AZs map to host
  # aggregates, letting you place workloads on dedicated/segregated capacity.
  availability_zone = var.availability_zone

  network {
    uuid = data.openstack_networking_network_v2.network.id
  }

  # Scheduler hints give Nova extra placement constraints. Here we optionally
  # build the instance near a specific host (by its management IP). The hint is
  # only emitted when `build_near_host_ip` is set, so by default the scheduler
  # chooses freely within the availability zone above.
  scheduler_hints {
    build_near_host_ip = var.build_near_host_ip != "" ? var.build_near_host_ip : null
  }

  lifecycle {
    # image_id is resolved from a named image; ignore drift so a rebuilt base
    # image elsewhere doesn't force-replace a running instance.
    ignore_changes = [image_id]
  }
}
