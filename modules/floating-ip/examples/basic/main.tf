variable "cloud" {
  description = "Name of the clouds.yaml entry to authenticate with."
  type        = string
  default     = "openstack"
}

variable "port_ids" {
  description = "Optional Neutron port IDs to associate the floating IPs with."
  type        = list(string)
  default     = []
}

module "floating_ip" {
  source = "../.."

  pool        = "public"
  fip_count   = 2
  description = "managed-by:terraform example"
  port_ids    = var.port_ids
}
