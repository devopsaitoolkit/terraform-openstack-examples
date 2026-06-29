# A machine / service identity.
#
# Static passwords are a poor fit for automation: they expire, must be rotated,
# and often end up embedded in CI config. The preferred pattern is to create the
# user once, then issue an *application credential* that automation uses to
# authenticate. The app credential can be revoked independently and carries only
# the roles you grant it.

resource "openstack_identity_user_v3" "this" {
  name        = var.user_name
  password    = var.user_password
  enabled     = true
  description = "Service account managed by Terraform (machine identity, non-interactive)."

  # Service accounts should not be subjected to interactive password lifecycle.
  ignore_password_expiry                = true
  ignore_change_password_upon_first_use = true
  ignore_lockout_failure_attempts       = true
}

# Look up the role to grant on the target project.
data "openstack_identity_role_v3" "role" {
  name = var.role_name
}

resource "openstack_identity_role_assignment_v3" "this" {
  user_id    = openstack_identity_user_v3.this.id
  project_id = var.project_id
  role_id    = data.openstack_identity_role_v3.role.id
}

# Application credential = the preferred machine-auth method. Secret is generated
# by Keystone and returned as a sensitive computed attribute.
resource "openstack_identity_application_credential_v3" "this" {
  name        = var.app_credential_name
  description = "Application credential for service account ${var.user_name}."
  expires_at  = var.app_credential_expires_at != "" ? var.app_credential_expires_at : null
}
