variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument). Must be admin-scoped to create users."
  type        = string
  default     = "openstack"
}

variable "user_name" {
  description = "Login name of the Keystone user to create. Must be unique within the domain."
  type        = string
  default     = "example-user"
}

variable "user_password" {
  description = "Initial password for the user. Prefer application credentials over passwords for automation (see README). Leave empty to create a user without a password (e.g. federated/SSO users)."
  type        = string
  default     = ""
  sensitive   = true
}

variable "default_project_id" {
  description = "ID of the project this user is scoped to by default when requesting a token without an explicit project. Leave empty to omit."
  type        = string
  default     = ""
}

variable "domain_id" {
  description = "ID of the pre-existing domain to create the user in. 'default' is the built-in Keystone domain."
  type        = string
  default     = "default"
}

variable "description" {
  description = "Human-readable description of the user."
  type        = string
  default     = "Example user managed by Terraform."
}

variable "enabled" {
  description = "Whether the user account is enabled. A disabled user cannot authenticate."
  type        = bool
  default     = true
}

variable "ignore_change_password_upon_first_use" {
  description = "If true, the user is not forced to change the password on first login. Useful for service accounts; avoid for humans."
  type        = bool
  default     = false
}
