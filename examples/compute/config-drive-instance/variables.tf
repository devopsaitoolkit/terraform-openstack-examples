variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "instance_name" {
  description = "Name of the compute instance."
  type        = string
  default     = "example-config-drive-instance"
}

variable "flavor_name" {
  description = "Name of the flavor (size) for the instance, e.g. m1.small."
  type        = string
  default     = "m1.small"
}

variable "image_name" {
  description = "Name of the Glance image to boot from."
  type        = string
  default     = "ubuntu-22.04"
}

variable "network_name" {
  description = "Name of the tenant network to attach the instance to."
  type        = string
  default     = "private"
}

variable "key_pair_name" {
  description = "Name of an existing OpenStack key pair to inject for SSH access. Leave empty to skip."
  type        = string
  default     = ""
}

variable "metadata" {
  description = "Key/value metadata exposed to the guest via the config drive."
  type        = map(string)
  default = {
    role        = "demo"
    provisioner = "terraform"
  }
}

variable "user_data" {
  description = "Cloud-init user-data (cloud-config or shell script) read off the config drive at first boot."
  type        = string
  default     = <<-EOT
    #cloud-config
    package_update: true
    write_files:
      - path: /etc/motd
        content: |
          Provisioned by Terraform via config drive.
    runcmd:
      - [ systemctl, enable, --now, qemu-guest-agent ]
  EOT
}

variable "security_group_names" {
  description = "Security groups to attach to the instance."
  type        = list(string)
  default     = ["default"]
}

variable "tags" {
  description = "Tags applied to the instance for inventory and cost tracking."
  type        = list(string)
  default     = ["managed-by:terraform", "example:config-drive-instance"]
}
