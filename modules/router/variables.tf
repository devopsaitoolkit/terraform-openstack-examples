variable "name" {
  description = "Name of the Neutron router."
  type        = string

  validation {
    condition     = length(var.name) > 0
    error_message = "The router name must not be empty."
  }
}

variable "external_network_id" {
  description = "ID of the external network used as the router's gateway (for north-south traffic and floating IPs)."
  type        = string

  validation {
    condition     = length(var.external_network_id) > 0
    error_message = "external_network_id must not be empty."
  }
}

variable "enable_snat" {
  description = "Whether to enable source NAT on the external gateway."
  type        = bool
  default     = true
}

variable "subnet_ids" {
  description = "Tenant subnet IDs to attach to the router via router interfaces."
  type        = list(string)
  default     = []
}

variable "admin_state_up" {
  description = "Administrative state of the router (true = up)."
  type        = bool
  default     = true
}
