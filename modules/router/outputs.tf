output "router_id" {
  description = "The UUID of the created router."
  value       = openstack_networking_router_v2.this.id
}

output "router_name" {
  description = "The name of the created router."
  value       = openstack_networking_router_v2.this.name
}

output "external_gateway" {
  description = "The external network ID used as the router's gateway."
  value       = openstack_networking_router_v2.this.external_network_id
}
