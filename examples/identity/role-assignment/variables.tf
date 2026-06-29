variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument). Must be admin-scoped to manage role assignments."
  type        = string
  default     = "openstack"
}

variable "role_name" {
  description = "Name of the existing role to grant, e.g. 'member', 'reader' or 'admin'. Looked up by name with a data source."
  type        = string
  default     = "member"
}

variable "user_id" {
  description = "UUID of the user to grant the role to. Get it from the user-basic example output or `openstack user show <name>`."
  type        = string
}

variable "project_id" {
  description = "UUID of the project on which the role is granted (the assignment scope). Get it from the project-basic example output or `openstack project show <name>`."
  type        = string
}
