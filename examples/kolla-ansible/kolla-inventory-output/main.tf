# Existing management network the nodes attach to.
data "openstack_networking_network_v2" "management" {
  name = var.network_name
}

resource "openstack_compute_keypair_v2" "kolla" {
  name       = "${var.name_prefix}-key"
  public_key = var.public_key
}

# Control-plane nodes (also serve as the Kolla network + monitoring groups).
resource "openstack_compute_instance_v2" "control" {
  count = var.control_count

  name            = "${var.name_prefix}-control-${count.index}"
  flavor_name     = var.control_flavor
  image_name      = var.image_name
  key_pair        = openstack_compute_keypair_v2.kolla.name
  security_groups = var.security_group_names
  tags            = concat(var.tags, ["kolla:control"])

  network {
    uuid = data.openstack_networking_network_v2.management.id
  }

  lifecycle {
    ignore_changes = [image_name]
  }
}

# Compute nodes.
resource "openstack_compute_instance_v2" "compute" {
  count = var.compute_count

  name            = "${var.name_prefix}-compute-${count.index}"
  flavor_name     = var.compute_flavor
  image_name      = var.image_name
  key_pair        = openstack_compute_keypair_v2.kolla.name
  security_groups = var.security_group_names
  tags            = concat(var.tags, ["kolla:compute"])

  network {
    uuid = data.openstack_networking_network_v2.management.id
  }

  lifecycle {
    ignore_changes = [image_name]
  }
}

# Storage nodes (optional; storage_count defaults to 0).
resource "openstack_compute_instance_v2" "storage" {
  count = var.storage_count

  name            = "${var.name_prefix}-storage-${count.index}"
  flavor_name     = var.storage_flavor
  image_name      = var.image_name
  key_pair        = openstack_compute_keypair_v2.kolla.name
  security_groups = var.security_group_names
  tags            = concat(var.tags, ["kolla:storage"])

  network {
    uuid = data.openstack_networking_network_v2.management.id
  }

  lifecycle {
    ignore_changes = [image_name]
  }
}

# Render a Kolla-Ansible inventory from the created instances. templatefile()
# turns the per-group name/IP lists into the [control]/[network]/[compute]/
# [storage]/[monitoring] sections Kolla expects.
resource "local_file" "inventory" {
  filename        = var.inventory_output_path
  file_permission = "0644"

  content = templatefile("${path.module}/templates/multinode.tpl", {
    ansible_user = var.ansible_user
    control_nodes = [
      for i in openstack_compute_instance_v2.control : {
        name = i.name
        ip   = i.access_ip_v4
      }
    ]
    compute_nodes = [
      for i in openstack_compute_instance_v2.compute : {
        name = i.name
        ip   = i.access_ip_v4
      }
    ]
    storage_nodes = [
      for i in openstack_compute_instance_v2.storage : {
        name = i.name
        ip   = i.access_ip_v4
      }
    ]
  })
}
