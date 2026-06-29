variable "cloud" {
  description = "Name of the cloud entry in clouds.yaml to use (via OS_CLOUD or the provider 'cloud' argument)."
  type        = string
  default     = "openstack"
}

variable "name_prefix" {
  description = "Name prefix for the VIP port, instance ports, and instances."
  type        = string
  default     = "keepalived"
}

variable "flavor_name" {
  description = "Name of the flavor (size) for each instance."
  type        = string
  default     = "m1.small"
}

variable "image_name" {
  description = "Name of the Glance image to boot from. The bootstrap assumes a Debian/Ubuntu base."
  type        = string
  default     = "ubuntu-22.04"
}

variable "network_name" {
  description = "Name of the tenant network the instances and VIP live on."
  type        = string
  default     = "private"
}

variable "subnet_name" {
  description = "Name of the subnet (inside network_name) the VIP is reserved from."
  type        = string
  default     = "private-subnet"
}

variable "vip_address" {
  description = "The shared virtual IP keepalived will float between the two nodes. Must be inside the subnet CIDR and OUTSIDE the DHCP allocation pool so Neutron never auto-assigns it."
  type        = string
  default     = "192.168.0.10"
}

variable "key_pair_name" {
  description = "Name of an existing OpenStack key pair to inject for SSH access. Leave empty to skip."
  type        = string
  default     = ""
}

variable "vrrp_interface" {
  description = "Guest network interface keepalived binds the VIP to (e.g. ens3 on most cloud images, eth0 on others)."
  type        = string
  default     = "ens3"
}

variable "vrrp_router_id" {
  description = "VRRP virtual_router_id (0-255). Must be unique per VRRP domain on the L2 segment."
  type        = number
  default     = 51
}

variable "vrrp_auth_pass" {
  description = "Shared VRRP authentication password for the pair (<= 8 chars for type PASS). Do not commit a real secret."
  type        = string
  default     = "changeit"
  sensitive   = true
}

variable "service_port" {
  description = "Application TCP port allowed to the VIP/instances (e.g. 80 for a web service)."
  type        = number
  default     = 80
}

variable "admin_ssh_cidr" {
  description = "CIDR allowed to SSH to the instances. Scope this to admins, not 0.0.0.0/0."
  type        = string
  default     = "10.0.0.0/24"
}

variable "tags" {
  description = "Tags applied to every instance for inventory and cost tracking."
  type        = list(string)
  default     = ["managed-by:terraform", "example:keepalived-vip", "role:ha"]
}
