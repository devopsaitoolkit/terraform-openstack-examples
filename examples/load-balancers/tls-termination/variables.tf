variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "lb_name" {
  description = "Name of the Octavia load balancer."
  type        = string
  default     = "example-tls-termination"
}

variable "subnet_name" {
  description = "Name of the subnet the VIP and members live on."
  type        = string
  default     = "private-subnet"
}

variable "https_port" {
  description = "TCP port the HTTPS listener accepts client traffic on."
  type        = number
  default     = 443
}

variable "member_port" {
  description = "TCP port the backend members listen on (plain HTTP after TLS is terminated at the LB)."
  type        = number
  default     = 80
}

variable "backend_members" {
  description = "Backend member IP addresses, all reachable on subnet_name."
  type        = list(string)
  default     = ["10.0.0.11", "10.0.0.12"]
}

variable "default_tls_container_ref" {
  description = "Barbican secret container reference holding the server certificate + private key (and chain). Looks like https://<barbican-host>:9311/v1/containers/<uuid>. Create it with `openstack secret store` / `openstack secret container create` before applying."
  type        = string
}

variable "sni_container_refs" {
  description = "Optional list of additional Barbican container references for SNI (serving multiple hostnames/certs on one listener). Leave empty for a single certificate."
  type        = list(string)
  default     = []
}
