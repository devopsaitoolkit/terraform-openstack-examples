resource "openstack_networking_network_v2" "this" {
  name           = var.name
  admin_state_up = true
  tags           = var.tags
}

resource "openstack_networking_subnet_v2" "this" {
  name            = "${var.name}-subnet"
  network_id      = openstack_networking_network_v2.this.id
  cidr            = var.cidr
  ip_version      = var.ip_version
  enable_dhcp     = var.enable_dhcp
  dns_nameservers = var.dns_nameservers
  tags            = var.tags

  dynamic "allocation_pool" {
    for_each = var.allocation_pools
    content {
      start = allocation_pool.value.start
      end   = allocation_pool.value.end
    }
  }
}
