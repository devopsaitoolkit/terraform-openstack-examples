output "flavor_id" {
  description = "The UUID of the created GPU flavor. Pass this (or its name) to the gpu-instance example."
  value       = openstack_compute_flavor_v2.gpu.id
}

output "flavor_name" {
  description = "The name of the created GPU flavor."
  value       = openstack_compute_flavor_v2.gpu.name
}

output "flavor_extra_specs" {
  description = "The effective extra_specs on the flavor (the keys that request the GPU)."
  value       = openstack_compute_flavor_v2.gpu.extra_specs
}

output "server_group_id" {
  description = "The UUID of the server group for (anti-)affinity placement."
  value       = openstack_compute_servergroup_v2.gpu.id
}

output "server_group_policies" {
  description = "The scheduling policies applied to the server group."
  value       = openstack_compute_servergroup_v2.gpu.policies
}
