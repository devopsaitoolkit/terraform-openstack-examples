variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "volume_type_name" {
  description = "Name of the Cinder volume type to create (admin-only operation)."
  type        = string
  default     = "ssd"
}

variable "volume_type_description" {
  description = "Human-readable description of the volume type."
  type        = string
  default     = "SSD-backed volumes"
}

variable "is_public" {
  description = "Whether the volume type is visible to all tenants (true) or private (false)."
  type        = bool
  default     = true
}

variable "extra_specs" {
  description = "Backend scheduling hints passed to the Cinder scheduler (e.g. volume_backend_name)."
  type        = map(string)
  default = {
    "volume_backend_name" = "lvmdriver-1"
  }
}

variable "volume_name" {
  description = "Name of the Cinder volume to create using the volume type."
  type        = string
  default     = "example-ssd-volume"
}

variable "volume_size" {
  description = "Size of the volume in GiB."
  type        = number
  default     = 10
}
