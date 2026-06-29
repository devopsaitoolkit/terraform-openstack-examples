variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "network_name" {
  description = "Name of the dual-stack network to create."
  type        = string
  default     = "dualstack"
}

variable "cidr_v4" {
  description = "IPv4 CIDR for the IPv4 subnet."
  type        = string
  default     = "10.60.0.0/24"
}

variable "cidr_v6" {
  description = "IPv6 CIDR for the SLAAC IPv6 subnet."
  type        = string
  default     = "fd00:60::/64"
}
