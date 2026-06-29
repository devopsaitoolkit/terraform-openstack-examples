output "instance_id" {
  description = "The UUID of the monitoring-stack instance."
  value       = openstack_compute_instance_v2.stack.id
}

output "access_ip_v4" {
  description = "The first IPv4 address of the monitoring-stack instance."
  value       = openstack_compute_instance_v2.stack.access_ip_v4
}

output "prometheus_endpoint" {
  description = "Prometheus UI/API endpoint (reachable from monitoring_cidr)."
  value       = "http://${openstack_compute_instance_v2.stack.access_ip_v4}:${var.prometheus_port}"
}

output "grafana_endpoint" {
  description = "Grafana UI endpoint (reachable from grafana_cidr)."
  value       = "http://${openstack_compute_instance_v2.stack.access_ip_v4}:${var.grafana_port}"
}

output "tsdb_volume_id" {
  description = "UUID of the Cinder volume backing the Prometheus TSDB."
  value       = openstack_blockstorage_volume_v3.tsdb.id
}

output "security_group_id" {
  description = "UUID of the security group fronting the stack."
  value       = openstack_networking_secgroup_v2.stack.id
}
