output "router_id" {
  description = "The UUID of the router."
  value       = openstack_networking_router_v2.router.id
}

output "router_name" {
  description = "The name of the router."
  value       = openstack_networking_router_v2.router.name
}

output "routes" {
  description = "Map of route key to its destination CIDR and next hop."
  value = {
    for key, route in openstack_networking_router_route_v2.route :
    key => {
      destination_cidr = route.destination_cidr
      next_hop         = route.next_hop
    }
  }
}
