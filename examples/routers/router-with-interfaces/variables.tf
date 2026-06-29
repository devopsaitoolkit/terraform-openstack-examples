variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "router_name" {
  description = "Name of the Neutron router."
  type        = string
  default     = "example-multi-subnet-router"
}

variable "external_network_name" {
  description = "Name of the external (public) network to use as the router's gateway. Looked up with a data source so no UUID is hard-coded."
  type        = string
  default     = "public"
}

variable "enable_snat" {
  description = "Enable source NAT on the gateway so attached subnets reach the internet."
  type        = bool
  default     = true
}

variable "subnet_ids" {
  description = "UUIDs of the existing subnets to attach to the router, one router interface per subnet. Find them with `openstack subnet list`."
  type        = set(string)
}

variable "tags" {
  description = "Tags applied to the router for inventory and cost tracking."
  type        = list(string)
  default     = ["managed-by:terraform", "example:router-with-interfaces"]
}
