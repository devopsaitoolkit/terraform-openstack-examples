variable "name" {
  description = "Name of the security group."
  type        = string
}

variable "description" {
  description = "Human-readable description of the security group."
  type        = string
  default     = "Managed by Terraform"
}

variable "rules" {
  description = <<-EOT
    Security group rules. Each rule:
      - direction:        "ingress" or "egress"
      - ethertype:        "IPv4" or "IPv6"
      - protocol:         e.g. "tcp", "udp", "icmp" (empty/null = any)
      - port_min:         lowest port in range (optional; omit for ICMP/any)
      - port_max:         highest port in range (optional)
      - remote_ip_prefix: source/destination CIDR (optional)
  EOT
  type = list(object({
    direction        = string
    ethertype        = string
    protocol         = optional(string)
    port_min         = optional(number)
    port_max         = optional(number)
    remote_ip_prefix = optional(string)
  }))
  default = []

  validation {
    condition     = alltrue([for r in var.rules : contains(["ingress", "egress"], r.direction)])
    error_message = "Each rule direction must be \"ingress\" or \"egress\"."
  }

  validation {
    condition     = alltrue([for r in var.rules : contains(["IPv4", "IPv6"], r.ethertype)])
    error_message = "Each rule ethertype must be \"IPv4\" or \"IPv6\"."
  }
}

variable "tags" {
  description = "Tags applied to the security group."
  type        = list(string)
  default     = []
}
