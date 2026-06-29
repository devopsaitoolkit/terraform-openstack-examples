variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "network_name" {
  description = "Name of the existing tenant network to attach the port to (looked up by name, no UUIDs)."
  type        = string
  default     = "private"
}

variable "port_name" {
  description = "Name of the port to create with port security disabled."
  type        = string
  default     = "example-no-port-security"
}
