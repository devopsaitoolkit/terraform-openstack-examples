variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "name_prefix" {
  description = "Name prefix for the load balancer, pool, and web instances."
  type        = string
  default     = "web-tier"
}

variable "member_count" {
  description = "Number of backend web instances to register as pool members."
  type        = number
  default     = 3

  validation {
    condition     = var.member_count >= 1
    error_message = "member_count must be at least 1."
  }
}

variable "flavor_name" {
  description = "Name of the flavor (size) for each web instance."
  type        = string
  default     = "m1.small"
}

variable "image_name" {
  description = "Name of the Glance image to boot from. The bootstrap assumes a Debian/Ubuntu base."
  type        = string
  default     = "ubuntu-22.04"
}

variable "network_name" {
  description = "Name of the tenant network the web instances attach to."
  type        = string
  default     = "private"
}

variable "subnet_name" {
  description = "Name of the subnet (inside network_name) used for the load balancer VIP and for pool member addressing."
  type        = string
  default     = "private-subnet"
}

variable "key_pair_name" {
  description = "Name of an existing OpenStack key pair to inject for SSH access. Leave empty to skip."
  type        = string
  default     = ""
}

variable "security_group_names" {
  description = "Security groups to attach to each web instance (must allow the listener port from the load balancer)."
  type        = list(string)
  default     = ["default"]
}

variable "listener_port" {
  description = "Port the load balancer listens on for client traffic."
  type        = number
  default     = 80
}

variable "member_port" {
  description = "Port the web instances serve on (where the pool sends traffic)."
  type        = number
  default     = 80
}

variable "lb_method" {
  description = "Load balancing algorithm for the pool: ROUND_ROBIN, LEAST_CONNECTIONS, or SOURCE_IP."
  type        = string
  default     = "ROUND_ROBIN"

  validation {
    condition     = contains(["ROUND_ROBIN", "LEAST_CONNECTIONS", "SOURCE_IP"], var.lb_method)
    error_message = "lb_method must be ROUND_ROBIN, LEAST_CONNECTIONS, or SOURCE_IP."
  }
}

variable "health_monitor_url" {
  description = "URL path the HTTP health monitor requests on each member."
  type        = string
  default     = "/"
}

variable "tags" {
  description = "Tags applied to every web instance for inventory and cost tracking."
  type        = list(string)
  default     = ["managed-by:terraform", "example:lb-backed-web-tier", "role:web"]
}
