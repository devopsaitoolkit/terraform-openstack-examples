variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "image_name" {
  description = "Name of the Glance image to look up and use as the volume source."
  type        = string
  default     = "ubuntu-22.04"
}

variable "volume_name" {
  description = "Name of the Cinder volume to create."
  type        = string
  default     = "example-image-volume"
}

variable "volume_size" {
  description = "Size of the volume in GiB. Must be >= the image's minimum disk size."
  type        = number
  default     = 20
}
