output "loadbalancer_id" {
  description = "UUID of the load balancer."
  value       = openstack_lb_loadbalancer_v2.lb.id
}

output "vip_address" {
  description = "The VIP clients connect to over HTTPS."
  value       = openstack_lb_loadbalancer_v2.lb.vip_address
}

output "vip_port_id" {
  description = "Neutron port ID of the VIP (attach a floating IP here for public HTTPS)."
  value       = openstack_lb_loadbalancer_v2.lb.vip_port_id
}

output "https_listener_id" {
  description = "UUID of the TERMINATED_HTTPS listener."
  value       = openstack_lb_listener_v2.https.id
}

output "pool_id" {
  description = "UUID of the backend pool."
  value       = openstack_lb_pool_v2.pool.id
}
