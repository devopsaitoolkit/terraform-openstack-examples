output "trunk_id" {
  description = "UUID of the trunk."
  value       = openstack_networking_trunk_v2.this.id
}

output "parent_port_id" {
  description = "UUID of the parent port bound to the trunk (attach this port to the VM NIC)."
  value       = openstack_networking_port_v2.parent.id
}

output "sub_port_ids" {
  description = "UUIDs of the two VLAN sub-ports carried by the trunk."
  value = [
    openstack_networking_port_v2.sub1.id,
    openstack_networking_port_v2.sub2.id,
  ]
}
