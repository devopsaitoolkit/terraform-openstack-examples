output "vip_address" {
  description = "The shared virtual IP floated between the two nodes by keepalived."
  value       = var.vip_address
}

output "vip_port_id" {
  description = "UUID of the Neutron port reserving the VIP."
  value       = openstack_networking_port_v2.vip.id
}

output "node_ids" {
  description = "UUIDs of the two keepalived instances (index 0 = MASTER, 1 = BACKUP)."
  value       = openstack_compute_instance_v2.node[*].id
}

output "node_ips" {
  description = "Per-node fixed IPv4 addresses (distinct from the shared VIP)."
  value       = openstack_compute_instance_v2.node[*].access_ip_v4
}

output "node_port_ids" {
  description = "UUIDs of the per-node ports carrying the allowed_address_pairs VIP whitelist."
  value       = openstack_networking_port_v2.node[*].id
}

output "security_group_id" {
  description = "UUID of the security group (SSH, service port, VRRP)."
  value       = openstack_networking_secgroup_v2.vip.id
}
