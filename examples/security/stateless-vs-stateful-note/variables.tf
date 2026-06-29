variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "secgroup_name" {
  description = "Name of the security group demonstrating stateful behaviour with egress lockdown."
  type        = string
  default     = "example-stateful"
}

variable "https_cidr" {
  description = "CIDR allowed inbound to HTTPS (443)."
  type        = string
  default     = "0.0.0.0/0"
}

variable "egress_https_cidr" {
  description = "Approved outbound HTTPS destination CIDR for egress lockdown."
  type        = string
  default     = "0.0.0.0/0"
}

variable "dns_resolver_cidr" {
  description = "Approved DNS resolver CIDR for outbound name resolution."
  type        = string
  default     = "10.0.0.2/32"
}

variable "tags" {
  description = "Tags applied to the security group."
  type        = list(string)
  default     = ["managed-by:terraform", "example:stateless-vs-stateful-note"]
}
