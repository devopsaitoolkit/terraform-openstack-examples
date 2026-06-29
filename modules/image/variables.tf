variable "name" {
  description = "Name of the Glance image."
  type        = string

  validation {
    condition     = length(var.name) > 0
    error_message = "The image name must not be empty."
  }
}

variable "image_source_url" {
  description = "HTTP(S) URL Glance downloads the image from (web download / copy-from)."
  type        = string

  validation {
    condition     = can(regex("^https?://", var.image_source_url))
    error_message = "image_source_url must be an http:// or https:// URL."
  }
}

variable "container_format" {
  description = "Container format of the image (bare, ovf, ova, aki, ari, ami)."
  type        = string
  default     = "bare"

  validation {
    condition     = contains(["bare", "ovf", "ova", "aki", "ari", "ami"], var.container_format)
    error_message = "container_format must be one of: bare, ovf, ova, aki, ari, ami."
  }
}

variable "disk_format" {
  description = "Disk format of the image (qcow2, raw, vmdk, vdi, iso, vhd, ami, aki, ari)."
  type        = string
  default     = "qcow2"

  validation {
    condition     = contains(["qcow2", "raw", "vmdk", "vdi", "iso", "vhd", "vhdx", "ami", "aki", "ari"], var.disk_format)
    error_message = "disk_format must be a Glance-supported disk format such as qcow2 or raw."
  }
}

variable "visibility" {
  description = "Image visibility: private, public, shared, or community."
  type        = string
  default     = "private"

  validation {
    condition     = contains(["private", "public", "shared", "community"], var.visibility)
    error_message = "visibility must be one of: private, public, shared, community."
  }
}

variable "protected" {
  description = "Whether the image is protected from deletion."
  type        = bool
  default     = false
}

variable "min_disk_gb" {
  description = "Minimum disk size (GB) required to boot the image. 0 means no minimum."
  type        = number
  default     = 0

  validation {
    condition     = var.min_disk_gb >= 0
    error_message = "min_disk_gb must be zero or greater."
  }
}

variable "min_ram_mb" {
  description = "Minimum RAM (MB) required to boot the image. 0 means no minimum."
  type        = number
  default     = 0

  validation {
    condition     = var.min_ram_mb >= 0
    error_message = "min_ram_mb must be zero or greater."
  }
}

variable "properties" {
  description = "Free-form image properties (e.g. os_distro, hw_disk_bus, architecture)."
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Tags applied to the image for inventory and lifecycle tracking."
  type        = list(string)
  default     = []
}
