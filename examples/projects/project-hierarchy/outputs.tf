output "parent_project_id" {
  description = "The generated ID of the parent project."
  value       = openstack_identity_project_v3.parent.id
}

output "child_project_id" {
  description = "The generated ID of the child project."
  value       = openstack_identity_project_v3.child.id
}

output "child_parent_id" {
  description = "The parent_id recorded on the child project (should match parent_project_id)."
  value       = openstack_identity_project_v3.child.parent_id
}
