output "application_credential_id" {
  description = "The UUID of the application credential. Used together with the secret to authenticate."
  value       = openstack_identity_application_credential_v3.app_cred.id
}

output "application_credential_name" {
  description = "The name of the application credential."
  value       = openstack_identity_application_credential_v3.app_cred.name
}

output "application_credential_secret" {
  description = "The generated secret. Shown only at creation time — store it immediately in a secrets manager. Marked sensitive so it is not printed in plan/apply logs."
  value       = openstack_identity_application_credential_v3.app_cred.secret
  sensitive   = true
}
