variable "cloud" {
  description = "Name of the clouds.yaml entry to authenticate with."
  type        = string
  default     = "openstack"
}

variable "vip_subnet_id" {
  description = "ID of the subnet to place the load balancer VIP on."
  type        = string
}

variable "member_subnet_id" {
  description = "ID of the subnet the backend members live on."
  type        = string
}

module "loadbalancer" {
  source = "../.."

  name              = "web-lb"
  vip_subnet_id     = var.vip_subnet_id
  listener_protocol = "HTTP"
  listener_port     = 80
  pool_method       = "ROUND_ROBIN"

  members = [
    { address = "10.0.0.11", protocol_port = 8080, subnet_id = var.member_subnet_id },
    { address = "10.0.0.12", protocol_port = 8080, subnet_id = var.member_subnet_id },
  ]

  monitor = {
    type        = "HTTP"
    delay       = 5
    timeout     = 3
    max_retries = 3
    url_path    = "/healthz"
  }

  tags = ["managed-by:terraform", "example:loadbalancer"]
}
