output "instance_id" {
  description = "The UUID of the created GPU instance."
  value       = openstack_compute_instance_v2.gpu.id
}

output "instance_name" {
  description = "The name of the created GPU instance."
  value       = openstack_compute_instance_v2.gpu.name
}

output "access_ip_v4" {
  description = "The first IPv4 address assigned to the instance."
  value       = openstack_compute_instance_v2.gpu.access_ip_v4
}

output "flavor_id" {
  description = "The UUID of the GPU flavor the instance booted on."
  value       = data.openstack_compute_flavor_v2.gpu.id
}

output "flavor_vcpus" {
  description = "vCPU count of the resolved GPU flavor."
  value       = data.openstack_compute_flavor_v2.gpu.vcpus
}

output "flavor_ram_mb" {
  description = "RAM (MB) of the resolved GPU flavor."
  value       = data.openstack_compute_flavor_v2.gpu.ram
}
