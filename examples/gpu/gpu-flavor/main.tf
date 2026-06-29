# ADMIN-ONLY: define a GPU flavor. The extra_specs are what make it a GPU flavor;
# the flavor's CPU/RAM/disk are ordinary Nova sizing. Tenants then boot on this
# flavor (see ../gpu-instance).
resource "openstack_compute_flavor_v2" "gpu" {
  name      = var.flavor_name
  vcpus     = var.vcpus
  ram       = var.ram_mb
  disk      = var.disk_gb
  is_public = var.is_public

  # The GPU request and scheduler steering live entirely here.
  extra_specs = var.extra_specs
}

# A server group lets tenants place GPU instances with (anti-)affinity. It is
# created here for convenience but is project-scoped, not admin-only. Keeping
# GPU instances anti-affine spreads them across scarce GPU hosts.
resource "openstack_compute_servergroup_v2" "gpu" {
  name     = var.server_group_name
  policies = var.server_group_policies
}
