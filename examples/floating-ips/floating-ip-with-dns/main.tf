# Look up the external network by name and assert it is external.
data "openstack_networking_network_v2" "external" {
  name     = var.external_network_name
  external = true
}

# Allocate a floating IP and ask Designate (the DNS service) to publish an
# A record for it. The dns_name (host) and dns_domain (zone) are passed to
# Neutron at allocation time; Neutron's DNS integration then creates the
# recordset in Designate automatically.
#
# Requirements for this to work:
#   * The cloud runs Designate and Neutron's "dns" extension is enabled.
#   * dns_domain matches an existing Designate zone and ends with a dot.
#   * The external network must permit DNS publishing (dns_domain set or empty).
resource "openstack_networking_floatingip_v2" "fip" {
  pool        = data.openstack_networking_network_v2.external.name
  description = var.description
  dns_name    = var.dns_name
  dns_domain  = var.dns_domain
  tags        = var.tags
}
