output "project_id" {
  description = "UUID of the created project."
  value       = openstack_identity_project_v3.this.id
}

output "project_name" {
  description = "Name of the created project."
  value       = openstack_identity_project_v3.this.name
}
