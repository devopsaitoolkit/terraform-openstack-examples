variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "instance_name" {
  description = "Name of the compute instance that will run node_exporter."
  type        = string
  default     = "example-node-exporter"
}

variable "flavor_name" {
  description = "Name of the flavor (size) for the instance, e.g. m1.small."
  type        = string
  default     = "m1.small"
}

variable "image_name" {
  description = "Name of the Glance image to boot from. node_exporter install assumes a Debian/Ubuntu base."
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
  description = "CIDR allowed to scrape node_exporter on port 9100 (e.g. your Prometheus server's subnet). Avoid 0.0.0.0/0 — node_exporter exposes host metrics."
  type        = string
  default     = "10.0.0.0/24"

  validation {
    condition     = var.monitoring_cidr != "0.0.0.0/0"
    error_message = "Refusing 0.0.0.0/0 for the metrics port: node_exporter leaks host detail and must only be scraped from a trusted CIDR."
  }
}

variable "node_exporter_version" {
  description = "Version of Prometheus node_exporter to install (without the leading 'v')."
  type        = string
  default     = "1.8.2"
}

variable "metrics_port" {
  description = "TCP port node_exporter listens on. The Prometheus default is 9100."
  type        = number
  default     = 9100
}

variable "security_group_name" {
  description = "Name for the security group that opens the metrics port."
  type        = string
  default     = "node-exporter"
}

variable "tags" {
  description = "Tags applied to the instance for inventory and cost tracking."
  type        = list(string)
  default     = ["managed-by:terraform", "example:instance-with-node-exporter", "role:monitoring-target"]
}
