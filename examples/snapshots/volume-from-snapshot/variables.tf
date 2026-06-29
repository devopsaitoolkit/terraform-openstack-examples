variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "volume_name" {
  description = "Name for the new volume restored from the snapshot."
  type        = string
  default     = "restored-volume"
}

variable "volume_description" {
  description = "Description applied to the restored volume."
  type        = string
  default     = "Restored from snapshot by Terraform"
}

variable "volume_size" {
  description = "Size of the restored volume in GiB. Must be >= the source snapshot size."
  type        = number
  default     = 10
}

variable "snapshot_id" {
  description = "UUID of the source volume snapshot to restore from."
  type        = string
}
