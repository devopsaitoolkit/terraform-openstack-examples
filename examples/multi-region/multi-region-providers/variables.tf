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

variable "network_name" {
  description = "Base name for the per-region networks. The region suffix is appended."
  type        = string
  default     = "example-multiregion"
}

variable "tags" {
  description = "Tags applied to each network for inventory and cost tracking."
  type        = list(string)
  default     = ["managed-by:terraform", "example:multi-region-providers"]
}
