variable "name" {
  description = "Base name for the volume(s). When volume_count > 1 a 1-based index suffix is appended (e.g. data-1, data-2)."
  type        = string
}

variable "size" {
  description = "Size of each volume in gigabytes."
  type        = number

  validation {
    condition     = var.size >= 1
    error_message = "size must be at least 1 GB."
  }
}

variable "volume_count" {
  description = "Number of identical volumes to create. (Named volume_count because \"count\" is a reserved variable name.)"
  type        = number
  default     = 1

  validation {
    condition     = var.volume_count >= 1
    error_message = "volume_count must be at least 1."
  }
}

variable "volume_type" {
  description = "Cinder volume type. Leave empty to use the cloud's default type."
  type        = string
  default     = ""
}

variable "availability_zone" {
  description = "Availability zone for the volume(s). Leave empty for the default."
  type        = string
  default     = ""
}

variable "metadata" {
  description = "Key/value metadata applied to each volume."
  type        = map(string)
  default     = {}
}

variable "attach_to_instance_id" {
  description = "If set, every created volume is attached to this instance UUID. Leave empty to create unattached volumes."
  type        = string
  default     = ""
}
