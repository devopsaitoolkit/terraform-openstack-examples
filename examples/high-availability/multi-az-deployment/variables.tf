variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "instance_name_prefix" {
  description = "Name prefix; each instance is named <prefix>-<az>."
  type        = string
  default     = "ha-app"
}

variable "availability_zones" {
  description = "Nova availability zones to spread instances across (one instance per zone). Run `openstack availability zone list` to see what your cloud offers."
  type        = list(string)
  default     = ["az1", "az2", "az3"]

  validation {
    condition     = length(var.availability_zones) >= 2
    error_message = "Provide at least two availability zones for a multi-AZ HA deployment."
  }
}

variable "flavor_name" {
  description = "Name of the flavor (size) for each instance."
  type        = string
  default     = "m1.small"
}

variable "image_name" {
  description = "Name of the Glance image to boot from."
  type        = string
  default     = "ubuntu-22.04"
}

variable "network_name" {
  description = "Name of the single tenant network all instances share (one network, many zones)."
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
  description = "Tags applied to every instance for inventory and cost tracking."
  type        = list(string)
  default     = ["managed-by:terraform", "example:multi-az-deployment", "role:ha"]
}
