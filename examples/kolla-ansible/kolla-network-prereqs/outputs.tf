output "management_network_id" {
  description = "UUID of the Kolla management network."
  value       = openstack_networking_network_v2.management.id
}

output "management_subnet_id" {
  description = "UUID of the Kolla management subnet."
  value       = openstack_networking_subnet_v2.management.id
}

output "tunnel_network_id" {
  description = "UUID of the Kolla tunnel/overlay network."
  value       = openstack_networking_network_v2.tunnel.id
}

output "tunnel_subnet_id" {
  description = "UUID of the Kolla tunnel/overlay subnet."
  value       = openstack_networking_subnet_v2.tunnel.id
}

output "external_network_id" {
  description = "UUID of the external/provider network (floating IPs)."
  value       = openstack_networking_network_v2.external.id
}

output "external_subnet_id" {
  description = "UUID of the external/provider subnet."
  value       = openstack_networking_subnet_v2.external.id
}
