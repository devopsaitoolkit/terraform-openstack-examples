# Create a Keystone user in an existing domain.
#
# IMPORTANT: storing a long-lived password in Terraform state is a liability.
# For machine/automation identities, prefer application credentials
# (see ../application-credential/) which are revocable, scoped and never put a
# reusable account password on disk. Use this resource mainly for human users
# or to bootstrap an account whose password is rotated out-of-band.
#
# Requires an admin (or domain-admin) token to apply.
resource "openstack_identity_user_v3" "user" {
  name      = var.user_name
  domain_id = var.domain_id

  # Pass null (not "") when no password is supplied so the attribute is omitted
  # rather than set to an empty string.
  password = var.user_password != "" ? var.user_password : null

  default_project_id = var.default_project_id != "" ? var.default_project_id : null
  description        = var.description
  enabled            = var.enabled

  ignore_change_password_upon_first_use = var.ignore_change_password_upon_first_use
}
