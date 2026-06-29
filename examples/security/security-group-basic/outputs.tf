output "secgroup_id" {
  description = "UUID of the created security group (attach to instances/ports)."
  value       = openstack_networking_secgroup_v2.web.id
}

output "secgroup_name" {
  description = "Name of the created security group."
  value       = openstack_networking_secgroup_v2.web.name
}

output "ingress_rule_ids" {
  description = "UUIDs of the ingress rules (SSH, HTTPS)."
  value = [
    openstack_networking_secgroup_rule_v2.ssh_in.id,
    openstack_networking_secgroup_rule_v2.https_in.id,
  ]
}
