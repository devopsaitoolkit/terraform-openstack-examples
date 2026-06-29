# Create a network in this project and selectively share it with ONE other
# project using a Neutron RBAC policy. Unlike `shared = true` (which exposes the
# network to every project in the cloud), an RBAC policy with
# `action = "access_as_shared"` grants access only to the named target project.
resource "openstack_networking_network_v2" "this" {
  name           = var.network_name
  admin_state_up = true
  tags           = ["managed-by:terraform", "example:network-rbac"]
}

# The target_project_id comes from a variable (see variables.tf) so no tenant
# UUID is baked into the code. Look it up out-of-band per environment.
resource "openstack_networking_rbac_policy_v2" "this" {
  object_type   = "network"
  object_id     = openstack_networking_network_v2.this.id
  action        = "access_as_shared"
  target_tenant = var.target_project_id
}
