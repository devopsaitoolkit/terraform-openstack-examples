output "loadbalancer_id" {
  description = "UUID of the load balancer."
  value       = openstack_lb_loadbalancer_v2.lb.id
}

output "vip_address" {
  description = "The VIP clients connect to."
  value       = openstack_lb_loadbalancer_v2.lb.vip_address
}

output "pool_id" {
  description = "UUID of the backend pool."
  value       = openstack_lb_pool_v2.pool.id
}

output "member_ids" {
  description = "Map of member IP address to member UUID."
  value       = { for ip, m in openstack_lb_member_v2.member : ip => m.id }
}
