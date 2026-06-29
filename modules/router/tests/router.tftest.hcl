mock_provider "openstack" {}

run "creates_router_with_defaults" {
  command = plan

  variables {
    name                = "test-router"
    external_network_id = "ext-net-123"
  }

  assert {
    condition     = openstack_networking_router_v2.this.name == "test-router"
    error_message = "Router name should match the provided name."
  }

  assert {
    condition     = openstack_networking_router_v2.this.external_network_id == "ext-net-123"
    error_message = "Router should use the provided external network as gateway."
  }

  assert {
    condition     = openstack_networking_router_v2.this.enable_snat == true
    error_message = "SNAT should be enabled by default."
  }

  assert {
    condition     = openstack_networking_router_v2.this.admin_state_up == true
    error_message = "admin_state_up should default to true."
  }

  assert {
    condition     = length(openstack_networking_router_interface_v2.this) == 0
    error_message = "No interfaces should be created when subnet_ids is empty."
  }

  assert {
    condition     = output.external_gateway == "ext-net-123"
    error_message = "external_gateway output should expose the external network ID."
  }
}

run "attaches_subnet_interfaces" {
  command = plan

  variables {
    name                = "test-router"
    external_network_id = "ext-net-123"
    enable_snat         = false
    subnet_ids          = ["subnet-a", "subnet-b"]
  }

  assert {
    condition     = openstack_networking_router_v2.this.enable_snat == false
    error_message = "enable_snat = false should be honored."
  }

  assert {
    condition     = length(openstack_networking_router_interface_v2.this) == 2
    error_message = "One router interface should be created per subnet."
  }

  assert {
    condition     = openstack_networking_router_interface_v2.this["subnet-a"].subnet_id == "subnet-a"
    error_message = "Router interface should target its subnet."
  }
}
