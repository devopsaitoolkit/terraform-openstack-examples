variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "domain_id" {
  description = "ID of the domain that owns all bootstrapped projects. Leave empty to use the provider/token default domain."
  type        = string
  default     = ""
}

variable "projects" {
  description = "Map of projects to create. The map key is the project name; each value carries its description, enabled flag and tags."
  type = map(object({
    description = string
    enabled     = bool
    tags        = list(string)
  }))
  default = {
    team-alpha = {
      description = "Project for team Alpha."
      enabled     = true
      tags        = ["managed-by:terraform", "team:alpha"]
    }
    team-beta = {
      description = "Project for team Beta."
      enabled     = true
      tags        = ["managed-by:terraform", "team:beta"]
    }
    team-sandbox = {
      description = "Shared sandbox project (disabled until needed)."
      enabled     = false
      tags        = ["managed-by:terraform", "env:sandbox"]
    }
  }
}
