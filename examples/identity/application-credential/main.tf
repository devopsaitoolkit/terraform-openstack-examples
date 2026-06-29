# An application credential is the RIGHT way to give automation access to
# OpenStack. Unlike a username/password it is:
#   - scoped to a single user + project,
#   - limited to a chosen subset of that user's roles,
#   - expirable (expires_at),
#   - restricted by default (cannot create more creds or trusts),
#   - independently revocable without changing the account password.
#
# It is created for the AUTHENTICATED user of the provider's cloud entry, so it
# does NOT require an admin role.
resource "openstack_identity_application_credential_v3" "app_cred" {
  name        = var.name
  description = var.description

  # Empty list => inherit all of the user's roles. Provide a list to restrict.
  roles = var.roles

  # Omit (null) when no expiry is configured.
  expires_at = var.expires_at != "" ? var.expires_at : null

  # Keep restricted: an unrestricted credential can mint more credentials/trusts.
  unrestricted = var.unrestricted

  # access_rules {} could further constrain the credential to specific API
  # paths/methods/services; left off here for a general-purpose example.
}
