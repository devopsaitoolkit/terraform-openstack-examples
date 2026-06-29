variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "volume_id" {
  description = "UUID of the volume to back up."
  type        = string
}

variable "backup_name" {
  description = "Name to assign to the created backup."
  type        = string
  default     = "tf-backup"
}

variable "backup_description" {
  description = "Description applied to the created backup."
  type        = string
  default     = "Created by Terraform via CLI"
}

variable "incremental" {
  description = "Create an incremental backup. Requires a prior full backup of the same volume."
  type        = bool
  default     = false
}

variable "force" {
  description = "Allow backing up an in-use (attached) volume."
  type        = bool
  default     = true
}
