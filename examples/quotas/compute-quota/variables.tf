variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "project_id" {
  description = "ID of the EXISTING project (tenant) whose compute quota will be set. Requires an admin-scoped token."
  type        = string
}

variable "instances" {
  description = "Maximum number of server instances allowed in the project."
  type        = number
  default     = 10
}

variable "cores" {
  description = "Maximum number of server vCPU cores allowed in the project."
  type        = number
  default     = 20
}

variable "ram" {
  description = "Maximum amount of server RAM allowed in the project, in MB."
  type        = number
  default     = 51200
}

variable "key_pairs" {
  description = "Maximum number of key pairs allowed for the project."
  type        = number
  default     = 10
}

variable "metadata_items" {
  description = "Maximum number of metadata items allowed per server."
  type        = number
  default     = 128
}
