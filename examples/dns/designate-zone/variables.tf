variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "zone_name" {
  description = "Fully qualified DNS zone name. Designate requires a trailing dot."
  type        = string
  default     = "example.com."

  validation {
    condition     = can(regex("\\.$", var.zone_name))
    error_message = "zone_name must be a fully qualified domain name ending with a dot (e.g. \"example.com.\")."
  }
}

variable "email" {
  description = "Email address of the zone administrator (stored in the SOA record)."
  type        = string
  default     = "hostmaster@example.com"
}

variable "ttl" {
  description = "Default time-to-live (in seconds) for the zone's SOA/NS records."
  type        = number
  default     = 3600
}

variable "description" {
  description = "Human-friendly description of the zone."
  type        = string
  default     = "Primary DNS zone managed by Terraform"
}
