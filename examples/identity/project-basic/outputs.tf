output "project_id" {
  description = "The UUID of the created project. Use this as project_id in role assignments and quotas."
  value       = openstack_identity_project_v3.project.id
}

output "project_name" {
  description = "The name of the created project."
  value       = openstack_identity_project_v3.project.name
}

output "domain_id" {
  description = "The domain the project belongs to."
  value       = openstack_identity_project_v3.project.domain_id
}
