variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "volume_id" {
  description = "UUID of the volume the generated wrapper script will back up."
  type        = string
}

variable "script_path" {
  description = "Absolute path where the backup wrapper script will be written."
  type        = string
  default     = "/usr/local/bin/cinder-backup.sh"
}

variable "backup_name_prefix" {
  description = "Prefix for generated backup names; a timestamp is appended at run time."
  type        = string
  default     = "scheduled-backup"
}

variable "schedule" {
  description = "Cron expression documenting the intended schedule (documentation only; not applied by Terraform)."
  type        = string
  default     = "0 2 * * *"
}
