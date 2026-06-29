variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "router_name" {
  description = "Name of the Neutron router."
  type        = string
  default     = "example-no-snat-router"
}

variable "external_network_name" {
  description = "Name of the external network to use as the router's gateway. With SNAT disabled this is typically a routed/provider network whose addresses are advertised upstream. Looked up with a data source so no UUID is hard-coded."
  type        = string
  default     = "provider"
}

variable "enable_snat" {
  description = "Source NAT on the gateway. Disabled here so internal addresses are preserved end-to-end (no masquerading). Requires that the upstream fabric has routes back to the internal subnets."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags applied to the router for inventory and cost tracking."
  type        = list(string)
  default     = ["managed-by:terraform", "example:router-no-snat"]
}
