module "networking" {
  source = "../.."

  name            = "example-net"
  cidr            = "192.168.42.0/24"
  dns_nameservers = ["1.1.1.1", "8.8.8.8"]
  allocation_pools = [
    { start = "192.168.42.10", end = "192.168.42.200" },
  ]
  tags = ["managed-by:terraform", "example:networking-module"]
}
