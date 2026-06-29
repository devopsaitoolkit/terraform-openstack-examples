output "web_secgroup_id" {
  description = "UUID of the web-tier security group."
  value       = openstack_networking_secgroup_v2.web.id
}

output "db_secgroup_id" {
  description = "UUID of the database-tier security group."
  value       = openstack_networking_secgroup_v2.db.id
}

output "db_from_web_rule_id" {
  description = "UUID of the rule allowing the web tier into the DB port."
  value       = openstack_networking_secgroup_rule_v2.db_from_web.id
}
