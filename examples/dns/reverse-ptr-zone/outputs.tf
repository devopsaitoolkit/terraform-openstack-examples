output "zone_id" {
  description = "Designate identifier (UUID) of the reverse DNS zone."
  value       = openstack_dns_zone_v2.this.id
}

output "ptr_recordset_id" {
  description = "Designate identifier (UUID) of the PTR recordset."
  value       = openstack_dns_recordset_v2.ptr.id
}
