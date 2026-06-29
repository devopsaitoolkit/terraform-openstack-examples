mock_provider "openstack" {}

run "single_instance_defaults" {
  command = plan

  variables {
    name        = "web"
    flavor_name = "m1.small"
    image_name  = "ubuntu-22.04"
    network_id  = "11111111-1111-1111-1111-111111111111"
  }

  assert {
    condition     = length(output.instance_names) == 1
    error_message = "Default instance_count should create exactly one instance."
  }

  assert {
    condition     = output.instance_names[0] == "web"
    error_message = "A single instance should keep var.name with no index suffix."
  }
}

run "multiple_instances_are_suffixed" {
  command = plan

  variables {
    name           = "web"
    instance_count = 3
    flavor_name    = "m1.small"
    image_name     = "ubuntu-22.04"
    network_id     = "11111111-1111-1111-1111-111111111111"
  }

  assert {
    condition     = length(output.instance_names) == 3
    error_message = "instance_count = 3 should create three instances."
  }

  assert {
    condition     = output.instance_names[2] == "web-3"
    error_message = "Multiple instances should be suffixed with a 1-based index."
  }
}

run "rejects_zero_instances" {
  command = plan

  variables {
    name           = "web"
    instance_count = 0
    flavor_name    = "m1.small"
    image_name     = "ubuntu-22.04"
    network_id     = "11111111-1111-1111-1111-111111111111"
  }

  expect_failures = [var.instance_count]
}
