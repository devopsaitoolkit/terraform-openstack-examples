output "instance_id" {
  description = "UUID of the booted instance."
  value       = openstack_compute_instance_v2.instance.id
}

output "instance_name" {
  description = "Name of the booted instance."
  value       = openstack_compute_instance_v2.instance.name
}

output "access_ip_v4" {
  description = "IPv4 address Terraform uses to reach the instance."
  value       = openstack_compute_instance_v2.instance.access_ip_v4
}
