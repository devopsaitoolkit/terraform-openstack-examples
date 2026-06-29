output "zone_id" {
  description = "Designate identifier (UUID) of the created zone."
  value       = openstack_dns_zone_v2.this.id
}

output "zone_name" {
  description = "Fully qualified name of the created zone."
  value       = openstack_dns_zone_v2.this.name
}

output "zone_type" {
  description = "Type of the zone (PRIMARY or SECONDARY)."
  value       = openstack_dns_zone_v2.this.type
}
