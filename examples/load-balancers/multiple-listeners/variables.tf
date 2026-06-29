variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "lb_name" {
  description = "Name of the Octavia load balancer."
  type        = string
  default     = "example-multiple-listeners"
}

variable "subnet_name" {
  description = "Name of the subnet the VIP and members live on."
  type        = string
  default     = "private-subnet"
}

variable "http_port" {
  description = "TCP port for the plain HTTP listener."
  type        = number
  default     = 80
}

variable "https_port" {
  description = "TCP port for the HTTPS listener."
  type        = number
  default     = 443
}

variable "member_port" {
  description = "TCP port the backend members listen on."
  type        = number
  default     = 80
}

variable "backend_members" {
  description = "Backend member IP addresses, all reachable on subnet_name."
  type        = list(string)
  default     = ["10.0.0.11", "10.0.0.12"]
}

variable "default_tls_container_ref" {
  description = "Barbican container reference (cert + key + chain) for the HTTPS listener. See the tls-termination example for how to create it."
  type        = string
}
