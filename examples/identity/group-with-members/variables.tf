variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument). Must be admin-scoped to manage groups."
  type        = string
  default     = "openstack"
}

variable "group_name" {
  description = "Name of the Keystone group to create. Must be unique within the domain."
  type        = string
  default     = "example-group"
}

variable "group_description" {
  description = "Human-readable description of the group."
  type        = string
  default     = "Example group managed by Terraform."
}

variable "domain_id" {
  description = "ID of the pre-existing domain to create the group in. 'default' is the built-in Keystone domain."
  type        = string
  default     = "default"
}

variable "member_user_ids" {
  description = "List of existing user UUIDs to add to the group. Roles granted to the group apply to every member."
  type        = list(string)
  default     = []
}

variable "role_name" {
  description = "Name of the existing role to grant the group on the project, e.g. 'member' or 'reader'."
  type        = string
  default     = "member"
}

variable "project_id" {
  description = "UUID of the project on which the group is granted the role."
  type        = string
}
