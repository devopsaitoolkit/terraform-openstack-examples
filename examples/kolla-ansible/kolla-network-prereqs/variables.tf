variable "cloud" {
  description = "clouds.yaml entry to deploy the Kolla networks into."
  type        = string
  default     = "openstack"
}

variable "name_prefix" {
  description = "Prefix for all Kolla network resources, e.g. <prefix>-mgmt-net."
  type        = string
  default     = "kolla"
}

# --- Management network (Kolla 'network_interface' / API + internal traffic) ---
variable "management_cidr" {
  description = "CIDR for the Kolla management network (control-plane / API traffic)."
  type        = string
  default     = "10.10.0.0/24"
}

# --- Tunnel network (overlay / VXLAN tenant traffic, Kolla 'tunnel_interface') ---
variable "tunnel_cidr" {
  description = "CIDR for the Kolla tunnel/overlay network (VXLAN tenant traffic)."
  type        = string
  default     = "10.10.1.0/24"
}

# --- External / provider network (north-south, floating IPs) ---
variable "external_cidr" {
  description = "CIDR for the external/provider network (floating IPs, north-south traffic)."
  type        = string
  default     = "203.0.113.0/24"
}

variable "external_gateway_ip" {
  description = "Upstream gateway IP for the external/provider subnet."
  type        = string
  default     = "203.0.113.1"
}

variable "external_allocation_start" {
  description = "First address of the floating-IP allocation pool on the external subnet."
  type        = string
  default     = "203.0.113.10"
}

variable "external_allocation_end" {
  description = "Last address of the floating-IP allocation pool on the external subnet."
  type        = string
  default     = "203.0.113.250"
}

variable "external_physical_network" {
  description = "Neutron provider:physical_network for the external network (must match ml2_conf/bridge mapping)."
  type        = string
  default     = "physnet1"
}

variable "external_network_type" {
  description = "Neutron provider:network_type for the external network (flat or vlan typically)."
  type        = string
  default     = "flat"
}

variable "dns_nameservers" {
  description = "DNS resolvers handed out by DHCP on the management subnet."
  type        = list(string)
  default     = ["1.1.1.1", "8.8.8.8"]
}

variable "tags" {
  description = "Tags applied to all Kolla network resources."
  type        = list(string)
  default     = ["managed-by:terraform", "example:kolla-network-prereqs"]
}
