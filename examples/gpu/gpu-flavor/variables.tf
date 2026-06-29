variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use. Must hold the admin role: creating flavors is an admin-only operation."
  type        = string
  default     = "openstack"
}

variable "flavor_name" {
  description = "Name of the GPU flavor to create (e.g. 'g1.large')."
  type        = string
  default     = "g1.large"
}

variable "vcpus" {
  description = "Number of vCPUs for the flavor."
  type        = number
  default     = 8
}

variable "ram_mb" {
  description = "RAM for the flavor in MB."
  type        = number
  default     = 32768
}

variable "disk_gb" {
  description = "Root disk size for the flavor in GB."
  type        = number
  default     = 80
}

variable "is_public" {
  description = "Whether the flavor is visible to all projects. Keep false for scarce GPU flavors and grant access explicitly."
  type        = bool
  default     = false
}

# extra_specs are the key/value pairs that turn a plain flavor into a GPU flavor.
# Choose the keys that match your platform (PCI passthrough OR vGPU), plus the
# aggregate hint that keeps the workload on GPU hosts.
#
# PCI passthrough (whole GPU): "pci_passthrough:alias" = "<alias>:<count>"
#   where <alias> is defined in nova.conf [pci] on controller + compute.
# vGPU (time-sliced):          "resources:VGPU"        = "1"
#   backed by NVIDIA vGPU/mdev advertising VGPU inventory in Placement.
# Host aggregate steering:     "aggregate_instance_extra_specs:gpu" = "true"
#   matched by AggregateInstanceExtraSpecsFilter against aggregate metadata.
variable "extra_specs" {
  description = "Map of flavor extra_specs requesting GPU acceleration. Use pci_passthrough:alias for whole-GPU passthrough, or resources:VGPU for vGPU. Include an aggregate hint so the scheduler keeps the flavor on GPU hosts."
  type        = map(string)
  default = {
    "pci_passthrough:alias"              = "a100:1"
    "aggregate_instance_extra_specs:gpu" = "true"
    "hw:cpu_policy"                      = "dedicated"
  }
}

variable "server_group_name" {
  description = "Name of the server group created alongside the flavor (e.g. for anti-affinity across GPU hosts)."
  type        = string
  default     = "gpu-anti-affinity"
}

variable "server_group_policies" {
  description = "Scheduling policies for the server group. 'anti-affinity' spreads GPU instances across distinct hosts; 'affinity' packs them together."
  type        = list(string)
  default     = ["anti-affinity"]
}
