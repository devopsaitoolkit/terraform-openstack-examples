variable "name" {
  description = "Base name for the instance(s). When instance_count > 1 a 1-based index suffix is appended (e.g. web-1, web-2)."
  type        = string
}

variable "instance_count" {
  description = "Number of identical instances to create."
  type        = number
  default     = 1

  validation {
    condition     = var.instance_count >= 1
    error_message = "instance_count must be at least 1."
  }
}

variable "flavor_name" {
  description = "Name of the Nova flavor (size) for the instance(s), e.g. m1.small."
  type        = string
}

variable "image_name" {
  description = "Name of the Glance image to boot from."
  type        = string
}

variable "network_id" {
  description = "UUID of the tenant network to attach the instance(s) to."
  type        = string
}

variable "key_pair_name" {
  description = "Name of an existing OpenStack key pair to inject for SSH access. Leave empty to skip."
  type        = string
  default     = ""
}

variable "security_group_names" {
  description = "Names of the security groups to attach to the instance(s)."
  type        = list(string)
  default     = ["default"]
}

variable "metadata" {
  description = "Key/value metadata applied to each instance."
  type        = map(string)
  default     = {}
}

variable "user_data" {
  description = "Cloud-init user data (raw string) to pass to each instance. Leave empty to skip."
  type        = string
  default     = ""
}

variable "availability_zone" {
  description = "Availability zone to schedule the instance(s) in. Leave empty for the scheduler default."
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags applied to each instance for inventory and cost tracking."
  type        = list(string)
  default     = []
}
