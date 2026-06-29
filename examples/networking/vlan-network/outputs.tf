output "network_id" {
  description = "UUID of the created VLAN network."
  value       = openstack_networking_network_v2.this.id
}

output "subnet_id" {
  description = "UUID of the created subnet."
  value       = openstack_networking_subnet_v2.this.id
}

output "vlan_id" {
  description = "802.1Q VLAN tag (segmentation_id) assigned to the network."
  value       = var.vlan_id
}
