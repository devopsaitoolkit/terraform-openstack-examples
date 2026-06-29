variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "volume_type_name" {
  description = "Name of the volume type intended for LUKS encryption."
  type        = string
  default     = "luks"
}

variable "volume_type_description" {
  description = "Human-readable description for the volume type."
  type        = string
  default     = "LUKS-encrypted volumes (encryption configured via CLI/Barbican)"
}

variable "extra_specs" {
  description = "Extra specs for the volume type (e.g. backend selection)."
  type        = map(string)
  default = {
    volume_backend_name = "lvmdriver-1"
  }
}

variable "volume_name" {
  description = "Name of the Cinder volume created from the encrypted type."
  type        = string
  default     = "example-encrypted-volume"
}

variable "volume_size" {
  description = "Size of the volume in GiB."
  type        = number
  default     = 10
}
