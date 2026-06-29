variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "lb_name" {
  description = "Name of the Octavia load balancer."
  type        = string
  default     = "example-octavia-basic"
}

variable "subnet_name" {
  description = "Name of the subnet the load balancer VIP and members live on."
  type        = string
  default     = "private-subnet"
}

variable "listener_port" {
  description = "TCP port the HTTP listener accepts client traffic on."
  type        = number
  default     = 80
}

variable "member_a_address" {
  description = "IP address of the first backend member (must be reachable on subnet_name)."
  type        = string
  default     = "10.0.0.11"
}

variable "member_b_address" {
  description = "IP address of the second backend member (must be reachable on subnet_name)."
  type        = string
  default     = "10.0.0.12"
}

variable "member_port" {
  description = "TCP port the backend members listen on."
  type        = number
  default     = 80
}

variable "monitor_url_path" {
  description = "HTTP path the health monitor requests against each member."
  type        = string
  default     = "/"
}
