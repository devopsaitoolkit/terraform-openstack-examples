variable "cloud" {
  description = "clouds.yaml entry to deploy the cluster nodes into."
  type        = string
  default     = "openstack"
}

variable "name_prefix" {
  description = "Prefix for all node names, e.g. <prefix>-control-0."
  type        = string
  default     = "kolla"
}

variable "network_name" {
  description = "Name of an existing management network to attach the nodes to."
  type        = string
  default     = "kolla-mgmt-net"
}

variable "control_count" {
  description = "Number of control-plane nodes (also used for the Kolla network/monitoring groups)."
  type        = number
  default     = 3
}

variable "compute_count" {
  description = "Number of compute nodes."
  type        = number
  default     = 2
}

variable "storage_count" {
  description = "Number of storage (Cinder/Ceph) nodes. 0 disables the storage group."
  type        = number
  default     = 0
}

variable "control_flavor" {
  description = "Flavor for control-plane nodes."
  type        = string
  default     = "m1.large"
}

variable "compute_flavor" {
  description = "Flavor for compute nodes."
  type        = string
  default     = "m1.xlarge"
}

variable "storage_flavor" {
  description = "Flavor for storage nodes."
  type        = string
  default     = "m1.large"
}

variable "image_name" {
  description = "Glance image to boot all nodes from."
  type        = string
  default     = "ubuntu-22.04"
}

variable "public_key" {
  description = "SSH public key injected into every node for Ansible access."
  type        = string
}

variable "security_group_names" {
  description = "Security groups attached to every node."
  type        = list(string)
  default     = ["default"]
}

variable "ansible_user" {
  description = "SSH user Ansible/Kolla connects as (rendered into the inventory)."
  type        = string
  default     = "ubuntu"
}

variable "inventory_output_path" {
  description = "Path on disk to write the rendered Kolla-Ansible inventory file (relative to the working directory)."
  type        = string
  default     = "generated/multinode"
}

variable "tags" {
  description = "Base tags applied to all nodes."
  type        = list(string)
  default     = ["managed-by:terraform", "example:kolla-inventory-output"]
}
