variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "name_prefix" {
  description = "Name prefix for the server group and its members; instances are <prefix>-0, <prefix>-1, ..."
  type        = string
  default     = "ha-node"
}

variable "instance_count" {
  description = "Number of instances to spread across distinct hypervisors."
  type        = number
  default     = 3

  validation {
    condition     = var.instance_count >= 2
    error_message = "Anti-affinity only makes sense with 2 or more instances."
  }
}

variable "affinity_policy" {
  description = "Server group placement policy. 'anti-affinity' forces distinct hosts (apply fails if there are too few hosts); 'soft-anti-affinity' spreads best-effort and never blocks scheduling."
  type        = string
  default     = "anti-affinity"

  validation {
    condition     = contains(["anti-affinity", "soft-anti-affinity"], var.affinity_policy)
    error_message = "affinity_policy must be 'anti-affinity' or 'soft-anti-affinity'."
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
  description = "Tags applied to every instance for inventory and cost tracking."
  type        = list(string)
  default     = ["managed-by:terraform", "example:anti-affinity-instances", "role:ha"]
}
