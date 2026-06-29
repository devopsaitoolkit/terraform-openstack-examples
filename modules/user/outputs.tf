# NOTE: the user's password is intentionally NOT exposed as an output. Treat it
# as write-only credential material and rotate it out-of-band.

output "user_id" {
  description = "The UUID of the created Identity v3 user."
  value       = openstack_identity_user_v3.this.id
}

output "user_name" {
  description = "The name of the created Identity v3 user."
  value       = openstack_identity_user_v3.this.name
}
