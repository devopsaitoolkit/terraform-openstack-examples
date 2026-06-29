variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "reverse_zone_name" {
  description = "Reverse DNS zone name in in-addr.arpa form. Must end with a dot. Example: \"2.0.192.in-addr.arpa.\" covers 192.0.2.0/24."
  type        = string
  default     = "2.0.192.in-addr.arpa."

  validation {
    condition     = can(regex("\\.$", var.reverse_zone_name))
    error_message = "reverse_zone_name must end with a dot (e.g. \"2.0.192.in-addr.arpa.\")."
  }
}

variable "email" {
  description = "Email address of the zone administrator (stored in the SOA record)."
  type        = string
  default     = "hostmaster@example.com"
}

variable "zone_ttl" {
  description = "Default time-to-live (in seconds) for the reverse zone's SOA/NS records."
  type        = number
  default     = 3600
}

variable "ptr_name" {
  description = "Fully qualified PTR record name (reversed IP + .in-addr.arpa.). Must end with a dot. Example for 192.0.2.10: \"10.2.0.192.in-addr.arpa.\"."
  type        = string
  default     = "10.2.0.192.in-addr.arpa."

  validation {
    condition     = can(regex("\\.$", var.ptr_name))
    error_message = "ptr_name must end with a dot (e.g. \"10.2.0.192.in-addr.arpa.\")."
  }
}

variable "ptr_records" {
  description = "List of fully qualified hostnames the IP should resolve back to. Each should end with a dot."
  type        = list(string)
  default     = ["host10.example.com."]
}

variable "ptr_ttl" {
  description = "Time-to-live (in seconds) for the PTR recordset."
  type        = number
  default     = 3600
}
