# Sets Neutron (networking) quotas on an EXISTING project. This is an
# admin-scoped operation: the credentials in clouds.yaml must map to a user with
# the admin role. Terraform does not create the project; it manages its limits.
resource "openstack_networking_quota_v2" "this" {
  project_id = var.project_id

  network             = var.network
  subnet              = var.subnet
  port                = var.port
  router              = var.router
  floatingip          = var.floatingip
  security_group      = var.security_group
  security_group_rule = var.security_group_rule
}
