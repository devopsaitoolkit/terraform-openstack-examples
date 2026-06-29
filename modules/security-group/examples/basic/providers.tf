variable "cloud" {
  description = "Name of the clouds.yaml entry to use for authentication."
  type        = string
  default     = "openstack"
}

provider "openstack" {
  cloud = var.cloud
}
