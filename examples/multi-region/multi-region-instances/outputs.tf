output "region1_instance_id" {
  description = "UUID of the region 1 instance."
  value       = openstack_compute_instance_v2.region1.id
}

output "region1_access_ip_v4" {
  description = "First IPv4 address of the region 1 instance."
  value       = openstack_compute_instance_v2.region1.access_ip_v4
}

output "region2_instance_id" {
  description = "UUID of the region 2 instance."
  value       = openstack_compute_instance_v2.region2.id
}

output "region2_access_ip_v4" {
  description = "First IPv4 address of the region 2 instance."
  value       = openstack_compute_instance_v2.region2.access_ip_v4
}
