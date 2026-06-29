module "security_group" {
  source = "../.."

  name        = "example-web"
  description = "Example public web tier"
  rules = [
    { direction = "ingress", ethertype = "IPv4", protocol = "tcp", port_min = 80, port_max = 80, remote_ip_prefix = "0.0.0.0/0" },
    { direction = "ingress", ethertype = "IPv4", protocol = "tcp", port_min = 443, port_max = 443, remote_ip_prefix = "0.0.0.0/0" },
    { direction = "ingress", ethertype = "IPv4", protocol = "tcp", port_min = 22, port_max = 22, remote_ip_prefix = "10.0.0.0/8" },
  ]
  tags = ["managed-by:terraform", "example:security-group-module"]
}
