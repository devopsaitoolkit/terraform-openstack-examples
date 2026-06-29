variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "instance_id" {
  description = "UUID of the Nova instance to snapshot into a Glance image."
  type        = string
}

variable "image_name" {
  description = "Name to assign to the resulting Glance image."
  type        = string
  default     = "tf-instance-snapshot"
}

variable "wait" {
  description = "Block until the image becomes active before returning."
  type        = bool
  default     = true
}
