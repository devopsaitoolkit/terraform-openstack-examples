output "user_id" {
  description = "ID of the created service account user."
  value       = openstack_identity_user_v3.this.id
}

output "application_credential_id" {
  description = "ID of the application credential issued for the service account."
  value       = openstack_identity_application_credential_v3.this.id
}

output "application_credential_secret" {
  description = "Secret for the application credential. Shown once; store it securely."
  value       = openstack_identity_application_credential_v3.this.secret
  sensitive   = true
}
