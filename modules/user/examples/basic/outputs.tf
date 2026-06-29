output "user_id" {
  description = "UUID of the created user."
  value       = module.user.user_id
}

output "user_name" {
  description = "Name of the created user."
  value       = module.user.user_name
}
