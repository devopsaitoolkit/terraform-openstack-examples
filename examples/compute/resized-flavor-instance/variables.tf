variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "instance_name" {
  description = "Name of the compute instance."
  type        = string
  default     = "example-resized-flavor-instance"
}

variable "flavor_vcpus" {
  description = "Number of vCPUs to match. The flavor data source resolves the smallest flavor with at least this many vCPUs and the requested RAM."
  type        = number
  default     = 2
}

variable "flavor_ram" {
  description = "Amount of RAM in MB to match when resolving the flavor (e.g. 4096 for 4 GB)."
  type        = number
  default     = 4096
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

variable "tags" {
  description = "Tags applied to the instance for inventory and cost tracking."
  type        = list(string)
  default     = ["managed-by:terraform", "example:resized-flavor-instance"]
}
