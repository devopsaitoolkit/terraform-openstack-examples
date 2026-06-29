variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "name_prefix" {
  description = "Prefix used to name the networks, subnets, and ports."
  type        = string
  default     = "multinic"
}

variable "cidr_a" {
  description = "CIDR for the first subnet (NIC A)."
  type        = string
  default     = "10.50.1.0/24"
}

variable "cidr_b" {
  description = "CIDR for the second subnet (NIC B)."
  type        = string
  default     = "10.50.2.0/24"
}
