variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "volume_name" {
  description = "Name to assign to the Cinder volume."
  type        = string
  default     = "example-volume"
}

variable "volume_description" {
  description = "Human-readable description stored on the volume."
  type        = string
  default     = "Managed by Terraform"
}

variable "volume_size" {
  description = "Size of the volume in GiB."
  type        = number
  default     = 10
}

variable "volume_type" {
  description = "Cinder volume type. Leave empty to use the backend default."
  type        = string
  default     = ""
}

variable "metadata" {
  description = "Key/value metadata attached to the volume for inventory and tracking."
  type        = map(string)
  default = {
    "managed-by" = "terraform"
  }
}
