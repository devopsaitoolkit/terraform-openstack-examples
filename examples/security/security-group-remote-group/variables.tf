variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "web_secgroup_name" {
  description = "Name of the web-tier security group."
  type        = string
  default     = "example-web"
}

variable "db_secgroup_name" {
  description = "Name of the database-tier security group."
  type        = string
  default     = "example-db"
}

variable "admin_ssh_cidr" {
  description = "CIDR allowed to SSH into the web tier. Scope to your admin/jump-host range, never 0.0.0.0/0."
  type        = string
  default     = "203.0.113.0/24"

  validation {
    condition     = var.admin_ssh_cidr != "0.0.0.0/0"
    error_message = "Refusing to expose SSH to the entire internet (0.0.0.0/0). Use a tightly scoped admin CIDR."
  }
}

variable "db_port" {
  description = "Database listener port the web tier connects to (PostgreSQL = 5432)."
  type        = number
  default     = 5432
}

variable "tags" {
  description = "Tags applied to both security groups."
  type        = list(string)
  default     = ["managed-by:terraform", "example:security-group-remote-group"]
}
