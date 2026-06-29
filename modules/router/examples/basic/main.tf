variable "cloud" {
  description = "Name of the clouds.yaml entry to authenticate with."
  type        = string
  default     = "openstack"
}

variable "external_network_id" {
  description = "ID of the external/public network providing the gateway."
  type        = string
}

variable "subnet_ids" {
  description = "Tenant subnet IDs to attach to the router."
  type        = list(string)
  default     = []
}

module "router" {
  source = "../.."

  name                = "edge-router"
  external_network_id = var.external_network_id
  enable_snat         = true
  subnet_ids          = var.subnet_ids
}
