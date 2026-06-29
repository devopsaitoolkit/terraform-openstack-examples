mock_provider "openstack" {}

run "creates_network_and_subnet" {
  command = plan

  variables {
    name            = "app-net"
    cidr            = "10.0.10.0/24"
    dns_nameservers = ["1.1.1.1"]
    allocation_pools = [
      { start = "10.0.10.10", end = "10.0.10.200" },
    ]
  }

  assert {
    condition     = output.network_name == "app-net"
    error_message = "network_name output should equal var.name."
  }

  assert {
    condition     = output.cidr == "10.0.10.0/24"
    error_message = "cidr output should equal the configured CIDR."
  }

  assert {
    condition     = openstack_networking_subnet_v2.this.name == "app-net-subnet"
    error_message = "Subnet should be named <name>-subnet."
  }
}

run "rejects_invalid_cidr" {
  command = plan

  variables {
    name = "bad-net"
    cidr = "not-a-cidr"
  }

  expect_failures = [var.cidr]
}
