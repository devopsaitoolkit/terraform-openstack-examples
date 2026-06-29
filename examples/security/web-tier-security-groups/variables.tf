variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "secgroup_name" {
  description = "Name of the web-tier security group."
  type        = string
  default     = "example-web-tier"
}

# A map of named rules. The key becomes the resource instance key (and is used
# in the rule description), so it must be stable and human-meaningful. Driving
# rules from data makes this a reusable, copy-pasteable pattern: add a port by
# adding a map entry, not by writing a new resource block.
variable "ingress_rules" {
  description = "Map of ingress rules to create. Key = rule name; value = {protocol, port, cidr}."
  type = map(object({
    protocol = string
    port     = number
    cidr     = string
  }))
  default = {
    https = {
      protocol = "tcp"
      port     = 443
      cidr     = "0.0.0.0/0"
    }
    http_redirect = {
      protocol = "tcp"
      port     = 80
      cidr     = "0.0.0.0/0"
    }
    ssh_admin = {
      protocol = "tcp"
      port     = 22
      cidr     = "203.0.113.0/24"
    }
  }

  validation {
    condition = alltrue([
      for r in values(var.ingress_rules) : !(r.port == 22 && r.cidr == "0.0.0.0/0")
    ])
    error_message = "SSH (port 22) must not be opened to 0.0.0.0/0. Scope it to an admin CIDR."
  }
}

variable "tags" {
  description = "Tags applied to the security group."
  type        = list(string)
  default     = ["managed-by:terraform", "example:web-tier-security-groups"]
}
