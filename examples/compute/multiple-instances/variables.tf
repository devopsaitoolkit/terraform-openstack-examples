variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "instance_count" {
  description = "How many identical instances to create."
  type        = number
  default     = 3

  validation {
    condition     = var.instance_count > 0
    error_message = "instance_count must be at least 1."
  }
}

variable "instance_name_prefix" {
  description = "Prefix for instance names; each instance is suffixed with its index (e.g. web-1, web-2)."
  type        = string
  default     = "web"
}

variable "flavor_name" {
  description = "Name of the flavor (size) for each instance, e.g. m1.small."
  type        = string
  default     = "m1.small"
}

variable "image_name" {
  description = "Name of the Glance image to boot from."
  type        = string
  default     = "ubuntu-22.04"
}

variable "network_name" {
  description = "Name of the tenant network to attach each instance to."
  type        = string
  default     = "private"
}

variable "key_pair_name" {
  description = "Name of an existing OpenStack key pair to inject for SSH access. Leave empty to skip."
  type        = string
  default     = ""
}

variable "security_group_names" {
  description = "Security groups to attach to each instance."
  type        = list(string)
  default     = ["default"]
}

variable "tags" {
  description = "Tags applied to each instance for inventory and cost tracking."
  type        = list(string)
  default     = ["managed-by:terraform", "example:multiple-instances"]
}
