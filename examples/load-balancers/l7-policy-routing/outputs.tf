output "loadbalancer_id" {
  description = "UUID of the load balancer."
  value       = openstack_lb_loadbalancer_v2.lb.id
}

output "vip_address" {
  description = "The VIP clients connect to."
  value       = openstack_lb_loadbalancer_v2.lb.vip_address
}

output "web_pool_id" {
  description = "UUID of the default (web) pool."
  value       = openstack_lb_pool_v2.web.id
}

output "api_pool_id" {
  description = "UUID of the API pool."
  value       = openstack_lb_pool_v2.api.id
}

output "l7policy_id" {
  description = "UUID of the L7 routing policy."
  value       = openstack_lb_l7policy_v2.api_routing.id
}
