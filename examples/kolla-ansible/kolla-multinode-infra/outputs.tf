output "controller_ids" {
  description = "UUIDs of the controller nodes."
  value       = openstack_compute_instance_v2.controller[*].id
}

output "controller_ips" {
  description = "Management IPv4 addresses of the controller nodes."
  value       = openstack_compute_instance_v2.controller[*].access_ip_v4
}

output "compute_ids" {
  description = "UUIDs of the compute nodes."
  value       = openstack_compute_instance_v2.compute[*].id
}

output "compute_ips" {
  description = "Management IPv4 addresses of the compute nodes."
  value       = openstack_compute_instance_v2.compute[*].access_ip_v4
}

output "keypair_name" {
  description = "Name of the key pair injected into every node."
  value       = openstack_compute_keypair_v2.kolla.name
}

output "security_group_id" {
  description = "UUID of the cluster security group."
  value       = openstack_networking_secgroup_v2.kolla.id
}

output "controller_server_group_id" {
  description = "UUID of the controllers server group."
  value       = openstack_compute_servergroup_v2.controllers.id
}

output "compute_server_group_id" {
  description = "UUID of the computes server group."
  value       = openstack_compute_servergroup_v2.computes.id
}
