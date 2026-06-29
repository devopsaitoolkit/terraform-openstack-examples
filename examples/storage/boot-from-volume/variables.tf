variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "instance_name" {
  description = "Name to assign to the booted instance."
  type        = string
  default     = "example-bfv"
}

variable "flavor_name" {
  description = "Nova flavor (size) for the instance."
  type        = string
  default     = "m1.small"
}

variable "image_name" {
  description = "Name of the Glance image to create the root volume from."
  type        = string
  default     = "ubuntu-22.04"
}

variable "network_name" {
  description = "Name of the Neutron network to attach the instance to."
  type        = string
  default     = "private"
}

variable "root_volume_size" {
  description = "Size of the bootable root volume in GiB."
  type        = number
  default     = 20
}

variable "delete_on_termination" {
  description = "Whether the root volume is deleted when the instance is destroyed. Set false to retain data."
  type        = bool
  default     = true
}

variable "key_pair_name" {
  description = "Optional Nova key pair name for SSH access. Empty for none."
  type        = string
  default     = ""
}

variable "security_group_names" {
  description = "Security groups to apply to the instance."
  type        = list(string)
  default     = ["default"]
}
