variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "external_network_name" {
  description = "Name of the existing external (provider) network used as the router gateway."
  type        = string
  default     = "public"
}

variable "router_name" {
  description = "Name of the router to create."
  type        = string
  default     = "example-router"
}

variable "network_name" {
  description = "Name of the tenant network to create and attach to the router."
  type        = string
  default     = "example-network"
}

variable "subnet_name" {
  description = "Name of the subnet to create on the tenant network."
  type        = string
  default     = "example-subnet"
}

variable "cidr" {
  description = "CIDR range for the tenant subnet."
  type        = string
  default     = "10.20.0.0/24"
}
