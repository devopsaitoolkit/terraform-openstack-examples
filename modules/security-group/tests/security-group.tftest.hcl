mock_provider "openstack" {}

run "creates_group_with_rules" {
  command = plan

  variables {
    name = "web-sg"
    rules = [
      { direction = "ingress", ethertype = "IPv4", protocol = "tcp", port_min = 443, port_max = 443, remote_ip_prefix = "0.0.0.0/0" },
      { direction = "ingress", ethertype = "IPv4", protocol = "tcp", port_min = 22, port_max = 22, remote_ip_prefix = "10.0.0.0/8" },
    ]
  }

  assert {
    condition     = output.security_group_name == "web-sg"
    error_message = "security_group_name output should equal var.name."
  }

  assert {
    condition     = length(openstack_networking_secgroup_rule_v2.this) == 2
    error_message = "Two rules should be created, one per entry in var.rules."
  }
}

run "rejects_invalid_direction" {
  command = plan

  variables {
    name = "bad-sg"
    rules = [
      { direction = "sideways", ethertype = "IPv4", protocol = "tcp" },
    ]
  }

  expect_failures = [var.rules]
}
