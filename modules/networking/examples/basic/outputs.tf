output "network_id" {
  description = "UUID of the created network."
  value       = module.networking.network_id
}

output "subnet_id" {
  description = "UUID of the created subnet."
  value       = module.networking.subnet_id
}

output "cidr" {
  description = "CIDR of the created subnet."
  value       = module.networking.cidr
}
