variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "project_id" {
  description = "ID of the EXISTING project (tenant) whose network quota will be set. Requires an admin-scoped token."
  type        = string
}

variable "network" {
  description = "Maximum number of networks allowed in the project."
  type        = number
  default     = 10
}

variable "subnet" {
  description = "Maximum number of subnets allowed in the project."
  type        = number
  default     = 10
}

variable "port" {
  description = "Maximum number of ports allowed in the project."
  type        = number
  default     = 50
}

variable "router" {
  description = "Maximum number of routers allowed in the project."
  type        = number
  default     = 10
}

variable "floatingip" {
  description = "Maximum number of floating IPs allowed in the project."
  type        = number
  default     = 10
}

variable "security_group" {
  description = "Maximum number of security groups allowed in the project."
  type        = number
  default     = 10
}

variable "security_group_rule" {
  description = "Maximum number of security group rules allowed in the project."
  type        = number
  default     = 100
}
