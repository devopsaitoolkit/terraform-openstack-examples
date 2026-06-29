output "instance_ids" {
  description = "UUIDs of the created instances."
  value       = openstack_compute_instance_v2.instance[*].id
}

output "instance_ips" {
  description = "First IPv4 address of each instance."
  value       = openstack_compute_instance_v2.instance[*].access_ip_v4
}

output "targets" {
  description = "The ip:port target list written into the Prometheus file_sd file."
  value       = [for instance in openstack_compute_instance_v2.instance : "${instance.access_ip_v4}:${var.metrics_port}"]
}

output "targets_file_path" {
  description = "Local path of the generated Prometheus file_sd targets JSON."
  value       = local_file.prometheus_targets.filename
}
