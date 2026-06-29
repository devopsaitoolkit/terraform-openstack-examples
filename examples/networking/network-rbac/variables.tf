variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "network_name" {
  description = "Name of the network to create and share via an RBAC policy."
  type        = string
  default     = "example-shared-network"
}

variable "target_project_id" {
  description = "Project/tenant ID to share the network with. This is a project ID looked up out-of-band (e.g. `openstack project show <name> -f value -c id`) and supplied as a variable — never hard-code a UUID in code."
  type        = string
}
