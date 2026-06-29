output "instance_id" {
  description = "The UUID of the created instance."
  value       = openstack_compute_instance_v2.instance.id
}

output "instance_name" {
  description = "The name of the created instance."
  value       = openstack_compute_instance_v2.instance.name
}

output "access_ip_v4" {
  description = "The first IPv4 address assigned to the instance."
  value       = openstack_compute_instance_v2.instance.access_ip_v4
}

output "rendered_cloud_config" {
  description = "The #cloud-config rendered from the template (useful for review)."
  value = templatefile("${path.module}/cloud-init.yaml.tftpl", {
    ssh_authorized_key = var.ssh_authorized_key
    packages           = var.packages
  })
}
