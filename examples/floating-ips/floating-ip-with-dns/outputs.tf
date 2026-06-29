output "floating_ip_id" {
  description = "The UUID of the floating IP."
  value       = openstack_networking_floatingip_v2.fip.id
}

output "floating_ip_address" {
  description = "The allocated floating IP address."
  value       = openstack_networking_floatingip_v2.fip.address
}

output "fqdn" {
  description = "Fully qualified domain name Designate publishes for the floating IP."
  value       = "${var.dns_name}.${var.dns_domain}"
}
