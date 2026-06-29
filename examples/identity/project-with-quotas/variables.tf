variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use. Setting quotas requires an ADMIN-scoped credential."
  type        = string
  default     = "openstack"
}

variable "project_name" {
  description = "Name of the project to create and apply quotas to."
  type        = string
  default     = "example-quota-project"
}

variable "project_description" {
  description = "Human-readable description of the project."
  type        = string
  default     = "Project with compute and network quotas managed by Terraform."
}

variable "domain_id" {
  description = "ID of the pre-existing domain to create the project in. 'default' is the built-in Keystone domain."
  type        = string
  default     = "default"
}

# --- Compute (Nova) quotas ---
variable "compute_instances" {
  description = "Max number of instances in the project."
  type        = number
  default     = 10
}

variable "compute_cores" {
  description = "Max number of vCPUs in the project."
  type        = number
  default     = 20
}

variable "compute_ram_mb" {
  description = "Max total RAM in megabytes."
  type        = number
  default     = 51200
}

variable "compute_key_pairs" {
  description = "Max number of key pairs."
  type        = number
  default     = 50
}

# --- Network (Neutron) quotas ---
variable "network_count" {
  description = "Max number of networks."
  type        = number
  default     = 5
}

variable "subnet_count" {
  description = "Max number of subnets."
  type        = number
  default     = 10
}

variable "port_count" {
  description = "Max number of ports."
  type        = number
  default     = 100
}

variable "router_count" {
  description = "Max number of routers."
  type        = number
  default     = 3
}

variable "floatingip_count" {
  description = "Max number of floating IPs."
  type        = number
  default     = 10
}

variable "security_group_count" {
  description = "Max number of security groups."
  type        = number
  default     = 10
}
