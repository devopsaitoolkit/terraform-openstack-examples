variable "cloud_primary" {
  description = "clouds.yaml entry for the PRIMARY (active) region."
  type        = string
  default     = "openstack"
}

variable "cloud_standby" {
  description = "clouds.yaml entry for the STANDBY (passive/DR) region."
  type        = string
  default     = "openstack-region2"
}

variable "name_prefix" {
  description = "Prefix for all DR resources, e.g. <prefix>-primary-net."
  type        = string
  default     = "app-dr"
}

variable "subnet_cidr" {
  description = "CIDR used for the application subnet in BOTH regions (kept identical so failover needs no IP re-plumbing)."
  type        = string
  default     = "10.50.0.0/24"
}

variable "dns_nameservers" {
  description = "DNS resolvers handed out by DHCP on the application subnets."
  type        = list(string)
  default     = ["1.1.1.1", "8.8.8.8"]
}

variable "flavor_name" {
  description = "Flavor (size) for the application instances in both regions."
  type        = string
  default     = "m1.small"
}

variable "image_name" {
  description = "Glance image to boot from in both regions. Must exist in each cloud."
  type        = string
  default     = "ubuntu-22.04"
}

variable "key_pair_name" {
  description = "Existing key pair present in both regions. Leave empty to skip."
  type        = string
  default     = ""
}

variable "security_group_names" {
  description = "Security groups attached to instances in both regions."
  type        = list(string)
  default     = ["default"]
}

variable "primary_instance_count" {
  description = "Number of active instances in the primary region."
  type        = number
  default     = 2
}

variable "standby_instance_count" {
  description = "Number of standby instances in the DR region. Keep at 0 normally; raise to fail over."
  type        = number
  default     = 0
}

variable "tags" {
  description = "Base tags applied to all DR resources."
  type        = list(string)
  default     = ["managed-by:terraform", "example:active-passive-dr"]
}
