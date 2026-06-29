variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use. An application credential is created for the AUTHENTICATED user of this cloud entry — it does NOT require admin."
  type        = string
  default     = "openstack"
}

variable "name" {
  description = "Name of the application credential. Unique per user."
  type        = string
  default     = "example-app-cred"
}

variable "description" {
  description = "Human-readable description of what this credential is for."
  type        = string
  default     = "Application credential managed by Terraform."
}

variable "roles" {
  description = "Optional subset of the user's roles to delegate to this credential (role names). Empty means all of the user's current roles. Prefer listing the minimum needed."
  type        = list(string)
  default     = []
}

variable "expires_at" {
  description = "Optional RFC3339 expiry timestamp, e.g. '2026-12-31T23:59:59Z'. Empty means it never expires (not recommended for automation)."
  type        = string
  default     = ""
}

variable "unrestricted" {
  description = "If true, the credential may create further credentials and trusts. Keep false — unrestricted credentials are effectively as powerful as the account password."
  type        = bool
  default     = false
}
