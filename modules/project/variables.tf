variable "name" {
  description = "Name of the Keystone project (tenant)."
  type        = string
}

variable "description" {
  description = "Human-readable description of the project."
  type        = string
  default     = ""
}

variable "domain_id" {
  description = "ID of the domain to create the project in. Leave empty to use the provider's default domain."
  type        = string
  default     = ""
}

variable "enabled" {
  description = "Whether the project is enabled. Disabled projects block access to their resources."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags applied to the project."
  type        = list(string)
  default     = []
}

variable "parent_id" {
  description = "ID of the parent project for hierarchical multi-tenancy. Leave empty for a top-level project."
  type        = string
  default     = ""
}
