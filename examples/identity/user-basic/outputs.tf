output "user_id" {
  description = "The UUID of the created user. Use this as user_id in role assignments and credentials."
  value       = openstack_identity_user_v3.user.id
}

output "user_name" {
  description = "The login name of the created user."
  value       = openstack_identity_user_v3.user.name
}

output "domain_id" {
  description = "The domain the user belongs to."
  value       = openstack_identity_user_v3.user.domain_id
}

# Deliberately NOT exposing the password as an output. The password lives in
# state (which is why state must be encrypted/restricted); echoing it as an
# output would also leak it into logs and `terraform output`.
