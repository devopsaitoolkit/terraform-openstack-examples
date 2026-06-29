variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "user_name" {
  description = "Name of the identity user to create and add to the group."
  type        = string
}

variable "user_password" {
  description = "Initial password for the user. Treat as a secret and rotate after first use."
  type        = string
  sensitive   = true
}

variable "group_name" {
  description = "Name of the identity group to create."
  type        = string
}

variable "project_id" {
  description = "ID of the project on which the group's role is scoped."
  type        = string
}

variable "role_name" {
  description = "Name of the role to assign to the group on the target project."
  type        = string
  default     = "member"
}
