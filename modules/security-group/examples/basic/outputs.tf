output "security_group_id" {
  description = "UUID of the created security group."
  value       = module.security_group.security_group_id
}

output "security_group_name" {
  description = "Name of the created security group."
  value       = module.security_group.security_group_name
}
