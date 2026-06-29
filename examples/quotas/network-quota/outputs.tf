output "quota_id" {
  description = "Resource ID of the managed networking quota (matches the project ID)."
  value       = openstack_networking_quota_v2.this.id
}

output "project_id" {
  description = "Project (tenant) ID the network quota applies to."
  value       = openstack_networking_quota_v2.this.project_id
}

output "network" {
  description = "Configured maximum number of networks."
  value       = openstack_networking_quota_v2.this.network
}

output "subnet" {
  description = "Configured maximum number of subnets."
  value       = openstack_networking_quota_v2.this.subnet
}

output "port" {
  description = "Configured maximum number of ports."
  value       = openstack_networking_quota_v2.this.port
}

output "router" {
  description = "Configured maximum number of routers."
  value       = openstack_networking_quota_v2.this.router
}

output "floatingip" {
  description = "Configured maximum number of floating IPs."
  value       = openstack_networking_quota_v2.this.floatingip
}

output "security_group" {
  description = "Configured maximum number of security groups."
  value       = openstack_networking_quota_v2.this.security_group
}

output "security_group_rule" {
  description = "Configured maximum number of security group rules."
  value       = openstack_networking_quota_v2.this.security_group_rule
}
