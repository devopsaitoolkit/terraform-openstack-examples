variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "instance_name" {
  description = "Name of the compute instance."
  type        = string
  default     = "example-boot-from-volume"
}

variable "flavor_name" {
  description = "Name of the flavor (size) for the instance, e.g. m1.small."
  type        = string
  default     = "m1.small"
}

variable "image_name" {
  description = "Name of the Glance image used to create the root volume."
  type        = string
  default     = "ubuntu-22.04"
}

variable "volume_size" {
  description = "Size of the bootable root volume, in GB."
  type        = number
  default     = 20

  validation {
    condition     = var.volume_size >= 1
    error_message = "volume_size must be at least 1 GB."
  }
}

variable "volume_type" {
  description = "Cinder volume type for the root volume (e.g. ssd). Leave empty to use the cloud default."
  type        = string
  default     = ""
}

variable "network_name" {
  description = "Name of the tenant network to attach the instance to."
  type        = string
  default     = "private"
}

variable "key_pair_name" {
  description = "Name of an existing OpenStack key pair to inject for SSH access. Leave empty to skip."
  type        = string
  default     = ""
}

variable "security_group_names" {
  description = "Security groups to attach to the instance."
  type        = list(string)
  default     = ["default"]
}

variable "tags" {
  description = "Tags applied to the instance for inventory and cost tracking."
  type        = list(string)
  default     = ["managed-by:terraform", "example:boot-from-volume"]
}
