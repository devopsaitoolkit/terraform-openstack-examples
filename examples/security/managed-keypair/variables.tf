variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "keypair_name" {
  description = "Name of the Nova key pair to register."
  type        = string
  default     = "example-managed-key"
}

# We require an EXISTING public key. The matching private key is generated and
# kept by the operator (ssh-keygen / a hardware token / a secrets manager) and
# never touches Terraform. See the README for why this matters.
variable "public_key" {
  description = "OpenSSH-format public key to register (e.g. contents of ~/.ssh/id_ed25519.pub)."
  type        = string

  validation {
    condition     = can(regex("^(ssh-ed25519|ssh-rsa|ecdsa-sha2-) ", var.public_key))
    error_message = "public_key must be an OpenSSH public key starting with ssh-ed25519, ssh-rsa, or ecdsa-sha2-."
  }
}
