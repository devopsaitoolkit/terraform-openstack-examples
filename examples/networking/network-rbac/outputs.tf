output "network_id" {
  description = "UUID of the created network."
  value       = openstack_networking_network_v2.this.id
}

output "rbac_policy_id" {
  description = "UUID of the RBAC policy that shares the network with the target project."
  value       = openstack_networking_rbac_policy_v2.this.id
}
