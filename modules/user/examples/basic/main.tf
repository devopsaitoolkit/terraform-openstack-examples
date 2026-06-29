variable "cloud" {
  description = "Name of the clouds.yaml entry to authenticate with."
  type        = string
  default     = "openstack"
}

module "user" {
  source = "../.."

  name    = "app-service-account"
  enabled = true

  role_assignments = [
    {
      role_name  = "member"
      project_id = "00000000000000000000000000000000"
    },
  ]
}
