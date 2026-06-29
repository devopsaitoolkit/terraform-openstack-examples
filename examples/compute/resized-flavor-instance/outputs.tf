output "flavor_id" {
  description = "The UUID of the resolved flavor."
  value       = data.openstack_compute_flavor_v2.this.id
}

output "flavor_name" {
  description = "The name of the resolved flavor."
  value       = data.openstack_compute_flavor_v2.this.name
}

output "flavor_vcpus" {
  description = "The number of vCPUs in the resolved flavor."
  value       = data.openstack_compute_flavor_v2.this.vcpus
}

output "flavor_ram" {
  description = "The amount of RAM (MB) in the resolved flavor."
  value       = data.openstack_compute_flavor_v2.this.ram
}

output "instance_id" {
  description = "The UUID of the created instance."
  value       = openstack_compute_instance_v2.instance.id
}
