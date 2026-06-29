variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument). Must map to admin credentials."
  type        = string
  default     = "openstack"
}

variable "network_name" {
  description = "Name of the provider network to create."
  type        = string
  default     = "example-provider-network"
}

variable "subnet_name" {
  description = "Name of the subnet to create on the provider network."
  type        = string
  default     = "example-provider-subnet"
}

variable "cidr" {
  description = "CIDR range for the subnet."
  type        = string
  default     = "10.30.0.0/24"
}

variable "network_type" {
  description = "Provider segment network type (e.g. flat or vlan)."
  type        = string
  default     = "flat"
}

variable "physical_network" {
  description = "Name of the physical network bridge mapping configured on the hosts (e.g. physnet1)."
  type        = string
  default     = "physnet1"
}

variable "segmentation_id" {
  description = "Segmentation ID for the segment. Flat networks ignore this value; set it for vlan/vxlan types."
  type        = number
  default     = 0
}
