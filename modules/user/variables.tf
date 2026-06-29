variable "name" {
  description = "Name of the Keystone (Identity v3) user."
  type        = string

  validation {
    condition     = length(var.name) > 0
    error_message = "The user name must not be empty."
  }
}

variable "password" {
  description = <<-EOT
    Initial password for the user. Leave empty ("") to create the user without a
    password (the recommended approach — drive access through application
    credentials or federation instead). This value is write-only: it is never
    exposed as a module output.
  EOT
  type        = string
  default     = ""
  sensitive   = true
}

variable "default_project_id" {
  description = "ID of the project to scope the user to by default. Empty string leaves it unset."
  type        = string
  default     = ""
}

variable "domain_id" {
  description = "ID of the domain that owns the user. Empty string uses the provider's default domain."
  type        = string
  default     = ""
}

variable "enabled" {
  description = "Whether the user is enabled and able to authenticate."
  type        = bool
  default     = true
}

variable "role_assignments" {
  description = <<-EOT
    Roles to grant the user. Each entry assigns role_name on project_id. Role
    names are resolved to IDs via a data source, so you reference roles the way
    operators do (e.g. "member", "reader", "admin").
  EOT
  type = list(object({
    role_name  = string
    project_id = string
  }))
  default = []
}
