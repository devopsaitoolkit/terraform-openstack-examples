variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "volume_name" {
  description = "Name to assign to the Cinder volume that will be attached."
  type        = string
  default     = "example-data-volume"
}

variable "volume_size" {
  description = "Size of the volume in GiB."
  type        = number
  default     = 10
}

variable "instance_id" {
  description = "UUID of the existing Nova instance to attach the volume to."
  type        = string
}

variable "device" {
  description = "Optional device hint such as /dev/vdb. The guest kernel may not honour it."
  type        = string
  default     = ""
}
