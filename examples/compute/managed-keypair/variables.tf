variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "keypair_name" {
  description = "Name for the managed key pair created in Nova."
  type        = string
  default     = "example-managed-keypair"
}

variable "public_key" {
  description = "Contents of the SSH public key to register (e.g. the text of ~/.ssh/id_ed25519.pub). The matching private key never leaves your machine."
  type        = string
}

variable "instance_name" {
  description = "Name of the compute instance."
  type        = string
  default     = "example-managed-keypair-instance"
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

variable "security_group_names" {
  description = "Security groups to attach to the instance."
  type        = list(string)
  default     = ["default"]
}

variable "tags" {
  description = "Tags applied to the instance for inventory and cost tracking."
  type        = list(string)
  default     = ["managed-by:terraform", "example:managed-keypair"]
}
