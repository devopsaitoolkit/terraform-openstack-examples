variable "cloud_region1" {
  description = "clouds.yaml entry for region 1 (the default provider)."
  type        = string
  default     = "openstack"
}

variable "cloud_region2" {
  description = "clouds.yaml entry for region 2 (bound to the openstack.region2 alias)."
  type        = string
  default     = "openstack-region2"
}

variable "instance_name" {
  description = "Base name for the instances. The region suffix is appended."
  type        = string
  default     = "example-multiregion"
}

variable "flavor_name" {
  description = "Flavor (size) for the instances in both regions. Must exist in each cloud."
  type        = string
  default     = "m1.small"
}

variable "image_name" {
  description = "Glance image name to boot from in both regions. Must exist in each cloud."
  type        = string
  default     = "ubuntu-22.04"
}

variable "network_name" {
  description = "Name of an existing tenant network to attach to in each region (looked up per region)."
  type        = string
  default     = "private"
}

variable "key_pair_name" {
  description = "Name of an existing key pair present in BOTH regions. Leave empty to skip."
  type        = string
  default     = ""
}

variable "security_group_names" {
  description = "Security groups to attach to the instances in both regions."
  type        = list(string)
  default     = ["default"]
}

variable "tags" {
  description = "Tags applied to each instance for inventory and cost tracking."
  type        = list(string)
  default     = ["managed-by:terraform", "example:multi-region-instances"]
}
