output "router_id" {
  description = "UUID of the created router."
  value       = openstack_networking_router_v2.this.id
}

output "external_network_id" {
  description = "UUID of the external network used as the router gateway."
  value       = data.openstack_networking_network_v2.external.id
}

output "router_interface_id" {
  description = "UUID of the router interface attaching the tenant subnet."
  value       = openstack_networking_router_interface_v2.this.id
}

output "subnet_id" {
  description = "UUID of the tenant subnet attached to the router."
  value       = openstack_networking_subnet_v2.this.id
}
