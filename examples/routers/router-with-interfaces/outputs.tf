output "router_id" {
  description = "The UUID of the router."
  value       = openstack_networking_router_v2.router.id
}

output "router_name" {
  description = "The name of the router."
  value       = openstack_networking_router_v2.router.name
}

output "interface_ids" {
  description = "Map of subnet UUID to the router interface UUID created for it."
  value       = { for sid, iface in openstack_networking_router_interface_v2.interface : sid => iface.id }
}

output "attached_subnet_count" {
  description = "Number of subnets attached to the router."
  value       = length(openstack_networking_router_interface_v2.interface)
}
