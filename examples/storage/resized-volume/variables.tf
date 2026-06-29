variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "volume_name" {
  description = "Name of the Cinder volume."
  type        = string
  default     = "example-resizable-volume"
}

variable "volume_description" {
  description = "Human-readable description for the volume."
  type        = string
  default     = "Resizable volume managed by Terraform"
}

variable "volume_size" {
  description = "Size of the volume in GiB. Increase and re-apply to grow; Cinder cannot shrink a volume."
  type        = number
  default     = 10
}

variable "enable_online_resize" {
  description = "Allow the volume to grow while attached to a running instance. Set true only if the backend and Nova support online extend."
  type        = bool
  default     = false
}
