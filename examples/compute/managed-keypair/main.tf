# Look up the network by name so we don't hard-code IDs that differ per cloud.
data "openstack_networking_network_v2" "network" {
  name = var.network_name
}

# Register the SSH public key as a managed Nova key pair. We only ever hand
# OpenStack the *public* key; the private key stays on your machine.
resource "openstack_compute_keypair_v2" "this" {
  name       = var.keypair_name
  public_key = var.public_key
}

resource "openstack_compute_instance_v2" "instance" {
  name            = var.instance_name
  flavor_name     = var.flavor_name
  image_name      = var.image_name
  key_pair        = openstack_compute_keypair_v2.this.name
  security_groups = var.security_group_names
  tags            = var.tags

  network {
    uuid = data.openstack_networking_network_v2.network.id
  }

  lifecycle {
    # image_name maps to an image_id at create time; ignore drift so a rebuilt
    # base image elsewhere doesn't force-replace a running instance.
    ignore_changes = [image_name]
  }
}
