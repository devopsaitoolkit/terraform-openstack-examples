variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "instance_name" {
  description = "Name of the compute instance."
  type        = string
  default     = "example-instance-with-floating-ip"
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

variable "floating_ip_pool" {
  description = "Name of the external network (pool) to allocate the floating IP from."
  type        = string
  default     = "public"
}

variable "security_group_ids" {
  description = "Security group IDs to apply to the port. The port (not the instance) carries the security groups when using an explicit port."
  type        = list(string)
  default     = []
}

variable "key_pair_name" {
  description = "Name of an existing OpenStack key pair to inject for SSH access. Leave empty to skip."
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags applied to the instance, port, and floating IP for inventory and cost tracking."
  type        = list(string)
  default     = ["managed-by:terraform", "example:instance-with-floating-ip"]
}
