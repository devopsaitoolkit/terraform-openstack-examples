variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "trunk_name" {
  description = "Name of the trunk that bundles the parent port and its VLAN sub-ports."
  type        = string
  default     = "example-trunk"
}

variable "parent_cidr" {
  description = "CIDR range for the parent network's subnet (carries the trunk's native/untagged traffic)."
  type        = string
  default     = "10.70.0.0/24"
}

variable "sub1_cidr" {
  description = "CIDR range for the first sub-port network's subnet (VLAN-tagged traffic)."
  type        = string
  default     = "10.70.1.0/24"
}

variable "sub2_cidr" {
  description = "CIDR range for the second sub-port network's subnet (VLAN-tagged traffic)."
  type        = string
  default     = "10.70.2.0/24"
}

variable "sub1_seg_id" {
  description = "VLAN segmentation ID presented to the guest for the first sub-port."
  type        = number
  default     = 101
}

variable "sub2_seg_id" {
  description = "VLAN segmentation ID presented to the guest for the second sub-port."
  type        = number
  default     = 102
}
