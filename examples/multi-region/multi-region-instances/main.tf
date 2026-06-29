# Look up the target network in each region by name. Each data source runs
# through its own provider, so the same network name resolves to the correct
# per-region UUID without hard-coding IDs.
data "openstack_networking_network_v2" "region1" {
  name = var.network_name
}

data "openstack_networking_network_v2" "region2" {
  provider = openstack.region2
  name     = var.network_name
}

# Instance in region 1 (default provider).
resource "openstack_compute_instance_v2" "region1" {
  name            = "${var.instance_name}-region1"
  flavor_name     = var.flavor_name
  image_name      = var.image_name
  key_pair        = var.key_pair_name != "" ? var.key_pair_name : null
  security_groups = var.security_group_names
  tags            = var.tags

  network {
    uuid = data.openstack_networking_network_v2.region1.id
  }

  lifecycle {
    ignore_changes = [image_name]
  }
}

# Instance in region 2 (aliased provider). Identical except provider + network.
resource "openstack_compute_instance_v2" "region2" {
  provider = openstack.region2

  name            = "${var.instance_name}-region2"
  flavor_name     = var.flavor_name
  image_name      = var.image_name
  key_pair        = var.key_pair_name != "" ? var.key_pair_name : null
  security_groups = var.security_group_names
  tags            = var.tags

  network {
    uuid = data.openstack_networking_network_v2.region2.id
  }

  lifecycle {
    ignore_changes = [image_name]
  }
}
