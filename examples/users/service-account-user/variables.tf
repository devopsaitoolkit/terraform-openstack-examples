variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "user_name" {
  description = "Name of the service account user to create."
  type        = string
  default     = "svc-automation"
}

variable "user_password" {
  description = "Bootstrap password for the service account. Prefer the application credential for machine auth."
  type        = string
  sensitive   = true
}

variable "project_id" {
  description = "ID of the project on which the service account's role is scoped."
  type        = string
}

variable "role_name" {
  description = "Name of the role to assign to the service account on the target project."
  type        = string
  default     = "member"
}

variable "app_credential_name" {
  description = "Name of the application credential created for the service account."
  type        = string
  default     = "svc-automation-cred"
}

variable "app_credential_expires_at" {
  description = "Optional RFC3339 expiry for the application credential (e.g. 2027-01-01T00:00:00Z). Empty means no expiry."
  type        = string
  default     = ""
}
