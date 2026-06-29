variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "external_network_name" {
  description = "Name of the external (public) network that floating IPs are allocated from. This network's name is used as the floating IP pool."
  type        = string
  default     = "public"
}

variable "description" {
  description = "Human-readable description stored on the floating IP for inventory."
  type        = string
  default     = "Allocated by Terraform"
}

variable "tags" {
  description = "Tags applied to the floating IP for inventory and cost tracking."
  type        = list(string)
  default     = ["managed-by:terraform", "example:allocate-floating-ip"]
}
