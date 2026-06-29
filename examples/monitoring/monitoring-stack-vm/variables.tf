variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "instance_name" {
  description = "Name of the monitoring-stack instance."
  type        = string
  default     = "monitoring-stack"
}

variable "flavor_name" {
  description = "Flavor (size) for the monitoring VM. Prometheus + Grafana need RAM and CPU headroom; default to a larger flavor."
  type        = string
  default     = "m1.large"
}

variable "image_name" {
  description = "Name of the Glance image to boot from. The bootstrap assumes a Debian/Ubuntu base."
  type        = string
  default     = "ubuntu-22.04"
}

variable "network_name" {
  description = "Name of the tenant network to attach the instance to."
  type        = string
  default     = "private"
}

variable "key_pair_name" {
  description = "Name of an existing OpenStack key pair to inject for SSH access. Leave empty to skip."
  type        = string
  default     = ""
}

variable "monitoring_cidr" {
  description = "CIDR allowed to reach Prometheus on port 9090. Scope to operators/admins, not the public internet."
  type        = string
  default     = "10.0.0.0/24"

  validation {
    condition     = var.monitoring_cidr != "0.0.0.0/0"
    error_message = "Refusing 0.0.0.0/0 for Prometheus (9090): it has no auth by default and must be restricted."
  }
}

variable "grafana_cidr" {
  description = "CIDR allowed to reach Grafana on port 3000. Restrict to your operators' network or VPN."
  type        = string
  default     = "10.0.0.0/24"
}

variable "prometheus_port" {
  description = "Port Prometheus listens on."
  type        = number
  default     = 9090
}

variable "grafana_port" {
  description = "Port Grafana listens on."
  type        = number
  default     = 3000
}

variable "tsdb_volume_size" {
  description = "Size in GiB of the Cinder volume for the Prometheus TSDB (mounted at /var/lib/prometheus)."
  type        = number
  default     = 100
}

variable "tsdb_volume_type" {
  description = "Cinder volume type for the TSDB volume. Empty uses the project default type."
  type        = string
  default     = ""
}

variable "tsdb_device" {
  description = "Guest device path the TSDB volume is expected to appear at (used by the bootstrap to format/mount it)."
  type        = string
  default     = "/dev/vdb"
}

variable "prometheus_version" {
  description = "Version of Prometheus to install (without the leading 'v')."
  type        = string
  default     = "2.53.0"
}

variable "security_group_name" {
  description = "Name for the security group fronting the monitoring stack."
  type        = string
  default     = "monitoring-stack"
}

variable "tags" {
  description = "Tags applied to the instance for inventory and cost tracking."
  type        = list(string)
  default     = ["managed-by:terraform", "example:monitoring-stack-vm", "role:monitoring"]
}
