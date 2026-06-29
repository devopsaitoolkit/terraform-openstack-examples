output "ec2_credential_id" {
  description = "The ID of the EC2 credential resource (equals the access key)."
  value       = openstack_identity_ec2_credential_v3.ec2.id
}

output "access_key" {
  description = "The EC2 access key (AWS_ACCESS_KEY_ID equivalent). Sensitive — it pairs with the secret to grant access."
  value       = openstack_identity_ec2_credential_v3.ec2.access
  sensitive   = true
}

output "secret_key" {
  description = "The EC2 secret key (AWS_SECRET_ACCESS_KEY equivalent). Store immediately in a secrets manager."
  value       = openstack_identity_ec2_credential_v3.ec2.secret
  sensitive   = true
}

output "project_id" {
  description = "The project the EC2 credential is scoped to."
  value       = openstack_identity_ec2_credential_v3.ec2.project_id
}
