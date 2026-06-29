output "instance_id" {
  description = "The UUID of the created instance."
  value       = openstack_compute_instance_v2.instance.id
}

output "access_ip_v4" {
  description = "The first IPv4 address assigned to the instance."
  value       = openstack_compute_instance_v2.instance.access_ip_v4
}

output "node_exporter_endpoint" {
  description = "Scrape endpoint to add to your Prometheus targets."
  value       = "${openstack_compute_instance_v2.instance.access_ip_v4}:${var.metrics_port}"
}

output "security_group_id" {
  description = "UUID of the security group opening the metrics port."
  value       = openstack_networking_secgroup_v2.metrics.id
}
