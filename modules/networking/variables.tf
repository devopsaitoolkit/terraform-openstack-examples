variable "name" {
  description = "Name of the network. The subnet is named \"<name>-subnet\"."
  type        = string
}

variable "cidr" {
  description = "CIDR block for the subnet, e.g. 10.0.0.0/24."
  type        = string

  validation {
    condition     = can(cidrhost(var.cidr, 0))
    error_message = "cidr must be a valid IPv4/IPv6 CIDR block (e.g. 10.0.0.0/24)."
  }
}

variable "dns_nameservers" {
  description = "List of DNS resolver IPs handed out via DHCP."
  type        = list(string)
  default     = []
}

variable "enable_dhcp" {
  description = "Whether DHCP is enabled on the subnet."
  type        = bool
  default     = true
}

variable "allocation_pools" {
  description = "Address ranges DHCP may allocate from. Empty means the whole CIDR (minus the gateway)."
  type = list(object({
    start = string
    end   = string
  }))
  default = []
}

variable "ip_version" {
  description = "IP version for the subnet (4 or 6)."
  type        = number
  default     = 4

  validation {
    condition     = contains([4, 6], var.ip_version)
    error_message = "ip_version must be 4 or 6."
  }
}

variable "tags" {
  description = "Tags applied to both the network and the subnet."
  type        = list(string)
  default     = []
}
