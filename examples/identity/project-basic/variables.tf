variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument). Must be admin-scoped to create projects."
  type        = string
  default     = "openstack"
}

variable "project_name" {
  description = "Name of the Keystone project (tenant) to create. Must be unique within the domain."
  type        = string
  default     = "example-project"
}

variable "project_description" {
  description = "Human-readable description of the project."
  type        = string
  default     = "Example project managed by Terraform."
}

variable "domain_id" {
  description = "ID of the pre-existing domain to create the project in. There is no Terraform resource for domains; reference an existing one. 'default' is the built-in Keystone domain."
  type        = string
  default     = "default"
}

variable "enabled" {
  description = "Whether the project is enabled. A disabled project blocks all token issuance for its users."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags applied to the project for inventory and cost tracking."
  type        = list(string)
  default     = ["managed-by:terraform", "example:project-basic"]
}
