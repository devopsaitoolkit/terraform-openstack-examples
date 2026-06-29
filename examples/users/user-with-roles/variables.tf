variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "user_name" {
  description = "Name of the identity user to create."
  type        = string
}

variable "user_password" {
  description = "Initial password for the user. Treat as a secret and rotate after first use."
  type        = string
  sensitive   = true
}

variable "project_id" {
  description = "ID of the project on which the role assignments are scoped."
  type        = string
}

variable "enabled" {
  description = "Whether the user account is enabled."
  type        = bool
  default     = true
}

variable "role_names" {
  description = "List of role names to assign to the user on the target project."
  type        = list(string)
  default     = ["member"]
}
