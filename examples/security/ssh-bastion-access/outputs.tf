output "bastion_secgroup_id" {
  description = "UUID of the bastion security group."
  value       = openstack_networking_secgroup_v2.bastion.id
}

output "app_secgroup_id" {
  description = "UUID of the application security group."
  value       = openstack_networking_secgroup_v2.app.id
}

output "app_ssh_from_bastion_rule_id" {
  description = "UUID of the rule allowing SSH into the app group from the bastion group."
  value       = openstack_networking_secgroup_rule_v2.app_ssh_from_bastion.id
}
