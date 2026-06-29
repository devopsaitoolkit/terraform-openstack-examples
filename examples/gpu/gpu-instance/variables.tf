variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "instance_name" {
  description = "Name of the GPU compute instance."
  type        = string
  default     = "gpu-instance-01"
}

variable "gpu_flavor_name" {
  description = "Name of an existing GPU-enabled flavor to boot on (e.g. 'g1.large'). The flavor must carry the extra_specs that request a PCI-passthrough GPU or a vGPU resource."
  type        = string
  default     = "g1.large"
}

variable "image_name" {
  description = "Name of the Glance image to boot. Should contain the appropriate NVIDIA/GPU drivers for the workload."
  type        = string
  default     = "ubuntu-22.04-cuda"
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

variable "availability_zone" {
  description = "Availability zone to schedule the GPU instance into. GPU hosts are commonly grouped into a dedicated AZ or host aggregate; leave empty to let the scheduler choose."
  type        = string
  default     = ""
}

variable "security_group_names" {
  description = "Security groups to attach to the instance."
  type        = list(string)
  default     = ["default"]
}

variable "user_data" {
  description = "Optional cloud-init user-data (e.g. to install/verify GPU drivers). Leave empty to skip."
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags applied to the instance for inventory and cost tracking."
  type        = list(string)
  default     = ["managed-by:terraform", "example:gpu-instance", "accel:gpu"]
}
