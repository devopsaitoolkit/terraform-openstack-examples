output "loadbalancer_id" {
  description = "UUID of the Octavia load balancer."
  value       = openstack_lb_loadbalancer_v2.this.id
}

output "vip_address" {
  description = "Virtual IP clients connect to (the stable web-tier entry point)."
  value       = openstack_lb_loadbalancer_v2.this.vip_address
}

output "vip_endpoint" {
  description = "Convenience URL for the load-balanced web tier."
  value       = "http://${openstack_lb_loadbalancer_v2.this.vip_address}:${var.listener_port}"
}

output "pool_id" {
  description = "UUID of the load balancer pool."
  value       = openstack_lb_pool_v2.this.id
}

output "member_ids" {
  description = "UUIDs of the registered pool members."
  value       = [for m in openstack_lb_member_v2.web : m.id]
}

output "instance_ips" {
  description = "Backend instance IPs behind the load balancer."
  value       = openstack_compute_instance_v2.web[*].access_ip_v4
}
