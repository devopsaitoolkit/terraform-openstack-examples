variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "bastion_secgroup_name" {
  description = "Name of the bastion (jump host) security group."
  type        = string
  default     = "example-bastion"
}

variable "app_secgroup_name" {
  description = "Name of the application security group reachable only via the bastion."
  type        = string
  default     = "example-app"
}

variable "bastion_admin_cidr" {
  description = "CIDR allowed to SSH into the bastion itself. Scope to admin/VPN; never 0.0.0.0/0."
  type        = string
  default     = "203.0.113.0/24"

  validation {
    condition     = var.bastion_admin_cidr != "0.0.0.0/0"
    error_message = "Refusing to expose the bastion's SSH to the entire internet (0.0.0.0/0)."
  }
}

variable "app_port" {
  description = "Application listener port (e.g. 8080) reachable from inside the app group's network."
  type        = number
  default     = 8080
}

variable "tags" {
  description = "Tags applied to both security groups."
  type        = list(string)
  default     = ["managed-by:terraform", "example:ssh-bastion-access"]
}
