variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "parent_name" {
  description = "Name of the top-level parent project (e.g. an organisation or business unit)."
  type        = string
  default     = "engineering"
}

variable "child_name" {
  description = "Name of the child project nested under the parent (e.g. a team or department)."
  type        = string
  default     = "engineering-platform"
}

variable "description" {
  description = "Description applied to both the parent and child projects."
  type        = string
  default     = "Project created via Terraform project-hierarchy example."
}

variable "domain_id" {
  description = "ID of the domain that owns the parent project. Leave empty to use the provider/token default domain. The child inherits the parent's domain."
  type        = string
  default     = ""
}
