output "secgroup_id" {
  description = "UUID of the web-tier security group."
  value       = openstack_networking_secgroup_v2.web.id
}

output "secgroup_name" {
  description = "Name of the web-tier security group."
  value       = openstack_networking_secgroup_v2.web.name
}

output "ingress_rule_ids" {
  description = "Map of rule name to created ingress rule UUID."
  value       = { for k, r in openstack_networking_secgroup_rule_v2.ingress : k => r.id }
}
