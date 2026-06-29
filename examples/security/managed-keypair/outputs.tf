output "keypair_name" {
  description = "Name of the registered key pair (use as key_pair on instances)."
  value       = openstack_compute_keypair_v2.managed.name
}

output "fingerprint" {
  description = "Fingerprint of the registered public key."
  value       = openstack_compute_keypair_v2.managed.fingerprint
}

output "public_key" {
  description = "The registered public key (public material only; safe to expose)."
  value       = openstack_compute_keypair_v2.managed.public_key
}
