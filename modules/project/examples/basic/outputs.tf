output "project_id" {
  description = "UUID of the created project."
  value       = module.project.project_id
}

output "project_name" {
  description = "Name of the created project."
  value       = module.project.project_name
}
