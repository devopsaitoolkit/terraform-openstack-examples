output "loadbalancer_id" {
  description = "UUID of the load balancer."
  value       = openstack_lb_loadbalancer_v2.lb.id
}

output "vip_address" {
  description = "The VIP (virtual IP) clients connect to."
  value       = openstack_lb_loadbalancer_v2.lb.vip_address
}

output "vip_port_id" {
  description = "Neutron port ID of the VIP (attach a floating IP here for public access)."
  value       = openstack_lb_loadbalancer_v2.lb.vip_port_id
}

output "listener_id" {
  description = "UUID of the HTTP listener."
  value       = openstack_lb_listener_v2.http.id
}

output "pool_id" {
  description = "UUID of the backend pool."
  value       = openstack_lb_pool_v2.pool.id
}

output "member_ids" {
  description = "UUIDs of the backend members."
  value       = [openstack_lb_member_v2.member_a.id, openstack_lb_member_v2.member_b.id]
}
