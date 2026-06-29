output "quota_id" {
  description = "Resource ID of the managed compute quotaset (matches the project ID)."
  value       = openstack_compute_quotaset_v2.this.id
}

output "project_id" {
  description = "Project (tenant) ID the compute quota applies to."
  value       = openstack_compute_quotaset_v2.this.project_id
}

output "instances" {
  description = "Configured maximum number of instances."
  value       = openstack_compute_quotaset_v2.this.instances
}

output "cores" {
  description = "Configured maximum number of vCPU cores."
  value       = openstack_compute_quotaset_v2.this.cores
}

output "ram" {
  description = "Configured maximum RAM in MB."
  value       = openstack_compute_quotaset_v2.this.ram
}

output "key_pairs" {
  description = "Configured maximum number of key pairs."
  value       = openstack_compute_quotaset_v2.this.key_pairs
}

output "metadata_items" {
  description = "Configured maximum metadata items per server."
  value       = openstack_compute_quotaset_v2.this.metadata_items
}
