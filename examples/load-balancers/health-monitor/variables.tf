variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "lb_name" {
  description = "Name of the Octavia load balancer."
  type        = string
  default     = "example-health-monitor"
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

variable "backend_members" {
  description = "Backend member IP addresses, all reachable on subnet_name."
  type        = list(string)
  default     = ["10.0.0.11", "10.0.0.12"]
}

variable "monitor_url_path" {
  description = "HTTP path the monitor requests on each member (a dedicated health endpoint is recommended)."
  type        = string
  default     = "/healthz"
}

variable "monitor_http_method" {
  description = "HTTP method the monitor uses (GET, HEAD, ...)."
  type        = string
  default     = "GET"
}

variable "monitor_expected_codes" {
  description = "HTTP status code(s) considered healthy. Accepts a single code (\"200\"), a list (\"200,202\"), or a range (\"200-299\")."
  type        = string
  default     = "200"
}

variable "monitor_delay" {
  description = "Seconds between health checks."
  type        = number
  default     = 5
}

variable "monitor_timeout" {
  description = "Seconds to wait for a probe response (must be less than monitor_delay)."
  type        = number
  default     = 3
}

variable "monitor_max_retries" {
  description = "Successful probes before an OFFLINE member is marked healthy again."
  type        = number
  default     = 3
}

variable "monitor_max_retries_down" {
  description = "Failed probes before a healthy member is marked OFFLINE."
  type        = number
  default     = 3
}
