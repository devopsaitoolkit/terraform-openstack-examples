output "project_id" {
  description = "The generated ID of the project."
  value       = openstack_identity_project_v3.this.id
}

output "project_name" {
  description = "The name of the project."
  value       = openstack_identity_project_v3.this.name
}
