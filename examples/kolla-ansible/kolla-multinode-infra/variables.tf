variable "cloud" {
  description = "clouds.yaml entry to deploy the Kolla cluster infrastructure into."
  type        = string
  default     = "openstack"
}

variable "name_prefix" {
  description = "Prefix for all cluster resources, e.g. <prefix>-controller-0."
  type        = string
  default     = "kolla"
}

variable "network_name" {
  description = "Name of an existing management network to attach the nodes to (e.g. created by kolla-network-prereqs)."
  type        = string
  default     = "kolla-mgmt-net"
}

variable "controller_count" {
  description = "Number of controller (control-plane) nodes."
  type        = number
  default     = 3
}

variable "compute_count" {
  description = "Number of compute (hypervisor) nodes."
  type        = number
  default     = 2
}

variable "controller_flavor" {
  description = "Flavor for controller nodes (control plane is RAM/CPU heavy)."
  type        = string
  default     = "m1.large"
}

variable "compute_flavor" {
  description = "Flavor for compute nodes."
  type        = string
  default     = "m1.xlarge"
}

variable "image_name" {
  description = "Glance image to boot all nodes from (a Kolla-supported distro)."
  type        = string
  default     = "ubuntu-22.04"
}

variable "public_key" {
  description = "SSH public key material injected into every node for Ansible access."
  type        = string
}

variable "server_group_policy" {
  description = "Nova server-group policy for spreading nodes across hosts (anti-affinity or soft-anti-affinity)."
  type        = string
  default     = "soft-anti-affinity"
}

variable "tags" {
  description = "Base tags applied to all cluster resources."
  type        = list(string)
  default     = ["managed-by:terraform", "example:kolla-multinode-infra"]
}
