output "project_ids" {
  description = "Map of project name => generated project ID."
  value       = { for name, project in openstack_identity_project_v3.this : name => project.id }
}

output "project_names" {
  description = "List of the bootstrapped project names."
  value       = keys(openstack_identity_project_v3.this)
}
