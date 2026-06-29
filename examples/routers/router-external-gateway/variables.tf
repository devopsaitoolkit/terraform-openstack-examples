variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "router_name" {
  description = "Name of the Neutron router."
  type        = string
  default     = "example-edge-router"
}

variable "external_network_name" {
  description = "Name of the external (public) network to use as the router's gateway. Looked up with a data source so no UUID is hard-coded."
  type        = string
  default     = "public"
}

variable "admin_state_up" {
  description = "Administrative state of the router. Set false to provision it disabled."
  type        = bool
  default     = true
}

variable "enable_snat" {
  description = "Enable source NAT on the gateway so instances on internal subnets reach the internet via the router. Keep true for standard NAT routers."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags applied to the router for inventory and cost tracking."
  type        = list(string)
  default     = ["managed-by:terraform", "example:router-external-gateway"]
}
