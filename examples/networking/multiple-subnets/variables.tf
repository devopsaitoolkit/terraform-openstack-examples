variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "network_name" {
  description = "Name of the tenant network to create."
  type        = string
  default     = "multi-subnet-net"
}

variable "subnet_a_name" {
  description = "Name of the first subnet."
  type        = string
  default     = "subnet-a"
}

variable "subnet_b_name" {
  description = "Name of the second subnet."
  type        = string
  default     = "subnet-b"
}

variable "cidr_a" {
  description = "CIDR range for the first subnet."
  type        = string
  default     = "10.100.1.0/24"
}

variable "cidr_b" {
  description = "CIDR range for the second subnet."
  type        = string
  default     = "10.100.2.0/24"
}

variable "dns_nameservers" {
  description = "DNS nameservers assigned to instances on both subnets."
  type        = list(string)
  default     = ["1.1.1.1", "8.8.8.8"]
}
