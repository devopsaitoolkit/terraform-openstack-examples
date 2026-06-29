variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "image_name" {
  description = "Name of the Glance image to create."
  type        = string
  default     = "ubuntu-22.04-tuned"
}

variable "image_source_url" {
  description = "HTTP(S) URL of the cloud image to upload."
  type        = string
  default     = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"
}

variable "disk_format" {
  description = "Disk format of the source image."
  type        = string
  default     = "qcow2"
}

variable "container_format" {
  description = "Container format for the image ('bare' for plain disk images)."
  type        = string
  default     = "bare"
}

variable "web_download" {
  description = "When true, Glance fetches image_source_url itself instead of Terraform streaming it."
  type        = bool
  default     = true
}

# Glance metadata properties drive scheduling and guest hardware behavior. These
# keys are the common, well-known ones; values must match what Nova/libvirt and
# your cloud's metadefs accept.
variable "properties" {
  description = "Map of Glance image metadata properties (os_distro, hw_disk_bus, hw_scsi_model, architecture, etc.). These influence guest hardware and scheduling."
  type        = map(string)
  default = {
    os_distro     = "ubuntu"
    architecture  = "x86_64"
    hw_disk_bus   = "scsi"
    hw_scsi_model = "virtio-scsi"
  }
}

variable "min_disk_gb" {
  description = "Minimum root disk size (GB) a flavor must provide to boot this image."
  type        = number
  default     = 8
}

variable "min_ram_mb" {
  description = "Minimum RAM (MB) a flavor must provide to boot this image."
  type        = number
  default     = 512
}

variable "tags" {
  description = "Tags applied to the image for inventory and lifecycle tracking."
  type        = list(string)
  default     = ["managed-by:terraform", "example:image-with-properties"]
}
