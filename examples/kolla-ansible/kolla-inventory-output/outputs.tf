output "control_ips" {
  description = "Management IPv4 addresses of the control-plane nodes."
  value       = openstack_compute_instance_v2.control[*].access_ip_v4
}

output "compute_ips" {
  description = "Management IPv4 addresses of the compute nodes."
  value       = openstack_compute_instance_v2.compute[*].access_ip_v4
}

output "storage_ips" {
  description = "Management IPv4 addresses of the storage nodes (empty if storage_count is 0)."
  value       = openstack_compute_instance_v2.storage[*].access_ip_v4
}

output "inventory_path" {
  description = "Path to the rendered Kolla-Ansible inventory file."
  value       = local_file.inventory.filename
}

output "keypair_name" {
  description = "Name of the key pair injected into every node."
  value       = openstack_compute_keypair_v2.kolla.name
}
