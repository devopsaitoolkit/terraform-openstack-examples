output "loadbalancer_id" {
  description = "UUID of the load balancer."
  value       = openstack_lb_loadbalancer_v2.lb.id
}

output "vip_address" {
  description = "The VIP that serves both HTTP and HTTPS."
  value       = openstack_lb_loadbalancer_v2.lb.vip_address
}

output "http_listener_id" {
  description = "UUID of the HTTP listener."
  value       = openstack_lb_listener_v2.http.id
}

output "https_listener_id" {
  description = "UUID of the HTTPS listener."
  value       = openstack_lb_listener_v2.https.id
}

output "shared_pool_id" {
  description = "UUID of the pool shared by both listeners."
  value       = openstack_lb_pool_v2.shared.id
}
