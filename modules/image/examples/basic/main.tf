variable "cloud" {
  description = "Name of the clouds.yaml entry to authenticate with."
  type        = string
  default     = "openstack"
}

module "image" {
  source = "../.."

  name             = "ubuntu-22.04-cloud"
  image_source_url = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"
  container_format = "bare"
  disk_format      = "qcow2"
  visibility       = "private"
  min_disk_gb      = 5
  min_ram_mb       = 512

  properties = {
    os_distro  = "ubuntu"
    os_version = "22.04"
  }

  tags = ["managed-by:terraform", "example:image"]
}
