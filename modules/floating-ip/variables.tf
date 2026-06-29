variable "pool" {
  description = "Name of the external network (floating IP pool) to allocate addresses from, e.g. \"public\"."
  type        = string

  validation {
    condition     = length(var.pool) > 0
    error_message = "pool must not be empty."
  }
}

# NOTE: Terraform reserves the variable name "count", so this input is named
# "fip_count". It controls how many floating IPs are allocated.
variable "fip_count" {
  description = "Number of floating IPs to allocate from the pool."
  type        = number
  default     = 1

  validation {
    condition     = var.fip_count >= 0
    error_message = "fip_count must be zero or greater."
  }
}

variable "port_ids" {
  description = <<-EOT
    Optional Neutron port IDs to associate the allocated floating IPs with, in
    order. When non-empty, its length must equal fip_count so each floating IP
    maps to exactly one port. Leave empty to allocate unassociated floating IPs.
  EOT
  type        = list(string)
  default     = []
}

variable "description" {
  description = "Description applied to each allocated floating IP."
  type        = string
  default     = ""
}
