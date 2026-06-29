output "loadbalancer_id" {
  description = "The UUID of the created load balancer."
  value       = openstack_lb_loadbalancer_v2.this.id
}

output "vip_address" {
  description = "The VIP address of the load balancer."
  value       = openstack_lb_loadbalancer_v2.this.vip_address
}

output "pool_id" {
  description = "The UUID of the load balancer pool."
  value       = openstack_lb_pool_v2.this.id
}
