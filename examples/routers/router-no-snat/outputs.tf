output "router_id" {
  description = "The UUID of the router."
  value       = openstack_networking_router_v2.router.id
}

output "router_name" {
  description = "The name of the router."
  value       = openstack_networking_router_v2.router.name
}

output "external_network_id" {
  description = "The external/provider network used as the router's gateway."
  value       = data.openstack_networking_network_v2.external.id
}

output "enable_snat" {
  description = "Whether source NAT is enabled on the gateway (false in this example)."
  value       = openstack_networking_router_v2.router.enable_snat
}
