variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "external_network_name" {
  description = "Name of the external (public) network that the floating IP is allocated from. Its name is used as the floating IP pool."
  type        = string
  default     = "public"
}

variable "dns_name" {
  description = "Host portion of the DNS record Designate creates for the floating IP (e.g. \"web-01\"). Combined with dns_domain to form the FQDN."
  type        = string
  default     = "web-01"
}

variable "dns_domain" {
  description = "Designate zone the record is published into. Must be an existing zone and end with a trailing dot (e.g. \"example.com.\")."
  type        = string
  default     = "example.com."
}

variable "description" {
  description = "Human-readable description stored on the floating IP for inventory."
  type        = string
  default     = "Allocated by Terraform with DNS"
}

variable "tags" {
  description = "Tags applied to the floating IP for inventory and cost tracking."
  type        = list(string)
  default     = ["managed-by:terraform", "example:floating-ip-with-dns"]
}
