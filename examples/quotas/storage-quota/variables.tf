variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "project_id" {
  description = "ID of the EXISTING project (tenant) whose block storage quota will be set. Requires an admin-scoped token."
  type        = string
}

variable "volumes" {
  description = "Maximum number of volumes allowed in the project."
  type        = number
  default     = 20
}

variable "snapshots" {
  description = "Maximum number of volume snapshots allowed in the project."
  type        = number
  default     = 20
}

variable "gigabytes" {
  description = "Maximum total volume storage (in GB) allowed in the project."
  type        = number
  default     = 1000
}

variable "per_volume_gigabytes" {
  description = "Maximum size (in GB) of any single volume."
  type        = number
  default     = 200
}

variable "backups" {
  description = "Maximum number of volume backups allowed in the project."
  type        = number
  default     = 10
}

variable "backup_gigabytes" {
  description = "Maximum total backup storage (in GB) allowed in the project."
  type        = number
  default     = 1000
}
