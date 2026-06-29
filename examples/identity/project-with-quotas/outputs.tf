output "project_id" {
  description = "The UUID of the created project."
  value       = openstack_identity_project_v3.project.id
}

output "project_name" {
  description = "The name of the created project."
  value       = openstack_identity_project_v3.project.name
}

output "compute_quota" {
  description = "Effective compute quota values applied to the project."
  value = {
    instances = openstack_compute_quotaset_v2.compute.instances
    cores     = openstack_compute_quotaset_v2.compute.cores
    ram       = openstack_compute_quotaset_v2.compute.ram
    key_pairs = openstack_compute_quotaset_v2.compute.key_pairs
  }
}

output "network_quota" {
  description = "Effective network quota values applied to the project."
  value = {
    network        = openstack_networking_quota_v2.network.network
    subnet         = openstack_networking_quota_v2.network.subnet
    port           = openstack_networking_quota_v2.network.port
    router         = openstack_networking_quota_v2.network.router
    floatingip     = openstack_networking_quota_v2.network.floatingip
    security_group = openstack_networking_quota_v2.network.security_group
  }
}
