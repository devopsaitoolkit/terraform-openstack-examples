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

variable "zone_ttl" {
  description = "Default time-to-live (in seconds) for the zone's SOA/NS records."
  type        = number
  default     = 3600
}

variable "recordsets" {
  description = <<-EOT
    Map of recordsets to create in the zone, keyed by the fully qualified record
    name (MUST end with a dot). Each value sets the record type, TTL, and the
    list of record data values.
  EOT
  type = map(object({
    type    = string
    ttl     = number
    records = list(string)
  }))
  default = {
    "www.example.com." = {
      type    = "A"
      ttl     = 300
      records = ["192.0.2.10"]
    }
    "app.example.com." = {
      type    = "CNAME"
      ttl     = 300
      records = ["www.example.com."]
    }
    "example.com." = {
      type    = "MX"
      ttl     = 3600
      records = ["10 mail.example.com."]
    }
    "_dmarc.example.com." = {
      type    = "TXT"
      ttl     = 3600
      records = ["v=DMARC1; p=none; rua=mailto:dmarc@example.com"]
    }
  }

  validation {
    condition     = alltrue([for name in keys(var.recordsets) : can(regex("\\.$", name))])
    error_message = "Every recordset name (map key) must be a FQDN ending with a dot."
  }
}
