output "primary_network_id" {
  description = "UUID of the primary-region application network."
  value       = openstack_networking_network_v2.primary.id
}

output "standby_network_id" {
  description = "UUID of the standby-region application network (always provisioned)."
  value       = openstack_networking_network_v2.standby.id
}

output "primary_instance_ids" {
  description = "UUIDs of the active primary-region instances."
  value       = openstack_compute_instance_v2.primary[*].id
}

output "primary_instance_ips" {
  description = "IPv4 addresses of the active primary-region instances."
  value       = openstack_compute_instance_v2.primary[*].access_ip_v4
}

output "standby_instance_ids" {
  description = "UUIDs of the standby-region instances (empty until failover scales them up)."
  value       = openstack_compute_instance_v2.standby[*].id
}

output "standby_instance_ips" {
  description = "IPv4 addresses of the standby-region instances (empty until failover)."
  value       = openstack_compute_instance_v2.standby[*].access_ip_v4
}
