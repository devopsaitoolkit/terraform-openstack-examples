variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument). Must map to admin credentials."
  type        = string
  default     = "openstack"
}

variable "network_name" {
  description = "Name of the VLAN provider network to create."
  type        = string
  default     = "example-vlan-network"
}

variable "subnet_name" {
  description = "Name of the subnet to create on the VLAN network."
  type        = string
  default     = "example-vlan-subnet"
}

variable "cidr" {
  description = "CIDR range for the subnet."
  type        = string
  default     = "10.40.0.0/24"
}

variable "physical_network" {
  description = "Name of the physical network bridge mapping configured on the hosts (e.g. physnet1)."
  type        = string
  default     = "physnet1"
}

variable "vlan_id" {
  description = "802.1Q VLAN tag (segmentation_id) for the provider segment."
  type        = number
  default     = 100
}

variable "dns_nameservers" {
  description = "DNS resolvers handed to instances via DHCP."
  type        = list(string)
  default     = ["1.1.1.1"]
}
