variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "router_name" {
  description = "Name of the Neutron router."
  type        = string
  default     = "example-static-routes-router"
}

variable "external_network_name" {
  description = "Name of the external (public) network to use as the router's gateway. Looked up with a data source so no UUID is hard-coded."
  type        = string
  default     = "public"
}

variable "enable_snat" {
  description = "Enable source NAT on the gateway."
  type        = bool
  default     = true
}

variable "routes" {
  description = "Static routes to add to the router. Map of a logical key to an object with the destination CIDR and the next-hop IP (which must be reachable on a subnet the router is attached to)."
  type = map(object({
    destination_cidr = string
    next_hop         = string
  }))
  default = {
    onprem = {
      destination_cidr = "10.100.0.0/16"
      next_hop         = "192.168.0.254"
    }
    mgmt = {
      destination_cidr = "172.16.0.0/12"
      next_hop         = "192.168.0.253"
    }
  }
}

variable "tags" {
  description = "Tags applied to the router for inventory and cost tracking."
  type        = list(string)
  default     = ["managed-by:terraform", "example:router-static-routes"]
}
