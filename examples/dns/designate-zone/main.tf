# A PRIMARY zone is authoritative DNS data hosted by Designate. Requires the
# Designate (DNS) service to be enabled and available on the target cloud.
resource "openstack_dns_zone_v2" "this" {
  name        = var.zone_name
  email       = var.email
  description = var.description
  ttl         = var.ttl
  type        = "PRIMARY"
}
