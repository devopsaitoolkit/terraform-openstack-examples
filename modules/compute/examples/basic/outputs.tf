output "instance_ids" {
  description = "UUIDs of the instances created by the module."
  value       = module.compute.instance_ids
}

output "instance_names" {
  description = "Names of the instances created by the module."
  value       = module.compute.instance_names
}

output "access_ips" {
  description = "First IPv4 address of each instance."
  value       = module.compute.access_ips
}
