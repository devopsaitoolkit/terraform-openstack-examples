variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use. The EC2 credential is created for the AUTHENTICATED user/project unless user_id/project_id are overridden (override requires admin)."
  type        = string
  default     = "openstack"
}

variable "user_id" {
  description = "UUID of the user to create the EC2 credential for. Leave empty to use the authenticated user. Setting another user requires admin."
  type        = string
  default     = ""
}

variable "project_id" {
  description = "UUID of the project the credential is scoped to. Leave empty to use the authenticated project."
  type        = string
  default     = ""
}
