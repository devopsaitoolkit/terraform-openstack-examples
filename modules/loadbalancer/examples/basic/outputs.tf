output "loadbalancer_id" {
  description = "UUID of the created load balancer."
  value       = module.loadbalancer.loadbalancer_id
}

output "vip_address" {
  description = "VIP address of the load balancer."
  value       = module.loadbalancer.vip_address
}

output "pool_id" {
  description = "UUID of the load balancer pool."
  value       = module.loadbalancer.pool_id
}
