output "router_id" {
  description = "UUID of the created router."
  value       = module.router.router_id
}

output "external_gateway" {
  description = "External network ID used as the gateway."
  value       = module.router.external_gateway
}
