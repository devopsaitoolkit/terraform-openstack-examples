# Look up the network, image, and flavor by name so we don't hard-code IDs that
# differ per cloud. A single shared network spans all availability zones.
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

# One instance per availability zone, keyed by AZ name with for_each. Keying on
# the zone (not a count index) means adding or removing a zone never renumbers or
# replaces the instances in the other zones. Spreading across AZs protects the
# app from a zone-level failure (power, network, hardware domain).
resource "openstack_compute_instance_v2" "instance" {
  for_each = toset(var.availability_zones)

  name              = "${var.instance_name_prefix}-${each.value}"
  availability_zone = each.value
  flavor_id         = data.openstack_compute_flavor_v2.flavor.id
  image_id          = data.openstack_images_image_v2.image.id
  key_pair          = var.key_pair_name != "" ? var.key_pair_name : null
  security_groups   = var.security_group_names
  tags              = concat(var.tags, ["az:${each.value}"])

  # All zones attach to the same tenant network so the instances can talk to one
  # another and sit behind a single load balancer or VIP.
  network {
    uuid = data.openstack_networking_network_v2.network.id
  }

  lifecycle {
    ignore_changes = [image_id]
  }
}
