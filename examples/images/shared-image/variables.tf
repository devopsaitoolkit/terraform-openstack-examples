variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "image_name" {
  description = "Name of the Glance image to create and share."
  type        = string
  default     = "ubuntu-22.04-shared"
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

variable "member_project_ids" {
  description = "List of project (tenant) UUIDs to grant access to the shared image. Each becomes an image membership that the member project must then accept."
  type        = list(string)
  default     = []
}

variable "member_status" {
  description = "Initial membership status to set for each member: 'pending', 'accepted', or 'rejected'. The image only appears in a member's list once accepted (the member normally accepts it themselves)."
  type        = string
  default     = "accepted"
}

variable "tags" {
  description = "Tags applied to the image for inventory and lifecycle tracking."
  type        = list(string)
  default     = ["managed-by:terraform", "example:shared-image"]
}
