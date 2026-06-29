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

# Create an explicit port on the tenant network. Owning the port (rather than
# letting Nova auto-create one) lets us attach the floating IP to a stable
# resource and control the security groups at the network layer.
resource "openstack_networking_port_v2" "this" {
  name               = "${var.instance_name}-port"
  network_id         = data.openstack_networking_network_v2.network.id
  admin_state_up     = true
  security_group_ids = var.security_group_ids
  tags               = var.tags
}

resource "openstack_compute_instance_v2" "instance" {
  name      = var.instance_name
  flavor_id = data.openstack_compute_flavor_v2.flavor.id
  image_id  = data.openstack_images_image_v2.image.id
  key_pair  = var.key_pair_name != "" ? var.key_pair_name : null
  tags      = var.tags

  # Attach via the explicit port. Security groups live on the port, so we do not
  # set security_groups here.
  network {
    port = openstack_networking_port_v2.this.id
  }

  lifecycle {
    # image_id is resolved from a named image; ignore drift so a rebuilt base
    # image elsewhere doesn't force-replace a running instance.
    ignore_changes = [image_id]
  }
}

# Allocate a floating IP from the external network (pool).
resource "openstack_networking_floatingip_v2" "this" {
  pool        = var.floating_ip_pool
  description = "Floating IP for ${var.instance_name}"
  tags        = var.tags
}

# Bind the floating IP to the instance's port. We use the networking associate
# resource (not the deprecated compute one) so the binding is explicit and the
# port is the stable target.
resource "openstack_networking_floatingip_associate_v2" "this" {
  floating_ip = openstack_networking_floatingip_v2.this.address
  port_id     = openstack_networking_port_v2.this.id
}
