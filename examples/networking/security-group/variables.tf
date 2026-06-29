variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "secgroup_name" {
  description = "Name of the security group to create."
  type        = string
  default     = "example-web-sg"
}

variable "ssh_cidr" {
  description = "CIDR allowed to reach SSH (tcp/22). Restrict this to your admin/bastion network."
  type        = string
  default     = "203.0.113.0/24"
}

variable "allowed_cidr" {
  description = "CIDR allowed to reach the web ports (tcp/80 and tcp/443)."
  type        = string
  default     = "0.0.0.0/0"
}
