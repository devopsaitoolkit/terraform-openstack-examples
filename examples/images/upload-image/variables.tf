variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "image_name" {
  description = "Name of the Glance image to create."
  type        = string
  default     = "ubuntu-22.04-jammy"
}

variable "image_source_url" {
  description = "HTTP(S) URL of the cloud image to upload. Glance downloads it server-side when web_download is true, otherwise Terraform streams it. Default is the Ubuntu 22.04 (Jammy) cloud image."
  type        = string
  default     = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"
}

variable "disk_format" {
  description = "Disk format of the source image (qcow2, raw, vmdk, vdi, iso, etc.)."
  type        = string
  default     = "qcow2"
}

variable "container_format" {
  description = "Container format for the image. 'bare' is correct for plain disk images such as qcow2/raw."
  type        = string
  default     = "bare"
}

variable "min_disk_gb" {
  description = "Minimum root disk size (GB) a flavor must provide to boot this image. 0 disables the check."
  type        = number
  default     = 0
}

variable "min_ram_mb" {
  description = "Minimum RAM (MB) a flavor must provide to boot this image. 0 disables the check."
  type        = number
  default     = 0
}

variable "visibility" {
  description = "Image visibility: private, shared, community, or public (public usually requires admin)."
  type        = string
  default     = "private"
}

variable "web_download" {
  description = "When true, Glance fetches image_source_url itself (web-download import) instead of Terraform downloading and streaming the bytes. Requires the web-download import method to be enabled on the cloud."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags applied to the image for inventory and lifecycle tracking."
  type        = list(string)
  default     = ["managed-by:terraform", "example:upload-image"]
}
