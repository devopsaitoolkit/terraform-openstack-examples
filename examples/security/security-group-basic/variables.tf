variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "secgroup_name" {
  description = "Name of the security group to create."
  type        = string
  default     = "example-basic-web"
}

variable "secgroup_description" {
  description = "Human-readable description of the security group's purpose."
  type        = string
  default     = "Basic least-privilege web security group (managed by Terraform)."
}

variable "admin_ssh_cidr" {
  description = "CIDR allowed to reach SSH (port 22). Scope this to your admin/jump-host range, never 0.0.0.0/0."
  type        = string
  default     = "203.0.113.0/24"

  validation {
    condition     = var.admin_ssh_cidr != "0.0.0.0/0"
    error_message = "Refusing to expose SSH to the entire internet (0.0.0.0/0). Use a tightly scoped admin CIDR."
  }
}

variable "https_cidr" {
  description = "CIDR allowed to reach HTTPS (port 443). For a public site this is intentionally 0.0.0.0/0."
  type        = string
  default     = "0.0.0.0/0"
}

variable "tags" {
  description = "Tags applied to the security group for inventory and ownership tracking."
  type        = list(string)
  default     = ["managed-by:terraform", "example:security-group-basic"]
}
