variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "lb_name" {
  description = "Name of the Octavia load balancer."
  type        = string
  default     = "example-listener-pool-members"
}

variable "subnet_name" {
  description = "Name of the subnet the VIP and members live on."
  type        = string
  default     = "private-subnet"
}

variable "listener_port" {
  description = "TCP port the HTTP listener accepts client traffic on."
  type        = number
  default     = 80
}

variable "member_port" {
  description = "TCP port the backend members listen on."
  type        = number
  default     = 8080
}

variable "backend_members" {
  description = "List of backend member IP addresses. Members are created with for_each, so adding or removing an IP only touches that one member."
  type        = list(string)
  default     = ["10.0.0.11", "10.0.0.12", "10.0.0.13"]
}
