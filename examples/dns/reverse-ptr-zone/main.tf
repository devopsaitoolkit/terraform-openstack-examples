# Reverse DNS zone. Names under in-addr.arpa map IP addresses back to hostnames.
# This is a normal PRIMARY zone whose name happens to be in in-addr.arpa form.
# Designate (DNS service) must be enabled on the target cloud.
resource "openstack_dns_zone_v2" "this" {
  name  = var.reverse_zone_name
  email = var.email
  ttl   = var.zone_ttl
  type  = "PRIMARY"
}

# A PTR recordset maps the reversed IP (ptr_name) to one or more hostnames.
resource "openstack_dns_recordset_v2" "ptr" {
  zone_id = openstack_dns_zone_v2.this.id
  name    = var.ptr_name
  type    = "PTR"
  ttl     = var.ptr_ttl
  records = var.ptr_records
}
