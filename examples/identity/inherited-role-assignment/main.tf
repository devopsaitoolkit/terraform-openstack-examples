# Role inheritance lets you grant a role ONCE at the domain (or parent-project)
# level and have it apply automatically to every project beneath it — present
# and future. This is the OpenStack analogue of "grant on the OU, inherit to all
# accounts": ideal for an auditor/reader that should see every project, or a
# platform team that operates all subprojects.
#
# Key point: an INHERITED assignment on a domain is NOT effective on the domain
# object itself — only on the projects within it. (Use a normal
# openstack_identity_role_assignment_v3 if you also need it on the domain.)
#
# Requires an admin (or domain-admin) token to apply.
data "openstack_identity_role_v3" "role" {
  name = var.role_name
}

resource "openstack_identity_inherit_role_assignment_v3" "domain_inherited" {
  user_id   = var.user_id
  domain_id = var.domain_id
  role_id   = data.openstack_identity_role_v3.role.id
}
