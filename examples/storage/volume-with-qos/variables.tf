variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "qos_name" {
  description = "Name of the Cinder QoS specification."
  type        = string
  default     = "high-iops"
}

variable "qos_consumer" {
  description = "Where the QoS limits are enforced: front-end (Nova/hypervisor), back-end (Cinder driver), or both."
  type        = string
  default     = "front-end"
}

variable "qos_specs" {
  description = "Map of QoS specs (e.g. IOPS/throughput caps) applied to the volume type."
  type        = map(string)
  default = {
    read_iops_sec  = "2000"
    write_iops_sec = "1000"
  }
}

variable "volume_type_name" {
  description = "Name of the volume type the QoS spec is associated with."
  type        = string
  default     = "high-iops"
}

variable "volume_type_description" {
  description = "Human-readable description for the volume type."
  type        = string
  default     = "QoS-limited volume type"
}

variable "volume_name" {
  description = "Name of the Cinder volume created from the QoS-limited type."
  type        = string
  default     = "example-qos-volume"
}

variable "volume_size" {
  description = "Size of the volume in GiB."
  type        = number
  default     = 10
}
