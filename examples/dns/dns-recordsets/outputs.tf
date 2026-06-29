output "zone_id" {
  description = "Designate identifier (UUID) of the zone holding the recordsets."
  value       = openstack_dns_zone_v2.this.id
}

output "recordset_ids" {
  description = "Map of recordset name to its Designate identifier."
  value       = { for name, rs in openstack_dns_recordset_v2.this : name => rs.id }
}

output "recordset_names" {
  description = "List of fully qualified recordset names that were created."
  value       = keys(openstack_dns_recordset_v2.this)
}
