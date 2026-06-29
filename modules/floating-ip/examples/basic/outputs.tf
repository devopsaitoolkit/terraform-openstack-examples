output "floating_ip_addresses" {
  description = "Allocated floating IP addresses."
  value       = module.floating_ip.floating_ip_addresses
}

output "floating_ip_ids" {
  description = "UUIDs of the allocated floating IPs."
  value       = module.floating_ip.floating_ip_ids
}
