# Authoritative PRIMARY zone that holds the recordsets below. Designate (DNS
# service) must be enabled on the target cloud.
resource "openstack_dns_zone_v2" "this" {
  name  = var.zone_name
  email = var.email
  ttl   = var.zone_ttl
  type  = "PRIMARY"
}

# One recordset per entry in var.recordsets. The map key is the FQDN record name
# (must end with a dot) and is used as each.key.
resource "openstack_dns_recordset_v2" "this" {
  for_each = var.recordsets

  zone_id = openstack_dns_zone_v2.this.id
  name    = each.key
  type    = each.value.type
  ttl     = each.value.ttl
  records = each.value.records
}
