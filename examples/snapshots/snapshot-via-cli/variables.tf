variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "volume_id" {
  description = "UUID of the volume to snapshot."
  type        = string
}

variable "snapshot_name" {
  description = "Name to assign to the created volume snapshot."
  type        = string
  default     = "tf-snapshot"
}

variable "snapshot_description" {
  description = "Description applied to the created snapshot."
  type        = string
  default     = "Created by Terraform via CLI"
}

variable "force" {
  description = "Allow snapshotting an in-use (attached) volume. Produces only a crash-consistent snapshot."
  type        = bool
  default     = false
}
