output "instance_id" {
  description = "The UUID of the created instance."
  value       = openstack_compute_instance_v2.instance.id
}

output "access_ip_v4" {
  description = "The first IPv4 address assigned to the instance."
  value       = openstack_compute_instance_v2.instance.access_ip_v4
}

output "keypair_name" {
  description = "The name of the managed key pair."
  value       = openstack_compute_keypair_v2.this.name
}

output "keypair_fingerprint" {
  description = "The fingerprint of the managed key pair."
  value       = openstack_compute_keypair_v2.this.fingerprint
}
