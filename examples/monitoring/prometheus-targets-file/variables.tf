variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "instance_count" {
  description = "Number of instances to create and register as Prometheus targets."
  type        = number
  default     = 3

  validation {
    condition     = var.instance_count > 0
    error_message = "instance_count must be at least 1."
  }
}

variable "name_prefix" {
  description = "Name prefix for the fleet; instances are named <prefix>-1, <prefix>-2, ..."
  type        = string
  default     = "metrics-target"
}

variable "flavor_name" {
  description = "Name of the flavor (size) for each instance, e.g. m1.small."
  type        = string
  default     = "m1.small"
}

variable "image_name" {
  description = "Name of the Glance image to boot from."
  type        = string
  default     = "ubuntu-22.04"
}

variable "network_name" {
  description = "Name of the tenant network to attach the instances to."
  type        = string
  default     = "private"
}

variable "key_pair_name" {
  description = "Name of an existing OpenStack key pair to inject for SSH access. Leave empty to skip."
  type        = string
  default     = ""
}

variable "security_group_names" {
  description = "Security groups to attach to each instance (the exporter must already be reachable on metrics_port)."
  type        = list(string)
  default     = ["default"]
}

variable "metrics_port" {
  description = "Port each instance exposes metrics on (node_exporter default is 9100)."
  type        = number
  default     = 9100
}

variable "job_label" {
  description = "Prometheus 'job' label applied to every target in the generated file_sd file."
  type        = string
  default     = "openstack-nodes"
}

variable "targets_file_path" {
  description = "Local path where the Prometheus file_sd targets JSON is written. Point Prometheus file_sd_configs at this path."
  type        = string
  default     = "./prometheus/targets.json"
}

variable "tags" {
  description = "Tags applied to every instance for inventory and cost tracking."
  type        = list(string)
  default     = ["managed-by:terraform", "example:prometheus-targets-file", "role:monitoring-target"]
}
