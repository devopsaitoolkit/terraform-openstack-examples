variable "name" {
  description = "Name of the Octavia load balancer. Used as a prefix for the listener and pool."
  type        = string

  validation {
    condition     = length(var.name) > 0
    error_message = "The load balancer name must not be empty."
  }
}

variable "vip_subnet_id" {
  description = "ID of the subnet the load balancer's VIP is created on."
  type        = string

  validation {
    condition     = length(var.vip_subnet_id) > 0
    error_message = "vip_subnet_id must not be empty."
  }
}

variable "listener_protocol" {
  description = "Listener protocol (and pool protocol): HTTP, HTTPS, TCP, UDP, PROXY, etc."
  type        = string
  default     = "HTTP"

  validation {
    condition     = contains(["HTTP", "HTTPS", "TCP", "UDP", "PROXY", "PROXYV2", "SCTP", "TERMINATED_HTTPS"], var.listener_protocol)
    error_message = "listener_protocol must be a protocol supported by Octavia (e.g. HTTP, HTTPS, TCP, UDP)."
  }
}

variable "listener_port" {
  description = "TCP/UDP port the listener accepts traffic on."
  type        = number
  default     = 80

  validation {
    condition     = var.listener_port >= 1 && var.listener_port <= 65535
    error_message = "listener_port must be between 1 and 65535."
  }
}

variable "pool_method" {
  description = "Load balancing algorithm: ROUND_ROBIN, LEAST_CONNECTIONS, or SOURCE_IP."
  type        = string
  default     = "ROUND_ROBIN"

  validation {
    condition     = contains(["ROUND_ROBIN", "LEAST_CONNECTIONS", "SOURCE_IP", "SOURCE_IP_PORT"], var.pool_method)
    error_message = "pool_method must be one of: ROUND_ROBIN, LEAST_CONNECTIONS, SOURCE_IP, SOURCE_IP_PORT."
  }
}

variable "members" {
  description = <<-EOT
    Backend members for the pool. Each member needs an address, the
    protocol_port it listens on, and the subnet_id the address lives on.
  EOT
  type = list(object({
    address       = string
    protocol_port = number
    subnet_id     = string
  }))
  default = []
}

variable "monitor" {
  description = <<-EOT
    Optional health monitor. Set to null to skip health checking. url_path only
    applies to HTTP/HTTPS monitors. Example:
    { type = "HTTP", delay = 5, timeout = 3, max_retries = 3, url_path = "/healthz" }
  EOT
  type = object({
    type        = string
    delay       = number
    timeout     = number
    max_retries = number
    url_path    = optional(string)
  })
  default = null

  validation {
    condition     = var.monitor == null ? true : contains(["HTTP", "HTTPS", "PING", "TCP", "TLS-HELLO", "UDP-CONNECT", "SCTP"], var.monitor.type)
    error_message = "monitor.type must be one of: HTTP, HTTPS, PING, TCP, TLS-HELLO, UDP-CONNECT, SCTP."
  }
}

variable "tags" {
  description = "Tags applied to the load balancer."
  type        = list(string)
  default     = []
}
