variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "lb_name" {
  description = "Name of the Octavia load balancer."
  type        = string
  default     = "example-l7-routing"
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
  default     = 80
}

variable "web_members" {
  description = "Backend IPs for the default (web) pool that serves everything not matched by an L7 rule."
  type        = list(string)
  default     = ["10.0.0.11", "10.0.0.12"]
}

variable "api_members" {
  description = "Backend IPs for the API pool that serves requests matching the path prefix."
  type        = list(string)
  default     = ["10.0.0.21", "10.0.0.22"]
}

variable "api_path_prefix" {
  description = "URL path prefix routed to the API pool (matched with STARTS_WITH)."
  type        = string
  default     = "/api"
}
