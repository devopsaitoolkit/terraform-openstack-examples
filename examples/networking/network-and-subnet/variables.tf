variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "network_name" {
  description = "Name of the tenant network to create."
  type        = string
  default     = "example-network"
}

variable "subnet_name" {
  description = "Name of the subnet to create on the network."
  type        = string
  default     = "example-subnet"
}

variable "cidr" {
  description = "CIDR range for the subnet."
  type        = string
  default     = "10.10.0.0/24"
}

variable "dns_nameservers" {
  description = "DNS resolvers handed to instances via DHCP."
  type        = list(string)
  default     = ["1.1.1.1", "8.8.8.8"]
}

variable "allocation_start" {
  description = "First address of the DHCP allocation pool."
  type        = string
  default     = "10.10.0.10"
}

variable "allocation_end" {
  description = "Last address of the DHCP allocation pool."
  type        = string
  default     = "10.10.0.200"
}
