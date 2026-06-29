variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "secgroup_name" {
  description = "Name of the default-deny baseline security group."
  type        = string
  default     = "example-default-deny"
}

variable "dns_resolver_cidr" {
  description = "CIDR of the allowed DNS resolver(s) for outbound name resolution."
  type        = string
  default     = "10.0.0.2/32"
}

variable "egress_https_cidr" {
  description = "CIDR the workload is allowed to reach over HTTPS (e.g. a package mirror or API endpoint range)."
  type        = string
  default     = "0.0.0.0/0"
}

variable "tags" {
  description = "Tags applied to the security group."
  type        = list(string)
  default     = ["managed-by:terraform", "example:default-deny-baseline"]
}
