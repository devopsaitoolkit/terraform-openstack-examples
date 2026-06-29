variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "name_prefix" {
  description = "Prefix for the server group and instance names; instances are suffixed with their index."
  type        = string
  default     = "example-aa"
}

variable "instance_count" {
  description = "Number of instances to spread across distinct hosts via the anti-affinity group."
  type        = number
  default     = 2
}

variable "flavor_name" {
  description = "Name of the flavor (size) for the instances, e.g. m1.small."
  type        = string
  default     = "m1.small"
}

variable "image_name" {
  description = "Name of the Glance image to boot from."
  type        = string
  default     = "ubuntu-22.04"
}

variable "network_name" {
  description = "Name of the tenant network to attach the instances to."
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
  default     = ["managed-by:terraform", "example:server-group-anti-affinity"]
}
