variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "instance_name" {
  description = "Name of the compute instance."
  type        = string
  default     = "example-instance-metadata"
}

variable "flavor_name" {
  description = "Name of the flavor (size) for the instance, e.g. m1.small."
  type        = string
  default     = "m1.small"
}

variable "image_name" {
  description = "Name of the Glance image to boot from."
  type        = string
  default     = "ubuntu-22.04"
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

variable "metadata" {
  description = "Key/value metadata attached to the instance. Readable from the Nova metadata service and useful for inventory, ownership and automation."
  type        = map(string)
  default = {
    role        = "web"
    environment = "dev"
    owner       = "platform-team"
    cost-center = "1234"
    backup      = "daily"
  }
}

variable "tags" {
  description = "Tags applied to the instance for inventory and cost tracking."
  type        = list(string)
  default     = ["managed-by:terraform", "example:instance-metadata"]
}
