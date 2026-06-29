variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "volume_type_name" {
  description = "Name of the multiattach-capable Cinder volume type to create (admin-only operation)."
  type        = string
  default     = "multiattach"
}

variable "volume_name" {
  description = "Name of the shared Cinder volume to create."
  type        = string
  default     = "example-shared-volume"
}

variable "volume_size" {
  description = "Size of the shared volume in GiB."
  type        = number
  default     = 10
}

variable "first_instance_id" {
  description = "ID of the first instance to attach the shared volume to."
  type        = string
}

variable "second_instance_id" {
  description = "ID of the second instance to attach the shared volume to."
  type        = string
}
