variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "floating_ip_pool" {
  description = "Name of the external network/pool that provides floating IPs."
  type        = string
  default     = "public"
}

variable "network_name" {
  description = "Name of the tenant network to create."
  type        = string
  default     = "fip-demo-net"
}

variable "subnet_name" {
  description = "Name of the subnet to create on the tenant network."
  type        = string
  default     = "fip-demo-subnet"
}

variable "cidr" {
  description = "CIDR range for the tenant subnet."
  type        = string
  default     = "10.90.0.0/24"
}
