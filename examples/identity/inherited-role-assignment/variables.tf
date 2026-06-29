variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use. Inherited role assignments require an ADMIN (or domain-admin) credential."
  type        = string
  default     = "openstack"
}

variable "domain_id" {
  description = "ID of the domain to grant the inherited role on. The role is NOT effective on the domain itself — it is inherited by every project inside the domain (and their subprojects). 'default' is the built-in Keystone domain."
  type        = string
  default     = "default"
}

variable "user_id" {
  description = "UUID of the user receiving the inherited role across all projects in the domain. Get it from the user-basic output or `openstack user show <name>`."
  type        = string
}

variable "role_name" {
  description = "Name of the existing role to inherit, e.g. 'member' or 'reader'. Looked up by name."
  type        = string
  default     = "reader"
}
