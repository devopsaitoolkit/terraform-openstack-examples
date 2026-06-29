variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "external_network_name" {
  description = "Name of the external (public) network that the floating IP is allocated from. Its name is used as the floating IP pool."
  type        = string
  default     = "public"
}

variable "port_id" {
  description = "UUID of the existing Neutron port to associate the floating IP with (e.g. an instance's port). Find it with `openstack port list`."
  type        = string
}

variable "fixed_ip" {
  description = "Specific fixed IP on the port to map the floating IP to. Required only when the port has multiple fixed IPs; leave empty to let Neutron choose."
  type        = string
  default     = ""
}

variable "description" {
  description = "Human-readable description stored on the floating IP for inventory."
  type        = string
  default     = "Associated by Terraform"
}

variable "tags" {
  description = "Tags applied to the floating IP for inventory and cost tracking."
  type        = list(string)
  default     = ["managed-by:terraform", "example:associate-to-port"]
}
