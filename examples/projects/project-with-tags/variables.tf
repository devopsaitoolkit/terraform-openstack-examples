variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "project_name" {
  description = "Name of the OpenStack project (tenant) to create."
  type        = string
  default     = "tagged-project"
}

variable "project_description" {
  description = "Human-readable description for the project."
  type        = string
  default     = "Project managed by Terraform with metadata tags."
}

variable "enabled" {
  description = "Whether the project is enabled. Disabled projects block new resource creation and token issuance."
  type        = bool
  default     = true
}

variable "tags" {
  description = "List of tags applied to the project for inventory, ownership and automation filtering."
  type        = list(string)
  default     = ["managed-by:terraform", "env:dev"]
}

variable "domain_id" {
  description = "ID of the domain that owns the project. Leave empty to use the provider/token default domain."
  type        = string
  default     = ""
}
