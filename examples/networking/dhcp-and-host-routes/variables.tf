variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "network_name" {
  description = "Name of the tenant network to create."
  type        = string
  default     = "example-dhcp-network"
}

variable "subnet_name" {
  description = "Name of the subnet to create on the network."
  type        = string
  default     = "example-dhcp-subnet"
}

variable "cidr" {
  description = "CIDR range for the subnet."
  type        = string
  default     = "10.80.0.0/24"
}

variable "dns_nameservers" {
  description = "DNS resolvers handed to instances via DHCP."
  type        = list(string)
  default     = ["1.1.1.1", "8.8.8.8"]
}

variable "allocation_start" {
  description = "First address of the DHCP allocation pool."
  type        = string
  default     = "10.80.0.10"
}

variable "allocation_end" {
  description = "Last address of the DHCP allocation pool."
  type        = string
  default     = "10.80.0.200"
}

variable "host_routes" {
  description = "Static routes pushed to instances via DHCP (subnet host_routes). Each route sends traffic for destination_cidr to next_hop."
  type = list(object({
    destination_cidr = string
    next_hop         = string
  }))
  default = [
    {
      destination_cidr = "10.99.0.0/16"
      next_hop         = "10.80.0.1"
    },
  ]
}
