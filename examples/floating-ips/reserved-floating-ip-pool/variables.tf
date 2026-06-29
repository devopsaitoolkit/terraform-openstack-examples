variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "external_network_name" {
  description = "Name of the external (public) network that floating IPs are allocated from. Its name is used as the floating IP pool."
  type        = string
  default     = "public"
}

variable "reserved_ip_names" {
  description = "Logical names for the floating IPs to reserve. One floating IP is allocated per name via for_each; the names also tag each address so you can tell them apart."
  type        = set(string)
  default     = ["web", "api", "vpn", "spare"]
}

variable "tags" {
  description = "Base tags applied to every reserved floating IP for inventory and cost tracking."
  type        = list(string)
  default     = ["managed-by:terraform", "example:reserved-floating-ip-pool"]
}
