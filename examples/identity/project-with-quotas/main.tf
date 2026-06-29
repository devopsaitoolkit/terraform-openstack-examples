# Create a project and pin its compute + network quotas in one config, so the
# blast radius of a team/tenant is capped at provisioning time.
#
# All of this requires an ADMIN-scoped credential.
resource "openstack_identity_project_v3" "project" {
  name        = var.project_name
  description = var.project_description
  domain_id   = var.domain_id
  enabled     = true
}

# Nova quotas for the project. Referencing the project's id ties the lifecycle
# together — destroying the project tears the quota override down with it.
resource "openstack_compute_quotaset_v2" "compute" {
  project_id = openstack_identity_project_v3.project.id

  instances = var.compute_instances
  cores     = var.compute_cores
  ram       = var.compute_ram_mb
  key_pairs = var.compute_key_pairs
}

# Neutron quotas for the same project.
resource "openstack_networking_quota_v2" "network" {
  project_id = openstack_identity_project_v3.project.id

  network        = var.network_count
  subnet         = var.subnet_count
  port           = var.port_count
  router         = var.router_count
  floatingip     = var.floatingip_count
  security_group = var.security_group_count
}
